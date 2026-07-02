resource "aws_key_pair" "cloudshield" {

  key_name = "${var.project_name}-${var.environment}-key"

  public_key = file(var.public_key_path)

  tags = {
    Name = "${var.project_name}-${var.environment}-key"
  }

}