# aws-instance-first-script

![](https://github.com/easyawslearn/Terraform-Tutorial/workflows/terraform-tutorials-ci/badge.svg)

A Terraform module for creating AWS EC2 instance.

## Usage

```hcl
module "ec2_instance" {
  source     = "git::https://github.com/barbatrukko/Terraform-Test.git//aws-instance-first-script"

  region    = "eu-west-1"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| region | AWS region | string | eu-west-1 | yes |
