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
  default     = "t2.micro"
}

resource "aws_iam_instance_profile" "instance_profile" {
  name = "test_profile"
  role = "${aws_iam_role.role.name}"
}

resource "aws_iam_role" "role" {
  name               = "test_role"
  assume_role_policy = "${data.aws_iam_policy_document.instance_assume_role.json}"
}

resource "aws_iam_role_policy" "test_policy" {
  name = "test_policy"
  role = "${aws_iam_role.role.id}"

  policy = "${data.aws_iam_policy_document.instance_profile.json}"
}

data "aws_iam_policy_document" "instance_assume_role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

data "aws_iam_policy_document" "instance_profile" {
  statement {
    actions = [
      "s3:GetObject",
      "s3:PutObject",
      "s3:DeleteObject",
      "s3:GetObjectAcl",
      "s3:PutObjectAcl",

      # Will be enabled to demo JSON diffs
      "s3:GetObjectTagging",
    ]

    resources = [
      "arn:aws:s3:::tatusl-polarsquad-tf-state/*",
    ]
  }
}

resource "aws_instance" "web" {
  ami                  = "${data.aws_ami.ubuntu.id}"
  instance_type        = "${var.instance_class}"
  iam_instance_profile = "${aws_iam_instance_profile.instance_profile.id}"

  tags = {
    Name = "TatusTestInstance"
  }
}
