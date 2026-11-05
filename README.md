# application-insights

Creates an Azure Application Insights component, named and tagged through the SevenPico context module, exposing every azurerm_application_insights argument. For a component created together with its Log Analytics workspace, see the `log-analytics` module.

## Requirements

| Name | Version |
|------|---------|
| terraform | `>= 1.3.0` |
| azurerm | `>= 4.0.0, < 5.0.0` |

## Module Priority

No SevenPico, SevenPicoForks or CloudPosse module exists for this Azure service, so the module uses `azurerm_application_insights` directly. The root context is declared in `_context.tf` (`SevenPico/context/null` `2.0.0`); child contexts use the local `../null-context` module. The generated name is limited to 260 characters, the Azure maximum.

## Inputs

Every azurerm argument is an input and every input is required (no defaults): pass `null` for an argument you do not want to set. Context inputs (`enabled`, `namespace`, `environment`, `stage`, `name`, `attributes`, `tags`, ...) are declared in `_context.tf`. The resource `name` and `tags` come from the context module, so they are not separate inputs. Deprecated azurerm arguments are not exposed. Nested block inputs are typed objects whose attributes follow the azurerm documentation for that block (https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/application_insights).

| Name | Type | Description |
|------|------|-------------|
| resource_group_name | `string` | The name of the resource group in which to create the Application Insights component. Changing this forces a new resource to be created. |
| location | `string` | Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. |
| application_type | `string` | Specifies the type of Application Insights to create. Valid values are ios for _iOS_, java for _Java web_, MobileCenter for _App Center_, Node.JS for _Node.js_, other for _General_, phone for _Windows Phone_, store for... |
| daily_data_cap_in_gb | `number` | Specifies the Application Insights component daily data volume cap in GB. Defaults to 100. |
| daily_data_cap_notifications_enabled | `bool` | Whether a notification email will be sent when the daily data volume cap is met. Defaults to true. |
| force_customer_storage_for_profiler | `bool` | Should the Application Insights component force users to create their own storage account for profiling? Defaults to false. |
| internet_ingestion_enabled | `bool` | Should the Application Insights component support ingestion over the Public Internet? Defaults to true. |
| internet_query_enabled | `bool` | Should the Application Insights component support querying over the Public Internet? Defaults to true. |
| ip_masking_enabled | `bool` | By default the real client IP is masked as 0.0.0.0 in the logs. Set this argument to false to disable masking and log the real client IP. Defaults to true. |
| local_authentication_enabled | `bool` | Whether Non-Azure AD based Auth is enabled. Defaults to true. |
| retention_in_days | `number` | Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90. |
| sampling_percentage | `number` | Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. Defaults to 100. |
| workspace_id | `string` | Specifies the id of a log analytics workspace resource. |
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
  source = "git::<repo-url>//modules/application-insights?ref=application-insights-v<version>"
}

inputs = {
  enabled     = true
  namespace   = "<namespace>"
  environment = "<environment>"
  stage       = "<stage>"
  name        = "<name>"

  resource_group_name                  = "<value>"
  location                             = "<value>"
  application_type                     = "<value>"
  daily_data_cap_in_gb                 = null
  daily_data_cap_notifications_enabled = null
  force_customer_storage_for_profiler  = null
  internet_ingestion_enabled           = null
  internet_query_enabled               = null
  ip_masking_enabled                   = null
  local_authentication_enabled         = null
  retention_in_days                    = null
  sampling_percentage                  = null
  workspace_id                         = null
  timeouts                             = null
}
```

## License

Apache License 2.0. Copyright 2026 Raring Group LLC.
