# Decoration Ideas Intent
resource "aws_lexv2models_intent" "decoration_ideas" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "DecorationIdeas"
  description = "Provide decoration ideas for parties"

  sample_utterance {
    utterance = "I need decoration ideas"
  }

  sample_utterance {
    utterance = "Help me with decorations"
  }

  sample_utterance {
    utterance = "What decorations should I use"
  }

  sample_utterance {
    utterance = "Suggest party decorations"
  }

  sample_utterance {
    utterance = "How should I decorate"
  }

  sample_utterance {
    utterance = "Decoration recommendations please"
  }

  sample_utterance {
    utterance = "I need decor help"
  }

  fulfillment_code_hook {
    enabled = false
    post_fulfillment_status_specification {
      failure_next_step {
        dialog_action {
          type = "CloseIntent"
        }
        intent {

        }
      }
      failure_response {
        allow_interrupt = true
        message_group {
          message {
            plain_text_message {
              value = "Something went wrong"
            }
          }
        }
      }
      success_next_step {
        dialog_action {
          type = "CloseIntent"
        }
        intent {

        }
      }
      success_response {
        allow_interrupt = true
        message_group {
          message {
            plain_text_message {
              value = "Decoration ideas completed"
            }
          }
        }
      }
      timeout_next_step {
        dialog_action {
          type = "CloseIntent"
        }
        intent {

        }
      }
    }
  }
  initial_response_setting {
    initial_response {
      allow_interrupt = true
      message_group {
        message {
          plain_text_message {
            value = "Okay, I will help you with decoration ideas"
          }
        }
      }
    }
    code_hook {
      active                      = true
      enable_code_hook_invocation = true
      post_code_hook_specification {
        failure_next_step {
          dialog_action {
            type = "EndConversation"
          }
        }
        success_next_step {
          dialog_action {
            type = "FulfillIntent"
          }
        }
        timeout_next_step {
          dialog_action {
            type = "EndConversation"
          }
        }
      }
    }
    next_step {
      dialog_action {
        slot_to_elicit = "Budget"
        type           = "ElicitSlot"
      }
      intent {

      }
    }
  }

  closing_setting {
    active = true
    closing_response {
      allow_interrupt = true
      message_group {
        message {
          plain_text_message {
            value = "Thanks"
          }
        }
      }
    }
    next_step {
      dialog_action {
        type = "EndConversation"
      }
      intent {

      }
    }
  }

  confirmation_setting {
    active = true
    confirmation_next_step {
      dialog_action {
        type = "FulfillIntent"
      }
      intent {

      }
    }
    declination_next_step {
      dialog_action {
        type = "EndConversation"
      }
      intent {

      }
    }
    declination_response {
      allow_interrupt = true
      message_group {
        message {
          plain_text_message {
            value = "np"
          }
        }
      }
    }
    elicitation_code_hook {
      enable_code_hook_invocation = true
    }

    failure_next_step {
      dialog_action {
        type = "StartIntent"
      }
      intent {
        name = "FallbackIntent"
      }
    }
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 4
      message_selection_strategy = "Random"
      message_group {
        message {
          plain_text_message {
            value = "May I proceed with decoration ideas?"
          }
        }
      }
      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Initial"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }
      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry1"
        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }
        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000
          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }
          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }

        }
        text_input_specification {
          start_timeout_ms = 30000
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry2"
        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }
        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000
          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }
          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }

        }
        text_input_specification {
          start_timeout_ms = 30000
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry3"
        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }
        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000
          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }
          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }

        }
        text_input_specification {
          start_timeout_ms = 30000
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry4"
        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }
        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000
          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }
          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }

        }
        text_input_specification {
          start_timeout_ms = 30000
        }
      }
    }
  }

  slot_priority {
    priority = 1
    slot_id  = "JTAQ2ATKMN"
  }

  slot_priority {
    priority = 2
    slot_id  = "RT2XAW5SPH"
  }

  slot_priority {
    priority = 3
    slot_id  = "ZCPPKHEDIL"
  }



  #   intent_closing_setting {
  #     closing_response {
  #       message_group {
  #         message {
  #           plain_text_message {
  #             value = "Wonderful! For your {PartyType} with a {ColorScheme} theme and {Budget} budget:\n\n✨ Balloons and streamers in your color scheme\n✨ String lights or fairy lights for ambiance\n✨ Table centerpieces with flowers or candles\n✨ Photo booth area with props\n✨ Welcome sign at entrance\n✨ Themed banners or garlands\n\nWould you like help with menu or music too?"
  #           }
  #         }
  #       }
  #     }
  #   }
}

# Slots for Decoration Ideas Intent
resource "aws_lexv2models_slot" "decor_party_type" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.decoration_ideas.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "PartyType"
  slot_type_id = aws_lexv2models_slot_type.party_type.slot_type_id


  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Random"

      message_group {
        message {
          plain_text_message {
            value = "What type of party are you decorating for?"
          }
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Initial"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry1"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }

    }
  }


}

resource "aws_lexv2models_slot" "decor_color_scheme" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.decoration_ideas.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "ColorScheme"
  slot_type_id = aws_lexv2models_slot_type.color_scheme.slot_type_id


  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Random"

      message_group {
        message {
          plain_text_message {
            value = "Do you have a color scheme in mind? For example: gold and white, pastels, bold colors, or neutral tones?"

          }
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Initial"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry1"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }

    }
  }


}

resource "aws_lexv2models_slot" "decor_budget" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.decoration_ideas.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "Budget"
  slot_type_id = aws_lexv2models_slot_type.budget.slot_type_id


  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Random"

      message_group {
        message {
          plain_text_message {
            value = "What's your budget level? Low, medium, or high?"
          }
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Initial"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }

      prompt_attempts_specification {
        allow_interrupt = true
        map_block_key   = "Retry1"

        allowed_input_types {
          allow_audio_input = true
          allow_dtmf_input  = true
        }

        audio_and_dtmf_input_specification {
          start_timeout_ms = 4000

          audio_specification {
            end_timeout_ms = 640
            max_length_ms  = 15000
          }

          dtmf_specification {
            deletion_character = "*"
            end_character      = "#"
            end_timeout_ms     = 5000
            max_length         = 513
          }
        }

        text_input_specification {
          start_timeout_ms = 30000
        }
      }

    }
  }


}