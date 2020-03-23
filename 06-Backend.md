# Backend

A backend define how and where terraform store its state. Terraform supports S3, artifactory, consul and more.

We will be using a local backend for the workshop, which means that the terraform state will be stored locally in the same folder as your terraform code.

```terraform
    terraform {
        required_version = ">= 0.12"
        backend "local" {
        }
    }
```

[More about Terraform backends](https://www.terraform.io/docs/backends/index.html)

[Next: Creating your first VM](07-Your-first-VM.md)
