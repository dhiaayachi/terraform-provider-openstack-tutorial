# Configure Openstack provider

The first thing you'll need to setup is your Terraform provider. Terraform will then use it to send its commands.

Start by creating a file called `main.tf`. Everytime Terraform runs, it will look for `*.tf` files in the current directory and load them all.

The section below shows the provider code that you will add to your file. All the information can be fetched from your Openstack RC file that you can download from your project.

go to Access & Security --> API Access and download the RC file v3

On a side note, there are a lot of changes in the latest release of Terraform (0.12) which means that some syntax may trigger warnings or errors. In order to avoid it, we will add the requirement section before the provider.

```terraform
  terraform {
    required_version = ">= 0.12"
  }

  provider "openstack" {
    user_name   = "{{ username }}"
    project_name = "{{ project name }}"
    password    = "{{ password }}"
    auth_url    = "{{ auth_url}}"
    region      = "{{ region }}"
  }
```

To initialize you terraform environment run:

```bash
terraform init
```

This will ensure that all needed terraform plugins are downloaded and create the needed backup files.

This will ensure that all the used terraform plugins are downloaded and create the needed backup files.

[More about Openstack provider options](https://www.terraform.io/docs/providers/openstack/index.html)

[Next: Using Terraform variables](04-Variables.md)
