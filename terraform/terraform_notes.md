# Terraform Notes

## AMIs

[AMI lookup](https://cloud-images.ubuntu.com/locator/ec2/)

## First steps

Initialize with:

    terraform init

See what changes are planned:

    terraform plan

Output plan to file:

    terraform plan -out out.terraform

Apply changes:

    terraform apply out.terraform

Shortcut for applying changes (DON'T USE IN PRODUCTION):

    terraform apply

Equivalent of:

    terraform plan -out file; terraform apply file; rm file;

Remove all instances (DO NOT USE IN PRODUCTION):

    terraform destroy

## Terraform Commands

Apply state:

    terraform apply

Destroy all managed state:

    terraform destroy

Format configuration files:

    terraform fmt

Download and update modules:

    terraform get

Crete a visual representation of a configuration or excution plan:

    terraform graph

Import state into `terraform.tfstate` file:

    terraform import [OPTIONS] ADDRESS ID

Output resources:

    terraform output [OPTIONS] [NAME]

Show the changes to be made:

    terraform plan

Refresh remote state:

    terraform refresh

Configure remote state storage:

    terraform remote

Show human-readable output:

    terraform show

Advance state management:

    terraform state

Mark a resource as tainted (will be destroyed and recreated at next apply):

    terraform taint

Validate syntax:

    terraform validate

Undo taing:

    terraform untaint
