# Outputs
output "bot_id" {
  description = "The ID of the Lex bot"
  value       = aws_lexv2models_bot.party_bot.id
}

output "bot_arn" {
  description = "The ARN of the Lex bot"
  value       = aws_lexv2models_bot.party_bot.arn
}

output "bot_name" {
  description = "The name of the Lex bot"
  value       = aws_lexv2models_bot.party_bot.name
}