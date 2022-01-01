resource "linode_domain" "primary_domain" {
  domain = var.primary_domain_name
  soa_email = var.domain_soa_email
  type = "master"
}


variable domain_soa_email {
  type = string
  sensitive = false
}
variable primary_domain_name {
  type = string
  default = "devilsan.com"
  sensitive = false
}