resource "octopusdeploy_git_credential" "gitcredential_test" {
  description = "test git credential"
  name        = "test"
  type        = "UsernamePassword"
  username    = "admin"
  password    = "${var.gitcredential_test}"
}
variable "gitcredential_test" {
  type        = string
  nullable    = false
  sensitive   = true
  description = "The secret variable value associated with the git credential test"
  default     = "Password01!"
}

data "octopusdeploy_git_credentials" "data_lookup" {
  name = "test"
  skip = 0
  take = 1
  depends_on = [octopusdeploy_git_credential.gitcredential_test]
}