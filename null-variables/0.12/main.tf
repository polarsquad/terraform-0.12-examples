# Example idea: https://www.hashicorp.com/blog/terraform-0-12-conditional-operator-improvements

module "instance_1" {
  source = "./modules/instance"

  instance_name = "TatusTestInstance1"
}

module "instance_2" {
  source = "./modules/instance"

  instance_name = "TatusTestInstance2"

  # Ip might not match to subnet
  override_private_ip = "172.31.0.1"
}
