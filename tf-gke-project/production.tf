module "gke_cluster" {
  source = "./modules/gke_cluster"
  clusterName = var.clusterName
  diskSize = var.diskSize
  machineType = var.machineType
}