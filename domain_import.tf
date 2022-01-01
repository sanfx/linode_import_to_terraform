resource "linode_domain" "primary_domain" {
  domain = var.primary_domain_name
  soa_email = var.domain_soa_email
  type = "master"
}


variable domain_soa_email {}
variable primary_domain_name {}