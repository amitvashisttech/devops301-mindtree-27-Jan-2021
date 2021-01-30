terraform {
  backend "local" {
    path = "/var/tmp/terraform-local-backend/terraform.tfstate"
  }
}
