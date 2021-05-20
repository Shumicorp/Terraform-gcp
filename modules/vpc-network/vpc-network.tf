resource "google_compute_network" "vpc_network" {
  name = "vpc-network"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "public-subnet" {
  name = "zone1-public-subnet"
  ip_cidr_range = "10.0.10.0/24"
  region = "europe-west1"
  network = google_compute_network.vpc_network.name
  depends_on    = [google_compute_network.vpc_network]
}

resource "google_compute_subnetwork" "private-subnet" {
  name          = "zone1-private-subnet"
  ip_cidr_range = "10.0.20.0/24"
  network       = google_compute_network.vpc_network.name
  region        = "europe-west1"
  private_ip_google_access = "true"
  depends_on    = [google_compute_network.vpc_network]
}

resource "google_compute_global_address" "private_ip_address" {
  name = "private-ip-address"
  purpose = "VPC_PEERING"
  address_type = "INTERNAL"
  prefix_length = 16
  network = google_compute_network.vpc_network.id
}

resource "google_service_networking_connection" "private_vpc_connection" {
  network = google_compute_network.vpc_network.id
  service = "servicenetworking.googleapis.com"
  reserved_peering_ranges = [google_compute_global_address.private_ip_address.name]
}

resource "google_compute_router" "router" {
  name    = "my-router"
  region  = google_compute_subnetwork.private-subnet.region
  network = google_compute_network.vpc_network.id

  bgp {
    asn = 64514
  }
}

resource "google_compute_router_nat" "nat" {
  name                               = "my-router-nat"
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = "AUTO_ONLY"
  source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

  log_config {
    enable = true
    filter = "ERRORS_ONLY"
  }
}

resource "google_compute_firewall" "default" {
  name    = "test-firewall"
  network = google_compute_network.vpc_network.name
  allow {
    protocol = "icmp"
  }
  allow {
    protocol = "tcp"
    ports    = ["80", "8080", "443", "22"]
  }
  depends_on    = [google_compute_network.vpc_network]
}

