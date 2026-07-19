module "network" {

  source = "./modules/network"

  project_name       = local.project_name
  environment        = var.environment
  vpc_cidr           = var.vpc_cidr
  public_subnet_cidr = var.public_subnet_cidr
  availability_zone  = var.availability_zone

}

module "security" {

  source = "./modules/security"

  project_name = local.project_name

  environment = var.environment

  vpc_id = module.network.vpc_id

  allowed_ssh_cidr = var.allowed_ssh_cidr

}

module "keypair" {

  source = "./modules/keypair"

  project_name = local.project_name

  environment = var.environment

  public_key_path = var.public_key_path

}

module "compute" {

  source = "./modules/compute"

  project_name = local.project_name

  environment = var.environment

  subnet_id = module.network.public_subnet_id

  security_group_id = module.security.security_group_id

  key_name = module.keypair.key_name

  instance_type = var.instance_type

}