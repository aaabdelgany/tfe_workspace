variable "environments" {}
variable "organization" {}
variable "vcs_working_directory" {}
variable "vcs_reponame" {}
variable "terraform_version" {}
variable "vcs_oauth_token_id" {}
variable "trigger_prefixes" {}

resource "tfe_workspace" "workspace" {

  for_each = toset(var.environments)

  organization = var.organization

  name = format("%s_%s_%s", var.vcs_reponame, var.vcs_working_directory, each.value)

  working_directory = var.vcs_working_directory

  allow_destroy_plan = false

  auto_apply = false

  #execution_mode = "remote"
  #operations = true

  queue_all_runs = false

  terraform_version = var.terraform_version

  vcs_repo {

    identifier = "berchevorg/${var.vcs_reponame}"

    oauth_token_id = var.vcs_oauth_token_id

  }

  trigger_prefixes = var.trigger_prefixes

}
