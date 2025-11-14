###############################
# Lambda to fulfill CompletePartyPlan
###############################

# Build deployment zip from source using the archive provider
data "archive_file" "complete_party_plan" {
  type       = "zip"
  # package the entire lambda directory so helper modules can be included
  source_dir = "${path.module}/lambda/complete_party_plan"
  # write deployment artifact into the lambda folder
  output_path = "${path.module}/lambda/complete_party_plan/deployment.zip"
}

# IAM role for Lambda
resource "aws_iam_role" "lambda_exec" {
  name = "cen5086_lambda_exec_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lambda.amazonaws.com"
        }
      }
    ]
  })
}

# Attach AWS managed policy for basic Lambda execution (logs)
resource "aws_iam_role_policy_attachment" "lambda_basic_exec" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AWSLambdaBasicExecutionRole"
}

#attach policy for lambda to call bedrock service
resource "aws_iam_role_policy_attachment" "lambda_bedrock_access" {
  role       = aws_iam_role.lambda_exec.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonBedrockFullAccess"
}

# Lambda function
resource "aws_lambda_function" "complete_party_plan" {
  filename         = data.archive_file.complete_party_plan.output_path
  function_name    = "CompletePartyPlanFunction"
  role             = aws_iam_role.lambda_exec.arn
  handler          = "handler.lambda_handler"
  runtime          = "python3.14"
  source_code_hash = data.archive_file.complete_party_plan.output_base64sha256

  # small timeout; adjust if you do more work
  timeout = 300
}

# Allow Lex to invoke the function. For Lex V2 use principal 'lexv2.amazonaws.com'.
resource "aws_lambda_permission" "allow_lex" {
  statement_id  = "AllowExecutionFromLexV2"
  action        = "lambda:InvokeFunction"
  function_name = aws_lambda_function.complete_party_plan.function_name
  principal     = "lexv2.amazonaws.com"
}

output "complete_party_plan_lambda_arn" {
  value       = aws_lambda_function.complete_party_plan.arn
  description = "ARN of the CompletePartyPlan Lambda function. Use this in your Lex intent fulfillment_code_hook.lambda_arn."
}

# Null resource that uses the AWS CLI to attach the Lambda ARN to the Lex V2 intent.
# Terraform's aws_lexv2models_intent block in this provider version may not expose the
# lambda ARN attribute directly, so we perform the update via the AWS CLI after the
# Lambda and Intent are created.
# resource "null_resource" "attach_lambda_to_intent" {
#   # re-run when either ARN or intent id changes
#   triggers = {
#     lambda_arn = aws_lambda_function.complete_party_plan.arn
#     intent_id  = aws_lexv2models_intent.CompletePartyPlan.intent_id
#     bot_id     = aws_lexv2models_bot.party_bot.id
#     locale_id  = aws_lexv2models_bot_locale.en_us.locale_id
#   }

#   depends_on = [
#     aws_lambda_function.complete_party_plan,
#     aws_lexv2models_intent.CompletePartyPlan,
#   ]

#   provisioner "local-exec" {
#     interpreter = ["/bin/bash", "-c"]
#     command = <<EOT
# set -e
# echo "Updating Lex intent to set fulfillment Lambda..."
# aws lexv2-models update-intent \
#   --bot-id ${aws_lexv2models_bot.party_bot.id} \
#   --bot-version DRAFT \
#   --locale-id ${aws_lexv2models_bot_locale.en_us.locale_id} \
#   --intent-id ${aws_lexv2models_intent.CompletePartyPlan.intent_id} \
#   --intent-name CompletePartyPlan \
#   --fulfillment-code-hook '{"enabled":true,"lambdaArn":"${aws_lambda_function.complete_party_plan.arn}"}'
# echo "Lex intent updated."
# EOT
#   }
# }
