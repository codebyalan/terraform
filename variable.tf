
variable "project" {
  default = "terraform-gcp-460516"
}

variable "credentials_file" {}
variable "region" {}
variable "zone" {}
variable "machine_type" {}
variable "instance_image" {}
variable "instance_size" {}
variable "instance_type" {}

variable "vm_params" {
  type = tuple([ string, string, bool ])
  description = "VM parameter - [machine_type, zone, allow_stopping_for_update]"
  default = [ "e2-medium", "asia-south1-a", true ]
}