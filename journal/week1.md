# Terraform Beginner Bootcamp 2023 - Week 1

## Root Module Structure

Our root module structure is as follows:

```
PROJECT_ROOT
│
├── main.tf                 # everything else.
├── variables.tf            # stores the structure of input variables
├── terraform.tfvars        # the data of variables we want to load into our terraform project
├── providers.tf            # defined required providers and their configuration
├── outputs.tf              # stores our outputs
└── README.md               # required for root modules
```

[Standard Module Structure](https://developer.hashicorp.com/terraform/language/modules/develop/structure)

## Terraform and Input Variables

### Terraform Cloud Variables

In terraform we can set two kind of variables:
- Enviroment Variables - those you would set in your bash terminal eg. AWS credentials
- Terraform Variables - those that you would normally set in your tfvars file

We can set Terraform Cloud variables to be sensitive so they are not shown visibliy in the UI.

### Loading Terraform Input Variables

[Terraform Input Variables](https://developer.hashicorp.com/terraform/language/values/variables)

### var flag
We can use the `-var` flag to set an input variable or override a variable in the tfvars file eg. `terraform -var user_uuid="my-user_id"`

### var-file flag

The -var-file flag is used to pass Input Variable values into Terraform plan and apply commands using a file that contains the values. This allows you to save the Input Variable values in a file with a .tfvars extension that can be checked into source control for you variable environments you need to deploy to / manage.
The .tfvars file contents will contain the definition for the Input Variable values to pass into the Terraform commands. 

Here’s an example .tfvars file defining a few Input Variable values:

```
environment = 'production'
location    = 'eastus'

vm_instance_count = 4
vm_ip_allow_list  = [
  '10.50.0.1/32'
  '10.83.0.5/32'
]
```
Here’s a couple examples of using the -var-file flag to pass in .tfvars files to Terraform commands:
```
# Pass .tfvar files to 'plan' command
terraform plan \
-var-file 'production.tfvars' \
-var-file 'secrets.tfvars'

# Pass .tfvar files to 'apply ' command
terraform apply \
-var-file 'production.tfvars' \
-var-file 'secrets.tfvars'
```

### terraform.tvfars

This is the default file to load in terraform variables in blunk

### auto.tfvars

Any files with the following suffixes will automatically be loaded to populate Input Variables: 
**.auto.tfvars** or **.auto.tfvars.json**

### order of terraform variables

When Terraform loads Input Variable values from the various definition methods, they are loaded in the following order with later sources taking precedence over earlier sources:

1. Environment variables
2. **terraform.tfvars** file, if present
3. **terraform.tfvars.json** file, if present
4. Any **.auto.tfvars** or **.auto.tfvars.json** files, processed in lexical order of their filenames.
5. Any *-var* and *-var-file* flags on the command-line, in the order they are provided.

## Dealing With Configuration Drift

## What happens if we lose our state file?

If you lose your statefile, you most likley have to tear down all your cloud infrastructure manually.

You can use terraform port but it won't for all cloud resources. You need check the terraform providers documentation for which resources support import.

### Fix Missing Resources with Terraform Import

`terraform import aws_s3_bucket.bucket bucket-name`

[Terraform Import](https://developer.hashicorp.com/terraform/cli/import)
[AWS S3 Bucket Import](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/s3_bucket#import)

### Fix Manual Configuration

If someone goes and delete or modifies cloud resource manually through ClickOps. 

If we run Terraform plan is with attempt to put our infrstraucture back into the expected state fixing Configuration Drift