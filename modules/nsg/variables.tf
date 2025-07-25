variable "name" {
  description = "Name of the NSG"
  type        = string
}

variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Name of the resource group"
  type        = string
}

variable "rules" {
  description = <<EOF
  List of security rules. Each object should include:
    - name: rule name
    - priority: integer (lower numbers are evaluated first)
    - direction: "Inbound" or "Outbound"
    - access: "Allow" or "Deny"
    - protocol: "Tcp", "Udp", or "*"
    - source_address_prefix: CIDR or tag ("Internet", etc.)
    - destination_ports: list of destination port numbers as strings
  EOF
  type = list(object({
    name                    = string
    priority                = number
    direction               = string
    access                  = string
    protocol                = string
    source_address_prefix   = string
    destination_ports       = list(string)
  }))
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

