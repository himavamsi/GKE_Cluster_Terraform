variable "region" {
 description = "Deployment region"
 default = "us-west1-a"
}

variable "project" {
 description = "Project"
 default = "gcp-knowledge-454214" 
}
variable "clusterName" {
 description = "Name of our Cluster"
}
variable "diskSize" {
 description = "Node disk size in GB"
}

variable "machineType" {
 description = "Node Instance machine type"
}