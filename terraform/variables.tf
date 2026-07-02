variable "aws_region" {

  description = "AWS Region"

  type = string

  default = "ap-south-1"

}

variable "environment" {

  description = "Deployment Environment"

  type = string

  default = "dev"

}

variable "vpc_cidr" {
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  default = "10.0.1.0/24"
}

variable "availability_zone" {
  default = "ap-south-1a"
}

variable "allowed_ssh_cidr" {

  description = "SSH CIDR"

  type = string

}

variable "public_key_path" {

  description = "SSH Public Key"

  type = string

}