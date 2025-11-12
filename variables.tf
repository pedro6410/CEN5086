# Variables
variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "bot_name" {
  description = "Name of the Lex bot"
  type        = string
  default     = "PartyPlanningAssistant"
}