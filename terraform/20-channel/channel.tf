resource "octopusdeploy_channel" "backend_mainline" {
  name        = "Test"
  project_id  = octopusdeploy_project.deploy_frontend_project.id
  description = "Test channel"
  depends_on  = [octopusdeploy_project.deploy_frontend_project, octopusdeploy_deployment_process.deploy_backend]
  is_default  = true
  rule {
    tag = "^$"
    action_package {
      deployment_action = "Test"
      package_reference = "test"
    }
  }
}

data "octopusdeploy_channels" "data_lookup" {
  partial_name = "Test"
  skip         = 0
  take         = 1
  depends_on   = [octopusdeploy_channel.backend_mainline]
}