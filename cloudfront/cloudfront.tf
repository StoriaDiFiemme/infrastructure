data "aws_s3_bucket" "naked" {
  bucket = "www.storiadifiemme.it"
}

data "aws_acm_certificate" "star" {
  domain   = "storiadifiemme.it"
  provider = aws.us-east-1
}

resource "aws_cloudfront_origin_access_identity" "oai" {
  comment = "access-identity-${data.aws_s3_bucket.naked.bucket_regional_domain_name}"
}

resource "aws_cloudfront_distribution" "blog" {
  origin {
    domain_name = data.aws_s3_bucket.naked.bucket_regional_domain_name
    origin_id   = data.aws_s3_bucket.naked.bucket_regional_domain_name

    s3_origin_config {
      origin_access_identity = resource.aws_cloudfront_origin_access_identity.oai.cloudfront_access_identity_path
    }
  }

  default_root_object = "index.html"
  aliases             = ["www.storiadifiemme.it", "storiadifiemme.it"]
  price_class         = "PriceClass_100"

  enabled         = true
  is_ipv6_enabled = true

  default_cache_behavior {
    allowed_methods = ["GET", "HEAD"]
    cached_methods  = ["GET", "HEAD"]

    # https://docs.aws.amazon.com/AmazonCloudFront/latest/DeveloperGuide/using-managed-cache-policies.html
    cache_policy_id        = "658327ea-f89d-4fab-a63d-7e88639e58f6"
    compress               = true
    viewer_protocol_policy = "redirect-to-https"
    target_origin_id       = data.aws_s3_bucket.naked.bucket_regional_domain_name
  }

  restrictions {
    geo_restriction {
      restriction_type = "none"
    }
  }

  viewer_certificate {
    acm_certificate_arn      = data.aws_acm_certificate.star.arn
    minimum_protocol_version = "TLSv1.2_2019"
    ssl_support_method       = "sni-only"
  }
}

