locals {
  redirector_source_subdomain_name = "subdomain.${var.redirector_source_domain_name}"
  redirector_fixed_domain_name     = "fixed.${local.redirector_source_subdomain_name}"
}
