# Create the Certificate
resource "aws_acm_certificate" "naked" {
  domain_name = "storiadifiemme.it"
  subject_alternative_names = [
    "*.storiadifiemme.it"
  ]
  validation_method = "DNS"

  tags = {
    "managed_by" = "Terraform"
  }

  lifecycle {
    create_before_destroy = true
  }

  provider = aws.us-east-1
}

# DNS Record for Validation
resource "aws_route53_record" "naked_validation" {
  allow_overwrite = true
  name            = tolist(aws_acm_certificate.naked.domain_validation_options)[0].resource_record_name
  records         = [tolist(aws_acm_certificate.naked.domain_validation_options)[0].resource_record_value]
  type            = tolist(aws_acm_certificate.naked.domain_validation_options)[0].resource_record_type
  zone_id         = data.aws_route53_zone.main.id
  ttl             = 60
}

# Do the validation
resource "aws_acm_certificate_validation" "naked_validation" {
  certificate_arn         = aws_acm_certificate.naked.arn
  validation_record_fqdns = [aws_route53_record.naked_validation.fqdn]

  provider = aws.us-east-1
}
