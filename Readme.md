# IaC for Devilsan.com hosted on linode

The repository contains terraform code to deploy and manage linode instance for devilsan.com and domains etc. The  `terraform import` code was used to bring exisiting linode instance that was originally manually created on linode. Now, `terraform plan` and `terrafrom apply` can be used to control all the infrastructure needed for devilsan.com.

## How to import an exisitng linode instance ?

run linode-cli command to get list of linodes associated with your account.

    linode-cli linodes list --json --pretty

then in linode_instance.tf create resource linode_instane and put the region, type , entire config and disks within that resource group.

then run `terrafrom plan` that should give you results like this:

```bash
linode_instance.primary_instance: Refreshing state... [id=<linode_instnace_id>]

No changes. Your infrastructure matches the configuration.

Terraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
```

Do the similar steps for domains, volums etc exlcuding the config and disk which were only available in the linode instance.  All we need is the instance id which we can get using the 
```
linode-cli domains list --json --pretty
```

I have integrated this terraform IaC with terraform cloud to keep snesitive data instead hard coding and in addition the terrafrom cloud also stores the state of my linode and other linode services.

## How to add terraform cloud to your local github reporsitory

First you need add a backend.tf file containing this code.


```hcl
terraform {
  backend "remote" {
    organization = "devilsan-linode"
    workspaces {
      name = "linode-tf-devilsan"
    }
  }
}
```
then run `terraform init` command to initialize. 
* If you have local terrafrom.tfstate file move it to some other location since now the state is going to be stored in the terrafrom cloud.
* If you do not have terraform login configured then it will first direct you to set up API token and it will try to configure a local `credentials.tfrc.json`. In my case I was not able to get the part to work automatically so I configured this json file manaully, since this is my second terrafrom project and I do not have much to worry about I unhesitatnly created the `credentials.tfrc.json` file and placed the below lines which contians the token we get from [app.terraform.io](http://app.terraform.io).

```hcl
{
  "credentials": {
    "app.terraform.io": {
      "token": "secret_token_from_terrafrom_cloud"
    }
  }
}
```

Now run the `terraform init`. becuase I had variable required, I now stired variable in the terrafrom cloud and while using `terraform apply` it pulls the value of those vairables from the cloud securely and deploys the instance of update the service you are upating.