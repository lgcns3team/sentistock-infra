data "aws_route53_zone" "this" {
  name         = "${var.root_domain}."
  private_zone = false
}

resource "aws_route53_record" "frontend_a" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.frontend_domain
  type    = "A"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_zone_id
    evaluate_target_health = false
  }
}

resource "aws_route53_record" "frontend_aaaa" {
  zone_id = data.aws_route53_zone.this.zone_id
  name    = var.frontend_domain
  type    = "AAAA"

  alias {
    name                   = var.cf_domain_name
    zone_id                = var.cf_zone_id
    evaluate_target_health = false
  }
}
