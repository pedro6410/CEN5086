# Lex V2 Bot
resource "aws_lexv2models_bot" "party_bot" {
  name     = var.bot_name
  role_arn = aws_iam_role.lex_bot_role.arn

  data_privacy {
    child_directed = false
  }

  idle_session_ttl_in_seconds = 300

  tags = {
    Environment = "production"
    Purpose     = "PartyPlanning"
  }
}

# Bot Locale (English-US)
resource "aws_lexv2models_bot_locale" "en_us" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = "en_US"

  n_lu_intent_confidence_threshold = 0.40

  voice_settings {
    voice_id = "Joanna"
  }
}