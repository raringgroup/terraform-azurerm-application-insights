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
##  examples/complete/application-insights.tf
##
##  Creates a resource group, a Log Analytics workspace and a workspace-based Application
##  Insights component that accepts Microsoft Entra ID only. Every input is listed; null
##  leaves an argument unset.
## ----------------------------------------------------------------------------

## Resource Group
resource "azurerm_resource_group" "this" {
  location = var.region
  name     = "${module.context.id}-rg"
  tags     = module.context.tags
}


## Log Analytics Workspace
resource "azurerm_log_analytics_workspace" "this" {
  location            = azurerm_resource_group.this.location
  name                = "${module.context.id}-log"
  resource_group_name = azurerm_resource_group.this.name
  retention_in_days   = 90
  sku                 = "PerGB2018"
  tags                = module.context.tags
}


## Application Insights
module "application_insights" {
  source  = "../../"
  context = module.context.self

  application_type                     = "web"
  daily_data_cap_in_gb                 = null
  daily_data_cap_notifications_enabled = null
  force_customer_storage_for_profiler  = null
  internet_ingestion_enabled           = true
  internet_query_enabled               = null
  ip_masking_enabled                   = null
  local_authentication_enabled         = false
  location                             = azurerm_resource_group.this.location
  resource_group_name                  = azurerm_resource_group.this.name
  retention_in_days                    = 90
  sampling_percentage                  = 100
  timeouts                             = null
  workspace_id                         = azurerm_log_analytics_workspace.this.id
}
