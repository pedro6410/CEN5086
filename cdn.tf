###############################
# S3 Bucket for CloudFront Origin
###############################

resource "aws_s3_bucket" "party_bot_content" {
  bucket = "party-bot-content-${data.aws_caller_identity.current.account_id}"

  tags = {
    Name        = "PartyBotContent"
    Environment = "production"
    Purpose     = "PartyPlanning"
  }
}

# Block all public access to the bucket (CloudFront uses OAI instead)
resource "aws_s3_bucket_public_access_block" "party_bot_content" {
  bucket = aws_s3_bucket.party_bot_content.id

  block_public_acls       = true
  block_public_policy     = true
  ignore_public_acls      = true
  restrict_public_buckets = true
}

# Enable versioning (optional but recommended)
resource "aws_s3_bucket_versioning" "party_bot_content" {
  bucket = aws_s3_bucket.party_bot_content.id

  versioning_configuration {
    status = "Enabled"
  }
}

###############################
# CloudFront Origin Access Identity (OAI)
###############################

resource "aws_cloudfront_origin_access_identity" "party_bot_oai" {
  comment = "OAI for party-bot S3 bucket"
}

###############################
# S3 Bucket Policy - Allow CloudFront OAI to Read
###############################

resource "aws_s3_bucket_policy" "party_bot_content" {
  bucket = aws_s3_bucket.party_bot_content.id

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Sid    = "AllowCloudFrontOAI"
        Effect = "Allow"
        Principal = {
          AWS = aws_cloudfront_origin_access_identity.party_bot_oai.iam_arn
        }
        Action   = "s3:GetObject"
        Resource = "${aws_s3_bucket.party_bot_content.arn}/*"
      }
    ]
  })
}

###############################
# CloudFront Distribution
###############################

resource "aws_cloudfront_distribution" "party_bot_cdn" {
  origin {
    domain_name = aws_s3_bucket.party_bot_content.bucket_regional_domain_name
    origin_id   = "party-bot-s3"

    s3_origin_config {
      origin_access_identity = aws_cloudfront_origin_access_identity.party_bot_oai.cloudfront_access_identity_path
    }
  }

  enabled = true

  # Default cache behavior
  default_cache_behavior {
    allowed_methods = ["GET", "HEAD", "OPTIONS"]
    cached_methods  = ["GET", "HEAD"]

    target_origin_id = "party-bot-s3"

    forwarded_values {
      query_string = false

      cookies {
        forward = "none"
      }
    }

    viewer_protocol_policy = "redirect-to-https"
    min_ttl                = 0
    default_ttl            = 3600
    max_ttl                = 86400

    compress = true
  }

  # Price class (use only US, Canada, Europe for cost savings)
  price_class = "PriceClass_100"

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    cloudfront_default_certificate = true
  }

  tags = {
    Name        = "PartyBotCDN"
    Environment = "production"
    Purpose     = "PartyPlanning"
  }
}

# Data source to get current AWS account ID for bucket naming
data "aws_caller_identity" "current" {}

###############################
# Outputs
###############################

output "s3_bucket_name" {
  value       = aws_s3_bucket.party_bot_content.id
  description = "Name of the S3 bucket used as CloudFront origin"
}

output "s3_bucket_arn" {
  value       = aws_s3_bucket.party_bot_content.arn
  description = "ARN of the S3 bucket"
}

output "cloudfront_distribution_id" {
  value       = aws_cloudfront_distribution.party_bot_cdn.id
  description = "CloudFront distribution ID"
}

output "cloudfront_domain_name" {
  value       = aws_cloudfront_distribution.party_bot_cdn.domain_name
  description = "CloudFront distribution domain name (e.g., d1234567890.cloudfront.net)"
}

output "cloudfront_oai_arn" {
  value       = aws_cloudfront_origin_access_identity.party_bot_oai.iam_arn
  description = "ARN of the CloudFront Origin Access Identity"
}


###############################
# S3 object for index.html + invalidation automation
###############################

# Upload the local file `scripts/index.html` to the bucket and set cache control to no-cache for immediate revalidation.
resource "aws_s3_bucket_object" "index_html" {
  bucket       = aws_s3_bucket.party_bot_content.id
  key          = "index.html"
  source       = "${path.module}/scripts/index.html"
  content_type = "text/html; charset=utf-8"
  cache_control = "no-cache, max-age=0, must-revalidate"
}

# Create a CloudFront invalidation when the file changes (or distribution id changes).
resource "null_resource" "invalidate_index_html" {
  triggers = {
    index_html_hash  = filebase64sha256("${path.module}/scripts/index.html")
    distribution_id  = aws_cloudfront_distribution.party_bot_cdn.id
  }

  depends_on = [aws_s3_bucket_object.index_html, aws_cloudfront_distribution.party_bot_cdn]

  provisioner "local-exec" {
    # This requires AWS CLI v2 installed and configured (same credentials/environment you use for Terraform).
    command = <<EOT
echo "Creating CloudFront invalidation for /index.html on distribution ${aws_cloudfront_distribution.party_bot_cdn.id}"
aws cloudfront create-invalidation --distribution-id ${aws_cloudfront_distribution.party_bot_cdn.id} --paths "/index.html"
EOT
  }
}
