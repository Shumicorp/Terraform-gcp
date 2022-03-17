module "vpc_network" {
  source                 = "./modules/vpc-network"
  name                   = local.vpc_name
  subnet1-name           = local.subnet1-name
  subnet1-ip_cidr        = local.subnet1-ip_cidr
  subnet1-region         = local.subnet1-region
  subnet2-name           = local.subnet2-name
  subnet2-ip_cidr        = local.subnet2-ip_cidr
  subnet2-region         = local.subnet2-region
  firewall-name          = local.firewall-name
  firewall-source_ranges = local.firewall-source_ranges
  firewall-allow-ports   = local.firewall-allow-ports
}

module "service-account" {
  source  = "./modules/service-account"
  name    = local.sa-name
  roles   = local.sa-role
  project = local.project
}

module "db-mysql" {
  source           = "./modules/database"
  vpc-net          = module.vpc_network.id
  db-service-name  = local.db-service-name
  db-user-name     = local.db-user-name
  db-database-name = local.db-database-name
  db-user-pass     = local.db-user-pass
  db-instance-type = local.db-instance-type
  depends_on       = [module.vpc_network]
}

module "storage-bucket" {
  source      = "./modules/storage-bucket"
  name-backet = local.name-backet
  location    = local.location
  sa          = module.service-account.email
  st-role     = local.st-role
  depends_on  = [module.service-account]
}

module "instance-template" {
  source        = "./modules/instance-template"
  tamplate-name = local.tamplate-name
  machine_type  = local.machine_type
  source_image  = local.source_image
  disk_size_gb  = local.disk_size_gb
  sa            = module.service-account.email
  net           = module.vpc_network.id
  sub-net       = module.vpc_network.sub1-id
  depends_on    = [module.vpc_network, module.service-account, module.storage-bucket]
}

module "instance-groupe" {
  source                    = "./modules/instance-groupe"
  template                  = module.instance-template.id
  mig-name                  = local.mig-name
  mig-region                = local.mig-region
  distribution_policy_zones = local.distribution_policy_zones
  autoscaler-name           = local.autoscaler-name
  autoscaler-region         = local.autoscaler-region
  autoscaler-min            = local.autoscaler-min
  autoscaler-max            = local.autoscaler-max
  health-check-name         = local.health-check-name
  health-check-port         = local.health-check-port
  depends_on                = [module.instance-template]
}

module "load-balancer" {
  source        = "./modules/load-balancer"
  lb-name       = local.lb-name
  ssl-cert-name = local.ssl-cert-name
  ssl-domains   = local.ssl-domains
  mig-id        = module.instance-groupe.mig-id
  check         = module.instance-groupe.health
  depends_on    = [module.instance-groupe]
}

module "dns" {
  source     = "./modules/cloud-dns"
  ip         = module.load-balancer.front-ip
  dns-name   = local.dns-name
  dns-type   = local.dns-type
  depends_on = [module.load-balancer]
}

