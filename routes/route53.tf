resource "aws_route53_zone" "blog" {
  name = "storiadifiemme.it"
}

data "aws_cloudfront_distribution" "blog" {
  id = "E11HEGC1R8IIFI"
}


resource "aws_route53_record" "naked" {
  zone_id = aws_route53_zone.blog.zone_id
  name    = "storiadifiemme.it"
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.blog.domain_name
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "www" {
  zone_id = aws_route53_zone.blog.zone_id
  name    = "www.storiadifiemme.it"
  type    = "A"

  alias {
    name                   = data.aws_cloudfront_distribution.blog.domain_name
    zone_id                = "Z2FDTNDATAQYW2"
    evaluate_target_health = false
  }
}
