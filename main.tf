terraform {
  required_providers {
    nsxt = {
      source = "vmware/nsxt"
    }
  }
}
# NSX-T Manager Credentials
provider "nsxt" {
  host                  = var.nsx_manager
  username              = var.username
  password              = var.password
  allow_unverified_ssl  = true
  max_retries           = 10
  retry_min_delay       = 500
  retry_max_delay       = 5000
  retry_on_status_codes = [429]
}

# Create Security Policies

# DFW Infrastructure Category Rules
resource "nsxt_policy_security_policy" "Infrastructure" {
  display_name = "Infrastructure"
  description  = "Terraform provisioned Security Policy"
  category     = "Infrastructure"
  locked       = false
  stateful     = true
  tcp_strict   = false

  rule {
    display_name = "Allow DHCP"
    action       = "ALLOW"
    services     = ["/infra/services/DHCP-Server", "/infra/services/DHCP-Client"]
    logged       = false
    notes        = "Allow access to DHCP Server"
  }
}
