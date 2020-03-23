# Workspace

Since all the teams will be working on the same project, you need to isolate your work as to not impact the others.

Terraform allows the use of workspaces to create virtual environments.

```bash
    terraform workspace new user1
```

This will setup a workspace with a separate state and make sure that each team infra is uniquely tracked by a separate state.

Note that workspaces are not supported by all backends in the current release (0.12).

[More about Terraform workspaces](https://www.terraform.io/docs/state/workspaces.html)

[Next: Terraform Backend](06-Backend.md)
