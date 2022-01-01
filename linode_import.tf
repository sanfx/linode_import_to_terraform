terraform {
  required_providers {
    linode = {
      source = "linode/linode"
    }
   }
   required_version = ">= 0.13"
}

variable token {
  type = string
  default = null
  sensitive = true
}

provider "linode" {
   token = var.token
}

resource "linode_instance" "primary_instance" {
  region = "ap-west"
    type = "g6-nanode-1"

  config {
        kernel       = "linode/grub2"
        label        = "Restore 257841 - My Ubuntu 20.10 Disk Profile"
        memory_limit = 0
        root_device  = "/dev/sda"
        run_level    = "default"
        virt_mode    = "paravirt"

        devices {
            sda {
                disk_id    = 63023983
                disk_label = "Restore 257841 - Ubuntu 20.10 Disk"
                volume_id  = 0
            }

            sdb {
                disk_id    = 63023984
                disk_label = "Restore 257841 - 512 MB Swap Image"
                volume_id  = 0
            }
        }

        helpers {
            devtmpfs_automount = true
            distro             = true
            modules_dep        = true
            network            = true
            updatedb_disabled  = true
        }
    }

    disk {
        authorized_keys  = []
        authorized_users = []
        filesystem       = "ext4"
        label            = "Restore 257841 - Ubuntu 20.10 Disk"
        read_only        = false
        size             = 25088
        stackscript_id   = 0
    }
    
    disk {
        authorized_keys  = []
        authorized_users = []
        filesystem       = "swap"
        label            = "Restore 257841 - 512 MB Swap Image"
        read_only        = false
        size             = 512
        stackscript_id   = 0
    }
}

