data "aws_ami" "ubuntu" {

  most_recent = true

  owners = ["099720109477"]

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

}

resource "aws_instance" "cloudshield" {

  ami = data.aws_ami.ubuntu.id

  instance_type = "t3.micro"

  subnet_id = var.subnet_id

  vpc_security_group_ids = [
    var.security_group_id
  ]

  key_name = var.key_name

  associate_public_ip_address = true

  user_data = file("${path.root}/scripts/bootstrap-k3s.sh")

  tags = {
    Name = "${var.project_name}-${var.environment}-platform-node"
  }

}