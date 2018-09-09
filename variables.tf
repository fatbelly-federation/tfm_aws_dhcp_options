################################# VARIABLES ######################################

variable "remote_state_bucket" {
  description = "Bucket in that stores the terraform state file in s3"
}

variable "dynamodb_table" {
  description = "The name of the dynamodb table used for locking"
}

variable "primary_state_region" {
  description = "the region that the remote state file resides in"
}


variable "region" {
  description = "AWS region we are performing our actions in"
}

variable "tags" {
  type = "map"
  description = "map(list) of tags to add to everything we create with this module"
  default = {
    "terraform" = "true"
  }
}

variable "dhcp_options_name" {
  description = "Name of DHCP options set. Defaults to <vpc_name>_dhcp_option_set"
  default = ""
}

variable "dhcp_options_domain_name" {
  description = "Domain name to set in DHCP options -- defaults to var.domain_name"
  default = 0
}

variable "dhcp_options_domain_name_servers" {
  # ref: https://docs.aws.amazon.com/vpc/latest/userguide/VPC_DHCP_Options.html#AmazonDNS
  type = "list"
  default = ["AmazonProvidedDNS"]
  description = "Domain name servers if overriding DHCP options"
}

variable "dhcp_options_ntp_servers" {
  # ref: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/set-time.html#configure_ntp
  description = "Specify a list of NTP servers for DHCP options set"
  type        = "list"
  default     = ["169.254.169.123"]
}

variable "default_domain_name" {
  # this should be pulled from a parent config file (e.g. vpc-common.tfvars)
  description = "default domain name to use if dhcp_options_domain_name is *not* set"
}

variable "vpc_id" {
  type = "string"
  description = "VPC to attach DHCP options to -- will default to value pulled from remote state"
  default = 0
}

variable "vpc_name" {
  description = "name of the VPC"
}

