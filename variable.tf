variable "env" {
  default = "prd"
}

variable "service" {
  default = "aws-alb-redirector"
}

variable "redirector_source_domain_name" {
  default = "test-penguin.net"
}

variable "redirector_default_destination_domain_name" {
  default = "example.com"
}

variable "redirector_subdomain_destination_domain_name" {
  default = "example.net"
}
