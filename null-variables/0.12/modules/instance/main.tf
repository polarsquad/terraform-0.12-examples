# Example idea: https://www.hashicorp.com/blog/terraform-0-12-conditional-operator-improvements

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

variable "instance_name" {
  description = "Name tag for the instance"
}

variable "instance_class" {
  description = "Instance class of the instance"
  default = "t2.micro"
}

variable "override_private_ip" {
  type = string
  default = null
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = var.instance_class
  private_ip = var.override_private_ip

  tags = {
    Name = var.instance_name
  }
}
