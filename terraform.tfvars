vpc-name             = "my-vpc"
vpc-subnet1          = "subnet-1"
vpc-subnet2          = "submet-2"
firewall-allow-ports = ["80", "8080", "443", "22", "3306"]
db-database-name = "WP-db"
name-backet = "WP-storage-backet"
location-backet = "EU"
tamplate-name = "wp-template"
template-machine_type = "e2-medium"
tamplate-source_image = "ubuntu-1804-bionic-v20210415"
mig-name = "wp-groupe" #Managed instance group - name
mig-region = "europe-west1"
zones-for-mig = ["europe-west1-d", "europe-west1-b", "europe-west1-c"]
lb-name="wp-balbancer" #LoadBalancer name
ssl-cert-name="mrsun-ssl-test"
ssl-domains=["mrusn.pp.ua."]
dns-name= "mrusn.pp.ua."