# Example idea source: https://github.com/hashicorp/terraform-guides/blob/master/infrastructure-as-code/terraform-0.12-examples/for-expressions/main.tf

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-cosmic-18.10-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

variable "instance_class" {
  description = "Instance class of the instance"
  default = "t2.micro"
}

# Get AWS account default VPC
resource "aws_default_vpc" "default" {
  tags = {
    Name = "Default VPC"
  }
}

resource "aws_subnet" "subnet" {
  vpc_id = "${aws_default_vpc.default.id}"
  cidr_block = "172.31.64.0/24"

  tags = {
    Name = "TatusTestSubnet"
  }
}

resource "aws_instance" "web" {
  count = 3
  ami           = "${data.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_class}"
  subnet_id = "${aws_subnet.subnet.id}"

  tags = {
    Name = "TatusTestInstance-${count.index}"
  }
}

# Old splat operator
output "private_addresses" {
  value = "${aws_instance.web.*.private_dns}"
}
