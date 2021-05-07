provider "google" {
  credentials = file("credential.json")
  project     = "my-wordpress-312314"
  region      = "europe-west1"
  zone        = "europe-west1-c"
}

module "vpc_network" {
  source = "./modules/vpc"
}

module "db-mysql" {
  source     = "./modules/db"
  net        = module.vpc_network.id
  depends_on = [module.vpc_network]  
}

module "service-account" {
  source = "./modules/sa"
}

module "storage-bucket" {
  source     = "./modules/st"
  acc        = module.service-account.email
  depends_on = [module.service-account] 
}

module "instance-template" {
  source     = "./modules/tm"
  acc        = module.service-account.email
  net        = module.vpc_network.id
  sub-net    = module.vpc_network.sub-id
  depends_on = [module.vpc_network, module.service-account] 
}

module "instance-groupe" {
  source     = "./modules/ig"
  template   = module.instance-template.id
  min-i      = 2
  max-i      = 4
  depends_on = [module.instance-template] 
}

#module "load-balancer" {
#  source     = "./modules/lb"
#  ig-id      = module.instance-groupe.ig-id
#  sub-net    = module.vpc_network.sub-id
#  net        = module.vpc_network.id
#  depends_on = [module.instance-groupe] 
#}

