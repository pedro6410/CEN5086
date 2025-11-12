resource "aws_lexv2models_intent" "CompletePartyPlan" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "CompletePartyPlan"
  description = "Help plan all aspects of the party"

  sample_utterance {
    utterance = "Help me plan my entire party"
  }

  sample_utterance {
    utterance = "I need help with everything"
  }

  sample_utterance {
    utterance = "Plan my whole party"
  }

  sample_utterance {
    utterance = "Complete party planning help"
  }

  sample_utterance {
    utterance = "I need a full party plan"
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
            value = "np."
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
            value = "May I proceed with the request?"
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
      timeout_next_step {
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
              value = "party planned"
            }
          }
        }
      }
    }
  }
  initial_response_setting {
    code_hook {
      active                      = false
      enable_code_hook_invocation = true
      post_code_hook_specification {
        failure_next_step {
          dialog_action {
            type = "EndConversation"
          }
          intent {

          }
        }
        success_next_step {
          dialog_action {
            type = "FulfillIntent"
          }
          intent {

          }
        }
        timeout_next_step {
          dialog_action {
            type = "EndConversation"
          }
          intent {

          }
        }
      }
    }
    initial_response {
      allow_interrupt = true
      message_group {
        message {
          plain_text_message {
            value = "Okay, I will help planning the party"
          }
        }
      }
    }
    next_step {
      dialog_action {
        suppress_next_message = true
        slot_to_elicit = "partyType"
        type           = "ElicitSlot"
      }
      intent {

      }
    }
  }


  slot_priority {
    priority = 1
    slot_id  = "OLTSVETX4V"
  }

  slot_priority {
    priority = 2
    slot_id  = "SHJVOUK97M"
  }


}


resource "aws_lexv2models_slot" "party_type" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.CompletePartyPlan.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "partyType"
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
            value = "What type of party are you planning?"
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


resource "aws_lexv2models_slot" "party_guest_count" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.CompletePartyPlan.intent_id
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
            value = "How many guests will attend?"
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
