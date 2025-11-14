# Bot Version (for deployment)
resource "aws_lexv2models_bot_version" "party_bot_version" {
  bot_id = aws_lexv2models_bot.party_bot.id

  locale_specification = {
    (aws_lexv2models_bot_locale.en_us.locale_id) = {
      source_bot_version = "DRAFT"
    }
  }

  depends_on = [
    #aws_lexv2models_intent.menu_selection,
    #aws_lexv2models_intent.music_playlist,
    #aws_lexv2models_intent.decoration_ideas,
    aws_lexv2models_intent.CompletePartyPlan
  ]
}
