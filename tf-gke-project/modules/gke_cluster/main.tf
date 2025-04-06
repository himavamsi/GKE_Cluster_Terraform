resource "google_container_cluster" "my_gke_cluster" {
  name = var.clusterName
  deletion_protection = false
  project = var.project
  location = var.region
  network = "gke-cluster"
  subnetwork = "gke-cluster-subnet-usw1"
  networking_mode = "VPC_NATIVE"
  node_pool {
    name = "default-pool"
    node_locations = [ var.region ]
    initial_node_count = 1
    node_config {
      disk_type = "pd-standard"
      disk_size_gb = var.diskSize
      machine_type = var.machineType
      preemptible = true
    }
  }
  remove_default_node_pool = true
  ip_allocation_policy {
    cluster_secondary_range_name = "pods"
    services_secondary_range_name = "services"
    stack_type = "IPV4"
  }
  private_cluster_config {
    master_ipv4_cidr_block = "10.153.168.128/28"
    enable_private_nodes = true
  }
}

resource "google_container_node_pool" "my_node_pool" {
  cluster = google_container_cluster.my_gke_cluster.id
  name = "demo-node-pool"
  max_pods_per_node = 64
  node_count = 1
  node_locations = [ var.region ]
  location = var.region
  node_config {
    disk_type = "pd-standard"
    disk_size_gb = var.diskSize
    preemptible = true
    machine_type = var.machineType
    service_account = "terraform@gcp-knowledge-454214.iam.gserviceaccount.com"
    oauth_scopes = [ 
        "https://www.googleapis.com/auth/compute",
        "https://www.googleapis.com/auth/cloud-platform",
        "https://www.googleapis.com/auth/devstorage.read_only",
        "https://www.googleapis.com/auth/logging.write",
        "https://www.googleapis.com/auth/monitoring",
     ]
  }
  management {
    auto_repair = true
    auto_upgrade = true
  }
  timeouts {
    create = "20m"
    update = "20m"
  }
  
}