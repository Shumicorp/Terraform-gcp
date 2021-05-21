module "vpc_network" {
  source = "./modules/vpc-network"
}

module "db-mysql" {
  source     = "./modules/database"
  net        = module.vpc_network.id
  name-db    = "wordpress-888"
  depends_on = [module.vpc_network]
}

module "service-account" {
  source = "./modules/service-account"
}

module "storage-bucket" {
  source      = "./modules/storage-bucket"
  name-backet = "wordpress-storage-888"
  acc         = module.service-account.email
  depends_on  = [module.service-account]
}

module "instance-template" {
  source     = "./modules/instance-template"
  acc        = module.service-account.email
  net        = module.vpc_network.id
  sub-net    = module.vpc_network.sub-id
  depends_on = [module.vpc_network, module.service-account, module.storage-bucket]
}

module "instance-groupe" {
  source     = "./modules/instance-groupe"
  template   = module.instance-template.id
  min-i      = 2
  max-i      = 4
  depends_on = [module.instance-template]
}

module "load-balancer" {
  source     = "./modules/load-balancer"
  ig-id      = module.instance-groupe.ig-id
  check      = module.instance-groupe.wp-health
  depends_on = [module.instance-groupe]
}

module "dns" {
  source     = "./modules/cloud-dns"
  ip         = module.load-balancer.front-ip
  depends_on = [module.load-balancer]
}