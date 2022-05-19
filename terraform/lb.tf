# https://registry.terraform.io/modules/terraform-aws-modules/alb/aws/latest
module "nlb" {
  source  = "terraform-aws-modules/alb/aws"
  version = "6.10.0"

  name = "${local.prefix}-nlb"

  load_balancer_type = "network"

  vpc_id  = module.main-vpc.vpc_id
  subnets = [module.main-vpc.public_subnets[0], module.main-vpc.public_subnets[1]]

  target_groups = [
    {
      name_prefix      = "tg-"
      backend_protocol = "TCP"
      backend_port     = 8000
      target_type      = "instance"
      vpc_id           = module.main-vpc.vpc_id
    }
  ]

  http_tcp_listeners = [
    {
      port               = 80
      protocol           = "TCP"
      target_group_index = 0
    }
  ]

  tags = {
    Environment = "Test"
  }
}

resource "aws_lb_target_group_attachment" "worker_1" {
  target_group_arn = module.nlb.target_group_arns[0]
  target_id        = module.worker_1_ec2_instance.id
  port             = 8000

  depends_on = [
    null_resource.worker_1_exec
  ]
}

resource "aws_lb_target_group_attachment" "worker_2" {
  target_group_arn = module.nlb.target_group_arns[0]
  target_id        = module.worker_2_ec2_instance.id
  port             = 8000

  depends_on = [
    null_resource.worker_2_exec
  ]
}
