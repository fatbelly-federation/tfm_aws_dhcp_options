################## OUTPUTS #########################

output "dhcp_options_id" {
  value = "${aws_vpc_dhcp_options.dhcp_option_set.id}"
}

output "dhcp_options_set_association_id" {
  value = "${aws_vpc_dhcp_options_association.dhcp_options_association.id}"
}

