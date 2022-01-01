terraform {
  backend "remote" {
    organization = "devilsan-linode"
    workspaces {
      name = "linode-tf-devilsan"
    }
  }
}
