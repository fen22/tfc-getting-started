# The following configuration uses a provider which provisions [fake] resources
# to a fictitious cloud vendor called "Fake Web Services". Configuration for
# the fakewebservices provider can be found in provider.tf.
#
# After running the setup script (./scripts/setup.sh), feel free to change these
# resources and 'terraform apply' as much as you'd like! These resources are
# purely for demonstration and created in Terraform Cloud, scoped to your TFC
# user account.
#
# To review the provider and documentation for the available resources and
# schemas, see: https://registry.terraform.io/providers/hashicorp/fakewebservices
#
# If you're looking for the configuration for the remote backend, you can find that
# in backend.tf.


resource "fakewebservices_vpc" "secondary_vpc" {
  name       = "Secondary VPC"
  cidr_block = var.CIDRBLOCK
}

resource "fakewebservices_server" "servers" {
  count = 2

  name = "Server ${count.index + 5}"
  type = var.instance_type
  vpc  = fakewebservices_vpc.secondary_vpc.name
}

resource "fakewebservices_load_balancer" "secondary_lb" {
  name    = "Secondary Load Balancer"
  servers = fakewebservices_server.servers[*].name
}

resource "fakewebservices_database" "prod_db_2" {
  name = "Production DB 2"
  size = 256
}
resource "fakewebservices_server" "server-fer" {
  name = "Server Fer"
  type = "t2.macro"
}
