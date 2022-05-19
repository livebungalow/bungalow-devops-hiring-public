<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.1.4 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | 4.14.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | 4.14.0 |
| <a name="provider_null"></a> [null](#provider\_null) | 3.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_main-vpc"></a> [main-vpc](#module\_main-vpc) | terraform-aws-modules/vpc/aws | 3.14.0 |
| <a name="module_nlb"></a> [nlb](#module\_nlb) | terraform-aws-modules/alb/aws | 6.10.0 |
| <a name="module_worker_1_ec2_instance"></a> [worker\_1\_ec2\_instance](#module\_worker\_1\_ec2\_instance) | terraform-aws-modules/ec2-instance/aws | 3.6.0 |
| <a name="module_worker_2_ec2_instance"></a> [worker\_2\_ec2\_instance](#module\_worker\_2\_ec2\_instance) | terraform-aws-modules/ec2-instance/aws | 3.6.0 |

## Resources

| Name | Type |
|------|------|
| [aws_iam_instance_profile.worker_1_ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_instance_profile.worker_2_ec2_instance_profile](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/iam_instance_profile) | resource |
| [aws_iam_role.worker_1_ec2_instance_role](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/iam_role) | resource |
| [aws_iam_role.worker_2_ec2_instance_role](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/iam_role) | resource |
| [aws_iam_role_policy_attachment.worker_1_ec2_instance_role_attach_ssm_managed_instance_core](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_iam_role_policy_attachment.worker_2_ec2_instance_role_attach_ssm_managed_instance_core](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/iam_role_policy_attachment) | resource |
| [aws_lb_target_group_attachment.worker_1](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_lb_target_group_attachment.worker_2](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/lb_target_group_attachment) | resource |
| [aws_security_group.sg](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/security_group) | resource |
| [aws_security_group_rule.ec2_sg_rule_egress_all](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_sg_self_rule_ingress](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.ec2_sg_ssh_rule_ingress](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_http_rule_ingress](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/security_group_rule) | resource |
| [aws_security_group_rule.sg_web_app_rule_all_ingress](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/resources/security_group_rule) | resource |
| [null_resource.worker_1_copy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.worker_1_exec](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.worker_2_copy](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [null_resource.worker_2_exec](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) | resource |
| [aws_ami.amz_linux2_ami](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/data-sources/ami) | data source |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/4.14.0/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_automated"></a> [automated](#input\_automated) | n/a | `string` | `"True"` | no |
| <a name="input_project"></a> [project](#input\_project) | n/a | `string` | `"sandbox"` | no |
| <a name="input_region"></a> [region](#input\_region) | n/a | `string` | `"us-west-2"` | no |
| <a name="input_repo_name"></a> [repo\_name](#input\_repo\_name) | n/a | `string` | `"bungalow-devops-hiring-public"` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | n/a | `string` | `"sandbox"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_nlb_hostname"></a> [nlb\_hostname](#output\_nlb\_hostname) | n/a |
| <a name="output_worker_1_hostname"></a> [worker\_1\_hostname](#output\_worker\_1\_hostname) | n/a |
| <a name="output_worker_2_hostname"></a> [worker\_2\_hostname](#output\_worker\_2\_hostname) | n/a |
<!-- END_TF_DOCS -->