# Using Terraform variables

Of course, the previous example wouldn't win a price in security with its username and password in plain text.

Terraform allows to move secure information somewhere else so that they don't show up directly in your code.

Since the goal of this workshop is not to instruct about the use of various tools to encrypt your confidential informations, we will extract the information to a different file to make our main configuration file as dynamic as possible.

- Create a file called `variables.tf` and add the following lines to it.

```terraform
  variable "os_auth_url" {
    default = "{{ auth_url }}"
  }

  variable "os_password" {
    default = "{{ password }}"
  }

  variable "os_region" {
    default = "{{ region }}"
  }

  variable "os_project" {
    default = "{{ project name }}"
  }

  variable "os_username" {
    default = "{{ username }}"
  }
```

- You can now modify your `main.tf` file to look like this.

```terraform
  provider "openstack" {
    user_name   = var.os_username
    project_name = var.os_project
    password    = var.os_password
    auth_url    = var.os_auth_url
    region      = var.os_region
  }
```

[More about Terraform variables](https://www.terraform.io/docs/configuration/variables.html)

[Next: Setting up your workspace](05-Workspace.md)
