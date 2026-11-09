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
##  modules/application-insights/_outputs.tf
##
##  Output values for the application-insights module.
## ----------------------------------------------------------------------------

output "app_id" {
  description = "App id of the application insights (null when disabled)"
  value       = try(azurerm_application_insights.this[0].app_id, null)
}

output "connection_string" {
  description = "Connection string of the application insights (null when disabled)"
  value       = try(azurerm_application_insights.this[0].connection_string, null)
  sensitive   = true
}

output "id" {
  description = "Id of the application insights (null when disabled)"
  value       = try(azurerm_application_insights.this[0].id, null)
}

output "instrumentation_key" {
  description = "Instrumentation key of the application insights (null when disabled)"
  value       = try(azurerm_application_insights.this[0].instrumentation_key, null)
  sensitive   = true
}
