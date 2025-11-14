# Slot Types

# Party Type Slot
resource "aws_lexv2models_slot_type" "party_type" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "PartyType"
  description = "Types of parties"

  slot_type_values {
    sample_value {
      value = "birthday"
    }
  }

  slot_type_values {
    sample_value {
      value = "wedding"
    }
  }

  slot_type_values {
    sample_value {
      value = "corporate"
    }
  }

  slot_type_values {
    sample_value {
      value = "cocktail party"
    }
  }

  slot_type_values {
    sample_value {
      value = "dinner party"
    }
  }

  slot_type_values {
    sample_value {
      value = "baby shower"
    }
  }

  slot_type_values {
    sample_value {
      value = "graduation"
    }
  }

  slot_type_values {
    sample_value {
      value = "anniversary"
    }
  }

  slot_type_values {
    sample_value {
      value = "holiday party"
    }
  }

  slot_type_values {
    sample_value {
      value = "retirement"
    }
  }

  value_selection_setting {
    resolution_strategy = "OriginalValue"
  }
}

# Dietary Restrictions Slot
resource "aws_lexv2models_slot_type" "dietary_restrictions" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "DietaryRestrictions"
  description = "Dietary restrictions"

  slot_type_values {
    sample_value {
      value = "vegetarian"
    }
  }

  slot_type_values {
    sample_value {
      value = "vegan"
    }
  }

  slot_type_values {
    sample_value {
      value = "gluten-free"
    }
  }

  slot_type_values {
    sample_value {
      value = "dairy-free"
    }
  }

  slot_type_values {
    sample_value {
      value = "nut-free"
    }
  }

  slot_type_values {
    sample_value {
      value = "halal"
    }
  }

  slot_type_values {
    sample_value {
      value = "kosher"
    }
  }

  slot_type_values {
    sample_value {
      value = "none"
    }
  }

  value_selection_setting {
    resolution_strategy = "OriginalValue"
  }
}

# Music Genre Slot
resource "aws_lexv2models_slot_type" "music_genre" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "MusicGenre"
  description = "Music genres"

  slot_type_values {
    sample_value {
      value = "pop"
    }
  }

  slot_type_values {
    sample_value {
      value = "rock"
    }
  }

  slot_type_values {
    sample_value {
      value = "jazz"
    }
  }

  slot_type_values {
    sample_value {
      value = "classical"
    }
  }

  slot_type_values {
    sample_value {
      value = "hip-hop"
    }
  }

  slot_type_values {
    sample_value {
      value = "country"
    }
  }

  slot_type_values {
    sample_value {
      value = "electronic"
    }
  }

  slot_type_values {
    sample_value {
      value = "latin"
    }
  }

  slot_type_values {
    sample_value {
      value = "mix"
    }
  }

  value_selection_setting {
    resolution_strategy = "OriginalValue"
  }
}

# Party Mood Slot
resource "aws_lexv2models_slot_type" "party_mood" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "PartyMood"
  description = "Party mood or atmosphere"

  slot_type_values {
    sample_value {
      value = "energetic"
    }
  }

  slot_type_values {
    sample_value {
      value = "relaxed"
    }
  }

  slot_type_values {
    sample_value {
      value = "elegant"
    }
  }

  slot_type_values {
    sample_value {
      value = "fun"
    }
  }

  slot_type_values {
    sample_value {
      value = "romantic"
    }
  }

  slot_type_values {
    sample_value {
      value = "sophisticated"
    }
  }

  value_selection_setting {
    resolution_strategy = "OriginalValue"
  }
}

# Color Scheme Slot
resource "aws_lexv2models_slot_type" "color_scheme" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "ColorScheme"
  description = "Color schemes for decorations"

  slot_type_values {
    sample_value {
      value = "gold and white"
    }
  }

  slot_type_values {
    sample_value {
      value = "pastels"
    }
  }

  slot_type_values {
    sample_value {
      value = "bold colors"
    }
  }

  slot_type_values {
    sample_value {
      value = "neutral tones"
    }
  }

  slot_type_values {
    sample_value {
      value = "black and gold"
    }
  }

  slot_type_values {
    sample_value {
      value = "pink and silver"
    }
  }

  slot_type_values {
    sample_value {
      value = "blue and white"
    }
  }

  slot_type_values {
    sample_value {
      value = "rainbow"
    }
  }

  value_selection_setting {
    resolution_strategy = "OriginalValue"
  }
}

# Budget Slot
resource "aws_lexv2models_slot_type" "budget" {
  bot_id      = aws_lexv2models_bot.party_bot.id
  bot_version = "DRAFT"
  locale_id   = aws_lexv2models_bot_locale.en_us.locale_id
  name        = "Budget"
  description = "Budget levels"

  slot_type_values {
    sample_value {
      value = "low"
    }
  }

  slot_type_values {
    sample_value {
      value = "medium"
    }
  }

  slot_type_values {
    sample_value {
      value = "high"
    }
  }

  value_selection_setting {
    resolution_strategy = "OriginalValue"
  }
}
