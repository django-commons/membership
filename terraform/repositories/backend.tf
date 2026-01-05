# Backend Configuration
# https://www.terraform.io/language/settings/backends/configuration

terraform {
  backend "local" {
    path = "tfstate.json"
  }
}
