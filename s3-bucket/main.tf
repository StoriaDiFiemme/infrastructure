data "aws_iam_policy_document" "bucket_policy" {
  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = ["arn:aws:s3:::www.storiadifiemme.it/*"]

    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
  }

  statement {
    actions = [
      "s3:GetObject"
    ]

    resources = ["arn:aws:s3:::www.storiadifiemme.it/*"]

    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::cloudfront:user/CloudFront Origin Access Identity E1XTHLVGCQX948"]
    }
  }
}

resource "aws_s3_bucket" "naked" {
  bucket = "storiadifiemme.it"

  website {
    redirect_all_requests_to = "www.storiadifiemme.it"
  }
}

resource "aws_s3_bucket" "www" {
  bucket = "www.storiadifiemme.it"

  acl    = "public-read"
  policy = data.aws_iam_policy_document.bucket_policy.json

  website {
    index_document = "index.html"
  }

  server_side_encryption_configuration {
    rule {
      bucket_key_enabled = false

      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }

  versioning {
    enabled = true
  }
}

