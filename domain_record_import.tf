resource "linode_domain_record" "primary_domain_record" {
    domain_id   = 1657293
    port        = 0
    priority    = 0
    record_type = "A"
    target      = var.domain_record_ip
    ttl_sec     = 0
    weight      = 0 
}


variable domain_record_ip {}