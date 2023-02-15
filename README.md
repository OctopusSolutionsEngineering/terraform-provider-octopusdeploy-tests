This project includes a battery of tests that run the [Octopus Terraform provider](https://registry.terraform.io/providers/OctopusDeployLabs/octopusdeploy/latest/docs)
against a live instance of Octopus inside a container.

Each directory under `test/terraform` is a self-contained Terraform project deploying one of the resources exposed
by the Terraform provider (and whatever supporting resources are required). The test then uses the Octopus client
to query the Octopus instance and verify the appropriate changes were implemented.

To test the Octopus Terraform provider locally, save the following into a failed called `~/.terraformrc`, replacing
`/var/home/yourname/Code/terraform-provider-octopusdeploy` with the directory containing your clone
of the git repo:

    provider_installation {
      dev_overrides {
        "octopusdeploylabs/octopusdeploy" = "/var/home/yourname/Code/terraform-provider-octopusdeploy"
      }

      direct {}
    }

Checkout the provider with:

    git clone https://github.com/OctopusDeployLabs/terraform-provider-octopusdeploy.git

Then build the provider executable with the command:

    go build -o terraform-provider-octopusdeploy main.go

Terraform will then use the local executable rather than download the provider from the registry.

To build the and run the tests, run:

    export LICENSE=base 64 octopus license
    export ECR_ACCESS_KEY=aws access key
    export ECR_SECRET_KEY=aws secret key
    export GIT_CREDENTIAL=github token
    export GIT_USERNAME=github username
    go test -c -o integration_test
    ./integration_test