output "instance_id" {
  value = aws_instance.cloudshield.id
}

output "public_ip" {
  value = aws_instance.cloudshield.public_ip
}

output "public_dns" {
  value = aws_instance.cloudshield.public_dns
}