output "vpc_id" {
  value = module.network.vpc_id
}

output "public_subnet_id" {
  value = module.network.public_subnet_id
}

output "security_group_id" {

  value = module.security.security_group_id

}

output "key_name" {

  value = module.keypair.key_name

}