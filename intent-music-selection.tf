# Music Playlist Intent
resource "aws_lexv2models_intent" "music_playlist" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "MusicPlaylist"
  description = "Help users create music playlists for their party"

  sample_utterance {
    utterance = "I need music suggestions"
  }

  sample_utterance {
    utterance = "Help me with the playlist"
  }

  sample_utterance {
    utterance = "What music should I play"
  }

  sample_utterance {
    utterance = "Create a playlist for my party"
  }

  sample_utterance {
    utterance = "Music recommendations please"
  }

  sample_utterance {
    utterance = "What songs should I have"
  }

  sample_utterance {
    utterance = "I need party music"
  }

  slot_priority {
    priority = 1
    slot_id  = "2AGSIG1U0P"
  }

  slot_priority {
    priority = 2
    slot_id  = "MJ4FNKG1C8"
  }

  slot_priority {
    priority = 3
    slot_id  = "Y3KBNULN5U"
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
              value = "Music selection  completed"
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
            value = "I will help you with music selection"
          }
        }
      }
    }
    next_step {
      dialog_action {
        slot_to_elicit = "PartyMood"
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
}

# Slots for Music Playlist Intent
resource "aws_lexv2models_slot" "music_party_type" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.music_playlist.intent_id
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
            value = "What type of party is this? For example: birthday, wedding, corporate, cocktail, or dinner party?"

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

resource "aws_lexv2models_slot" "music_genre" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.music_playlist.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "MusicGenre"
  slot_type_id = aws_lexv2models_slot_type.music_genre.slot_type_id


  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Random"

      message_group {
        message {
          plain_text_message {
            value = "What genre of music do you prefer? For example: pop, rock, jazz, classical, hip-hop, or mix?"
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

resource "aws_lexv2models_slot" "music_mood" {
  bot_id       = aws_lexv2models_bot.party_bot.id
  bot_version  = "DRAFT"
  intent_id    = aws_lexv2models_intent.music_playlist.intent_id
  locale_id    = aws_lexv2models_bot_locale.en_us.locale_id
  name         = "PartyMood"
  slot_type_id = aws_lexv2models_slot_type.party_mood.slot_type_id


  value_elicitation_setting {
    slot_constraint = "Required"
    prompt_specification {
      allow_interrupt            = true
      max_retries                = 1
      message_selection_strategy = "Random"

      message_group {
        message {
          plain_text_message {
            value = "What mood are you going for? Energetic, relaxed, elegant, or fun?"
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