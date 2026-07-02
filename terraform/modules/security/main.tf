resource "aws_security_group" "ec2" {

  name        = "${var.project_name}-${var.environment}-ec2-sg"

  description = "Security Group for CloudShield Platform"

  vpc_id = var.vpc_id

  # SSH

  ingress {

    description = "SSH"

    from_port = 22

    to_port = 22

    protocol = "tcp"

    cidr_blocks = [
      var.allowed_ssh_cidr
    ]

  }

  # HTTP

  ingress {

    description = "HTTP"

    from_port = 80

    to_port = 80

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  # HTTPS

  ingress {

    description = "HTTPS"

    from_port = 443

    to_port = 443

    protocol = "tcp"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  # Outbound

  egress {

    from_port = 0

    to_port = 0

    protocol = "-1"

    cidr_blocks = [
      "0.0.0.0/0"
    ]

  }

  tags = {

    Name = "${var.project_name}-${var.environment}-ec2-sg"

  }

}