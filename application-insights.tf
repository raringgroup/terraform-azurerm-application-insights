## ----------------------------------------------------------------------------
## Copyright 2026 Raring Group LLC
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.
## ----------------------------------------------------------------------------
##
##  modules/application-insights/application-insights.tf
##
##  Creates an Azure Application Insights component, named and tagged through the SevenPico context module, exposing every azurerm_application_insights argument.
## ----------------------------------------------------------------------------

## Application Insights Context
module "application_insights_context" {
  source  = "git::https://github.com/raringgroup/terraform-null-context.git?ref=v0.1.0"
  context = module.context.self

  attributes      = ["appi"]
  id_length_limit = 260
}


## Application Insights
resource "azurerm_application_insights" "this" {
  count = module.application_insights_context.enabled ? 1 : 0

  application_type                     = var.application_type
  daily_data_cap_in_gb                 = var.daily_data_cap_in_gb
  daily_data_cap_notifications_enabled = var.daily_data_cap_notifications_enabled
  force_customer_storage_for_profiler  = var.force_customer_storage_for_profiler
  internet_ingestion_enabled           = var.internet_ingestion_enabled
  internet_query_enabled               = var.internet_query_enabled
  ip_masking_enabled                   = var.ip_masking_enabled
  local_authentication_enabled         = var.local_authentication_enabled
  location                             = var.location
  name                                 = module.application_insights_context.id
  resource_group_name                  = var.resource_group_name
  retention_in_days                    = var.retention_in_days
  sampling_percentage                  = var.sampling_percentage
  tags                                 = module.application_insights_context.tags
  workspace_id                         = var.workspace_id

  dynamic "timeouts" {
    for_each = var.timeouts == null ? [] : [var.timeouts]
    content {
      create = timeouts.value.create
      delete = timeouts.value.delete
      read   = timeouts.value.read
      update = timeouts.value.update
    }
  }

  lifecycle {
    precondition {
      condition     = var.workspace_id != null
      error_message = "workspace_id is required: the component must be workspace-based, on an existing Log Analytics workspace."
    }
  }
}
