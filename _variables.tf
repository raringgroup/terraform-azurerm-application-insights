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
##  modules/application-insights/_variables.tf
##
##  Input variables for the application-insights module.
## ----------------------------------------------------------------------------

variable "resource_group_name" {
  type        = string
  description = "The name of the resource group in which to create the Application Insights component. Changing this forces a new resource to be created."
}

variable "location" {
  type        = string
  description = "Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
}

variable "application_type" {
  type        = string
  description = "Specifies the type of Application Insights to create. Valid values are ios for _iOS_, java for _Java web_, MobileCenter for _App Center_, Node.JS for _Node.js_, other for _General_, phone for _Windows Phone_, store for..."
}

variable "daily_data_cap_in_gb" {
  type        = number
  description = "Specifies the Application Insights component daily data volume cap in GB. Defaults to 100."
}

variable "daily_data_cap_notifications_enabled" {
  type        = bool
  description = "Whether a notification email will be sent when the daily data volume cap is met. Defaults to true."
}

variable "force_customer_storage_for_profiler" {
  type        = bool
  description = "Should the Application Insights component force users to create their own storage account for profiling? Defaults to false."
}

variable "internet_ingestion_enabled" {
  type        = bool
  description = "Should the Application Insights component support ingestion over the Public Internet? Defaults to true."
}

variable "internet_query_enabled" {
  type        = bool
  description = "Should the Application Insights component support querying over the Public Internet? Defaults to true."
}

variable "ip_masking_enabled" {
  type        = bool
  description = "By default the real client IP is masked as 0.0.0.0 in the logs. Set this argument to false to disable masking and log the real client IP. Defaults to true."
}

variable "local_authentication_enabled" {
  type        = bool
  description = "Whether Non-Azure AD based Auth is enabled. Defaults to true."
}

variable "retention_in_days" {
  type        = number
  description = "Specifies the retention period in days. Possible values are 30, 60, 90, 120, 180, 270, 365, 550 or 730. Defaults to 90."
}

variable "sampling_percentage" {
  type        = number
  description = "Specifies the percentage of the data produced by the monitored application that is sampled for Application Insights telemetry. Defaults to 100."
}

variable "workspace_id" {
  type        = string
  description = "Specifies the id of a log analytics workspace resource."
}

variable "timeouts" {
  type = object({
    create = optional(string)
    delete = optional(string)
    read   = optional(string)
    update = optional(string)
  })
  description = "The timeouts block of azurerm_application_insights."
}
