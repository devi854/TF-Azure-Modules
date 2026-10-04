# Terraform Azure modules

Reusable modules maintained by the platform team. Consumers call them from their
own repository and pin a release tag.

| Module | Creates |
|---|---|
| `modules/state-storage` | Storage account and container for Terraform state |
| `modules/network` | Resource group, virtual network, subnets, one NSG per subnet |
| `modules/windows-vm` | Windows VM, network interface, optional public IP |
| `modules/app-service` | Linux App Service plan and web app |

## Using a module

```hcl
module "network" {
  source = "git::https://github.com/devi854/<modules-repo>.git//modules/network?ref=v1.0.0"

  resource_group_name = "rg-platform-dev"
  location            = "centralindia"
  vnet_name           = "vnet-platform-dev"
  address_space       = ["10.20.0.0/16"]
  subnets             = { app = "10.20.1.0/24" }
}
```

`live-example/` is a complete caller. Copy its files to the root of the consuming
repository and replace `<modules-repo>` in `main.tf`.

## Releasing

1. Change a module on a branch and open a pull request. CI runs format, validate,
   TFLint, and Checkov.
2. Merge to `main`.
3. Tag the release and push the tag:

   ```bash
   git tag -a v1.1.0 -m "Describe the change"
   git push origin v1.1.0
   ```

Versioning: patch (`v1.0.1`) for fixes, minor (`v1.1.0`) for new optional inputs
or outputs, major (`v2.0.0`) for anything that breaks existing callers, such as a
renamed or removed variable or a renamed resource without a `moved` block.

## Rules for these modules

- No `backend` block and no `provider` block. Those belong to the caller.
- Provider versions are a minimum (`>= 5.0`). The caller pins the exact version.
- Every variable has a type and a description. Every output has a description.
- Checkov findings are fixed, or skipped inline with a reason.
