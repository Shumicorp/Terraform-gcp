# Terraform-gcp
# My file to create infrastructure for wordpress app

create: 
# VPC network - module "vpc_network":
  2 - subnetwork   
  cloud-nat   
  private-vpc-connection for mysql   

# SQL - module "db-mysql"
  user   
  database   

# Service account - module "service-account"

# Cloud Storage - module "storage-bucket"
  storage   
  add service account with admin role   

# Compute Engine - Instance template - module "instance-template"
  template with:   
    apache2   
    php   
    gcsfuse   
    add service account for access to Cloud Storage   
    mount Cloud Storage   
    
# Compute Engine - Instance groups - module "instance-groupe"
  instance group   
  autoscaler   
  health-check   

# Network services - Load balancing - module "load-balancer"