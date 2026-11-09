# application-insights

Creates a workspace-based Azure Application Insights component on an existing Log Analytics workspace, named through the `null-context` module, exposing every non-deprecated `azurerm_application_insights` argument. The module creates no workspace. For a component created together with its workspace, see the `log-analytics-workspace` module.

## Requirements

| Name | Version |
|------|---------|
| terraform | `>= 1.3.0` |
| azurerm | `>= 4.0.0, < 5.0.0` |

## Module Priority

No SevenPico, SevenPicoForks or CloudPosse module exists for this Azure service, so the module uses `azurerm_application_insights` directly. The generated name is limited to 260 characters, the Azure maximum. `_context.tf` declares the root context; it and the child contexts use `git::https://github.com/raringgroup/terraform-null-context.git?ref=v0.1.0`.

## Naming

The component name is built by `null-context` from the context inputs plus the type token `appi`. These inputs produce `appi-apps-dev-upsis-ehs-sync-clients-eus001`:

```hcl
inputs = {
  namespace   = "upsis"
  project     = "apps"
  environment = "dev"
  name        = "ehs-sync-clients"
  region      = "eus001"
  label_order = ["attributes", "project", "environment", "namespace", "name", "region"]
}
```

## Inputs

Every azurerm argument is an input and every input is required (no defaults): pass `null` for an argument you do not want to set. Context inputs (`enabled`, `namespace`, `environment`, `stage`, `name`, `attributes`, `tags`, ...) are declared in `_context.tf`. The resource `name` and `tags` come from the context module, so they are not separate inputs. Deprecated azurerm arguments are not exposed. See https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights for the nested `timeouts` block.

`workspace_id` must not be null: the module fails the plan otherwise, so a component is never created without a workspace.

| Name | Type | Description |
|------|------|-------------|
| resource_group_name | `string` | The name of the resource group in which to create the Application Insights component. Changing this forces a new resource to be created. |
| location | `string` | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| application_type | `string` | Specifies the type of Application Insights to create (for example `web`, `java`, `Node.JS`, `other`). |
| daily_data_cap_in_gb | `number` | Daily data volume cap in GB. The provider has no unlimited value: `null` still applies its default of 100. |
| daily_data_cap_notifications_enabled | `bool` | Whether a notification email is sent when the daily data volume cap is met. Defaults to true. |
| force_customer_storage_for_profiler | `bool` | Should the component force users to create their own storage account for profiling? Defaults to false. |
| internet_ingestion_enabled | `bool` | Should the component support ingestion over the public internet? Defaults to true. |
| internet_query_enabled | `bool` | Should the component support querying over the public internet? Defaults to true. |
| ip_masking_enabled | `bool` | By default the real client IP is masked as 0.0.0.0 in the logs. Set to false to log the real client IP. Defaults to true. |
| local_authentication_enabled | `bool` | Whether non-Azure AD based authentication is enabled. `false` accepts Microsoft Entra ID only. |
| retention_in_days | `number` | Retention in days: 30, 60, 90, 120, 180, 270, 365, 550 or 730. The provider cannot inherit it from the workspace, so set it to match: the shared workspace keeps 90 days, so use `90`. `null` also applies 90, the provider default. |
| sampling_percentage | `number` | Percentage of telemetry that is sampled. Defaults to 100 (no sampling). |
| workspace_id | `string` | ID of an existing Log Analytics workspace. Required. |
| timeouts | `object` | The timeouts block of azurerm_application_insights. |

## Outputs

| Name | Description |
|------|-------------|
| app_id | Application ID (null when disabled) |
| connection_string | Connection string (sensitive; null when disabled) |
| id | Resource ID (null when disabled) |
| instrumentation_key | Instrumentation key (sensitive; null when disabled) |

## Usage

```hcl
terraform {
  source = "git::https://github.com/raringgroup/terraform-azurerm-application-insights.git?ref=develop"
}

inputs = {
  enabled     = true
  namespace   = "<namespace>"
  project     = "<project>"
  environment = "<environment>"
  name        = "<name>"
  region      = "<region-code>"
  label_order = ["attributes", "project", "environment", "namespace", "name", "region"]

  resource_group_name                  = "<resource-group>"
  location                             = "<azure-region>"
  application_type                     = "web"
  daily_data_cap_in_gb                 = null
  daily_data_cap_notifications_enabled = null
  force_customer_storage_for_profiler  = null
  internet_ingestion_enabled           = true
  internet_query_enabled               = null
  ip_masking_enabled                   = null
  local_authentication_enabled         = false
  retention_in_days                    = 90
  sampling_percentage                  = 100
  workspace_id                         = "<log-analytics-workspace-id>"
  timeouts                             = null
}
```

## License

Apache License 2.0. Copyright 2026 Raring Group LLC.
