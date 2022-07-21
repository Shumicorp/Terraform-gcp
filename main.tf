data "google_secret_manager_secret_version" "dbpass" {
  secret = "dbpass"
}
module "vpc_network" {
  source                  = "./modules/vpc-network"
  name                    = var.vpc-name
  subnet1-name            = var.vpc-subnet1
  subnet1-ip_cidr         = var.vpc-subnet1-ip_cidr # "Subnetwork 1 without private access"
  subnet1-region          = var.vpc-subnet1-region
  subnet2-name            = var.vpc-subnet2         # Subnetwork 2 with privat access
  subnet2-ip_cidr         = var.vpc-subnet2-ip_cidr
  subnet2-region          = var.vpc-subnet2-region
  firewall-name           = var.firewall-name
  firewall-source_ranges  = var.firewall-source_ranges
  firewall-allow-protocol = var.firewall-allow-protocol
  firewall-allow-ports    = var.firewall-allow-ports
}

module "service-account" {
  source  = "./modules/service-account"
  name    = var.service-account-name
  roles   = var.service-account-roles
  project = local.project
}

module "db-mysql" {
  source           = "./modules/database"
  vpc-net          = module.vpc_network.id
  db-service-name  = var.db-service-name
  db-user-name     = var.db-user-name
  db-database-name = var.db-database-name
  db-user-pass     = data.google_secret_manager_secret_version.dbpass.secret_data
  db-instance-type = var.db-instance-type
  depends_on       = [module.vpc_network]
}

module "storage-bucket" {
  source      = "./modules/storage-bucket"
  name-backet = var.name-backet
  location    = var.location-backet
  sa          = module.service-account.email
  st-role     = var.sa-backet-role
  depends_on  = [module.service-account]
}

module "instance-template" {
  source        = "./modules/instance-template"
  tamplate-name = var.tamplate-name
  machine_type  = var.template-machine_type
  source_image  = var.tamplate-source_image
  disk_size_gb  = 10
  sa            = module.service-account.email
  net           = module.vpc_network.id
  sub-net       = module.vpc_network.sub1-id
  depends_on    = [module.vpc_network, module.service-account, module.storage-bucket]
}

module "instance-groupe" {
  source                    = "./modules/instance-groupe"
  template                  = module.instance-template.id
  mig-name                  = var.mig-name
  mig-region                = var.mig-region
  distribution_policy_zones = var.zones-for-mig
  autoscaler-name           = "mig-autoscaler"
  autoscaler-region         = var.mig-name
  autoscaler-min            = 2
  autoscaler-max            = 4
  health-check-name         = "health-check"
  health-check-port         = "80"
  depends_on                = [module.instance-template]
}

module "load-balancer" {
  source        = "./modules/load-balancer"
  lb-name       = var.lb-name
  ssl-cert-name = var.ssl-cert-name
  ssl-domains   = var.ssl-domains
  mig-id        = module.instance-groupe.mig-id
  check         = module.instance-groupe.health
  depends_on    = [module.instance-groupe]
}

module "dns" {
  source     = "./modules/cloud-dns"
  ip         = module.load-balancer.front-ip
  dns-name   = var.dns-name
  dns-type   = var.dns-type
  depends_on = [module.load-balancer]
}

