# IAM Role for Lex Bot
resource "aws_iam_role" "lex_bot_role" {
  name = "${var.bot_name}-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "lexv2.amazonaws.com"
        }
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "lex_bot_policy" {
  role       = aws_iam_role.lex_bot_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonLexRunBotsOnly"
}
