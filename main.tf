module "vpc_network" {
  source                 = "./modules/vpc-network"
  name                   = "my-vpc2"
  subnet1-name           = "subnet-1"
  subnet1-ip_cidr        = "10.0.10.0/24"
  subnet1-region         = "europe-west1"
  subnet2-name           = "subnet-2-with-pa"
  subnet2-ip_cidr        = "10.0.20.0/24"
  subnet2-region         = "europe-west2"
  firewall-name          = "test-firewall"
  firewall-source_ranges = ["0.0.0.0/0"]
  firewall-allow-protocol = "tcp"
  firewall-allow-ports   = ["80", "8080", "443", "22"]
}

module "service-account" {
  source  = "./modules/service-account"
  name    = "test-2"
  roles   = "roles/editor"
  project = local.project
}

module "db-mysql" {
  source           = "./modules/database"
  vpc-net          = module.vpc_network.id
  db-service-name  = "SQL-service"
  db-user-name     = "test"
  db-database-name = "test-db"
  db-user-pass     = "1234"
  db-instance-type = "db-f1-micro"
  depends_on       = [module.vpc_network]
}

module "storage-bucket" {
  source      = "./modules/storage-bucket"
  name-backet = "Test-storage-backet"
  location    = "EU"
  sa          = module.service-account.email
  st-role     = "roles/storage.admin"
  depends_on  = [module.service-account]
}

module "instance-template" {
  source        = "./modules/instance-template"
  tamplate-name = "test"
  machine_type  = "e2-medium"
  source_image  = "ubuntu-1804-bionic-v20210415"
  disk_size_gb  = 10
  sa            = module.service-account.email
  net           = module.vpc_network.id
  sub-net       = module.vpc_network.sub1-id
  depends_on    = [module.vpc_network, module.service-account, module.storage-bucket]
}

module "instance-groupe" {
  source                    = "./modules/instance-groupe"
  template                  = module.instance-template.id
  mig-name                  = "test-groupe"
  mig-region                = "europe-west1"
  distribution_policy_zones = ["europe-west1-d", "europe-west1-b", "europe-west1-c"]
  autoscaler-name           = "test-autoscaler"
  autoscaler-region         = "europe-west1"
  autoscaler-min            = 2
  autoscaler-max            = 4
  health-check-name         = "health-check"
  health-check-port         = "80"
  depends_on                = [module.instance-template]
}

module "load-balancer" {
  source        = "./modules/load-balancer"
  lb-name       = "test"
  ssl-cert-name = "mrsun-ssl-test"
  ssl-domains   = ["mrusn.pp.ua."] #list
  mig-id        = module.instance-groupe.mig-id
  check         = module.instance-groupe.health
  depends_on    = [module.instance-groupe]
}

module "dns" {
  source     = "./modules/cloud-dns"
  ip         = module.load-balancer.front-ip
  dns-name   = "mrusn.pp.ua."
  dns-type   = "A"
  depends_on = [module.load-balancer]
}

