###############################
# Cognito Identity Pool (Unauthenticated)
###############################

resource "aws_cognito_identity_pool" "party_bot_pool" {
  identity_pool_name             = "party_bot_pool"
  allow_unauthenticated_identities = true

  tags = {
    Name        = "PartyBotPool"
    Environment = "production"
    Purpose     = "PartyPlanning"
  }
}

###############################
# IAM Role for Unauthenticated Users
###############################

resource "aws_iam_role" "cognito_unauthenticated" {
  name = "party_bot_cognito_unauthenticated_role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Principal = {
          Federated = "cognito-identity.amazonaws.com"
        }
        Action = "sts:AssumeRoleWithWebIdentity"
        Condition = {
          StringEquals = {
            "cognito-identity.amazonaws.com:aud" = aws_cognito_identity_pool.party_bot_pool.id
          }
          "ForAllValues:StringLike" = {
            "cognito-identity.amazonaws.com:sub" = "*"
          }
        }
      }
    ]
  })
}

###############################
# IAM Policy - Allow Lex V2 Access
###############################

resource "aws_iam_role_policy" "cognito_lex_policy" {
  name = "party_bot_cognito_lex_policy"
  role = aws_iam_role.cognito_unauthenticated.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect = "Allow"
        Action = [
          "lex:RecognizeText",
          "lex:PostText"
        ]
        Resource = "*"
      }
    ]
  })
}

###############################
# Cognito Identity Pool Roles Attachment
###############################

resource "aws_cognito_identity_pool_roles_attachment" "party_bot_roles" {
  identity_pool_id = aws_cognito_identity_pool.party_bot_pool.id

  roles = {
    unauthenticated = aws_iam_role.cognito_unauthenticated.arn
  }
}

###############################
# Outputs - for index.html configuration
###############################

output "cognito_identity_pool_id" {
  value       = aws_cognito_identity_pool.party_bot_pool.id
  description = "Cognito Identity Pool ID for unauthenticated access. Use in index.html CONFIG.cognitoIdentityPoolId"
}

output "cognito_unauthenticated_role_arn" {
  value       = aws_iam_role.cognito_unauthenticated.arn
  description = "ARN of the unauthenticated role"
}

output "lex_bot_configuration" {
  value = {
    region         = var.aws_region
    bot_id         = aws_lexv2models_bot.party_bot.id
    locale_id      = aws_lexv2models_bot_locale.en_us.locale_id
  }
  description = "Lex bot configuration values for index.html. You will need to get the botAliasId from the AWS Console."
}
