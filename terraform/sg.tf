resource "aws_security_group" "sg" {
  name        = "${local.prefix}-sg"
  description = "Security group usage with ${local.worker_1_ec2}-instance"
  vpc_id      = module.main-vpc.vpc_id

  tags = {
    Name = "${local.worker_1_ec2}-sg"
  }
}

resource "aws_security_group_rule" "ec2_sg_rule_egress_all" {
  description = "Allow all egress"
  type        = "egress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ec2_sg_http_rule_ingress_self" {
  description = "Allow ingress from self"
  type        = "ingress"
  from_port   = 0
  to_port     = 0
  protocol    = "-1"
  self        = true

  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "ec2_sg_ssh_rule_ingress" {
  description = "Allow SSH ingress"
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg.id
}

resource "aws_security_group_rule" "sg_http_rule_ingress" {
  description = "Allow HTTP ingress"
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "TCP"
  cidr_blocks = ["0.0.0.0/0"]

  security_group_id = aws_security_group.sg.id
}
