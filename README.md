# prov_aws_vpc_terraform

Provision Amazon Web Services VPC using Terraform modules

The example here provides [Terraform](https://www.terraform.io/) scripts to
provision a VPC, 2 private subnets, 1 public subnet, 1 private security group
and 1 public security group. The layout of this looks like following:

![VPC Layout](static/layout.png)

## Why Modules?

[Modules](https://www.terraform.io/docs/modules/index.html) make it easier to
break down the scripts into reusable pieces. These pieces can then be used to
compose infrastructure components as per requirements. Since modules are
dependent on each other by exported variables, the module implementation can
change anytime without affecting any dependent components.

The scripts in this project have been broken down into four modules
- vpc:
    - input: vpc info from variables
    - output: vpc id
- private subnet:
    - input: vpc id from vpc module
    - output: subnet id
- public subnet:
    - input: vpc id from vpc module
    - output: subnet id
- security group
    - input: private and public subnet id's from respective modules
    - output: private and public security group id's

