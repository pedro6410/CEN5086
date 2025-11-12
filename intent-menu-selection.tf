# Menu Selection Intent
resource "aws_lexv2models_intent" "menu_selection" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "MenuSelection"
  description = "Help users select menu options for their party"

  sample_utterance {
    utterance = "I need help with the menu"
  }

  sample_utterance {
    utterance = "What should I serve at my party"
  }

  sample_utterance {
    utterance = "Help me pick food"
  }

  sample_utterance {
    utterance = "Menu suggestions please"
  }

  sample_utterance {
    utterance = "What food should I have"
  }

  sample_utterance {
    utterance = "I need catering ideas"
  }

  sample_utterance {
    utterance = "Suggest some dishes"
  }

  fulfillment_code_hook {
    active  = true
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
              value = "Food selection completed"
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

    initial_response {
      allow_interrupt = true
      message_group {
        message {
          plain_text_message {
            value = "I will help you with the food selection"
          }
        }
      }
    }
    next_step {
      dialog_action {
        slot_to_elicit = "PartyType"
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
            value = "May I proceed with food selection?"
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


  # PartyType Slot
  slot_priority {
    priority = 1
    slot_id  = "49NAGIOVGU"
  }

  # GuestCount Slot
  slot_priority {
    priority = 2
    slot_id  = "DACGJU9VEO"
  }

  # DietaryRestrictions Slot
  slot_priority {
    priority = 3
    slot_id  = "PJWA1VB5QD"
  }

}

# Slots for Menu Selection Intent
resource "aws_lexv2models_slot" "menu_party_type" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.menu_selection.intent_id
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
            value = "What type of party are you planning? For example: birthday, wedding, corporate, cocktail, or dinner party?"
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





resource "aws_lexv2models_slot" "menu_guest_count" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.menu_selection.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "GuestCount"
  slot_type_id = "AMAZON.Number"


  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Random"

      message_group {
        message {
          plain_text_message {
            value = "How many guests are you expecting?"
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

resource "aws_lexv2models_slot" "menu_dietary" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.menu_selection.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "DietaryRestrictions"
  slot_type_id = aws_lexv2models_slot_type.dietary_restrictions.slot_type_id


  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Random"

      message_group {
        message {
          plain_text_message {
            value = "Are there any dietary restrictions I should know about? Such as vegetarian, vegan, gluten-free, or none?"

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
