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

resource "aws_instance" "web" {
  # Intentional syntax error below
  ami           = "${ata.aws_ami.ubuntu.id}"
  instance_type = "${var.instance_class}"

  tags = {
    Name = "TatusTestInstance"
  }
}
