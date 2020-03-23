# Introduction to Terraform

## Standard way of provisioning infrastructure in Openstack

- through Horizon (Web interface)
- through command line using Openstack API
- HEAT templates (Openstack only)
- Terrafom (cloud agnostic: Openstack, Azure, GCE, etc.)

### Overview of Terraform in an Openstack project

```text
  ┌─────────────┐     ┌───────────────┐     ┌────────┐
  │  Terraform  ├─────┤ Openstack API ├─────┤ Project │
  └──────┬──────┘     └───────────────┘     └───┬────┘
         ├──────────────Floating IP─────────────╯
   ┌─────┴─────┐
   │  Backend  │
   └───────────┘
```

- The backend is where Terraform store the state of the architecture it generated.

- When you run Terraform commands, it will compare the desired state with the current state and apply the changes that it sends to the Openstack API.

- The outcome will be stored in the Openstack project.

- Once the Infrastructure is configured, Terraform will use the Floating IP network (or any other network configuration) to setup the Operating system.

## Using Infrastructure as code

- Manual and human changes are prone to mistakes
- Starting from "scratch" becomes so much easier
- You can keep track of any change you make to your infrastructure
- You can copy your environment as much as you want

## Using Terraform

1. Automate the infrastructure creation
2. Advanced features such as Rolling updates
3. If you use hybrid cloud, Terraform can manage it all in a single script

[Next: Introduction to the Terraform Workshop](02-Workshop-intro.md)
