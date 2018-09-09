##### Use to modify or attach DHCP options to an existing VPC ####

# ref: https://www.terraform.io/docs/configuration/locals.html
locals {
  # create a default name for the option set
  default_option_set_name = "${data.terraform_remote_state.vpc.vpc_name}_dhcp_option_set"
  # if var.dhcp_option_name was set, we'll use that
  set_dhcp_option_name    = "${length(var.dhcp_options_name) > 0 ? var.dhcp_options_name : local.default_option_set_name }"
}

# ref: https://www.terraform.io/docs/providers/aws/r/vpc_dhcp_options.html
resource "aws_vpc_dhcp_options" "dhcp_option_set" {
  domain_name         = "${length(var.dhcp_options_domain_name) > 0 ? var.dhcp_options_domain_name : var.default_domain_name}"
  domain_name_servers = "${var.dhcp_options_domain_name_servers}"
  ntp_servers         = "${var.dhcp_options_ntp_servers}"

  # merge magic to add the default option set name
  # ref: https://www.terraform.io/docs/configuration/interpolation.html#merge-map1-map2-
  tags = "${merge(map("Name", local.set_dhcp_option_name), var.tags)}"

}

# ref: https://www.terraform.io/docs/providers/aws/r/vpc_dhcp_options_association.html
resource "aws_vpc_dhcp_options_association" "dhcp_options_association" {
  vpc_id          = "${data.terraform_remote_state.vpc.vpc_id}"
  dhcp_options_id = "${aws_vpc_dhcp_options.dhcp_option_set.id}"
}

