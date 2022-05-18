locals {
  worker_2_ec2        = "${local.prefix}-ec2-2"
  worker_2_ec2_pascal = replace(title(replace(local.worker_2_ec2, "-", " ")), " ", "")
}

resource "aws_iam_role" "worker_2_ec2_instance_role" {
  name = "${local.worker_2_ec2_pascal}InstanceRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "${local.worker_2_ec2_pascal}AssumeRole",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.worker_2_ec2_pascal}InstanceRole"
  }
}

resource "aws_iam_role_policy_attachment" "worker_2_ec2_instance_role_attach_ssm_managed_instance_core" {
  role       = aws_iam_role.worker_2_ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "worker_2_ec2_instance_profile" {
  name = "${local.worker_2_ec2}-instance-profile"
  role = aws_iam_role.worker_2_ec2_instance_role.name
}

# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "worker_2_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.6.0"

  name = "${local.worker_2_ec2}-instance"

  iam_instance_profile = aws_iam_instance_profile.worker_2_ec2_instance_profile.name

  ami                    = data.aws_ami.amz_linux2_ami.id
  instance_type          = "t2.nano"
  key_name               = "worker_key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  availability_zone      = module.main-vpc.azs[0]
  subnet_id              = module.main-vpc.public_subnets[0]

  associate_public_ip_address = true

  ebs_optimized = true

  tags = {
    Name     = "${local.worker_2_ec2}-instance"
    Function = "Docker Host"
  }
}

resource "aws_instance" "worker_2_copy" {
  provisioner "file" {
    source      = "../randomnumber"
    destination = "/home/ec2-user"
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./worker_key.pem")
    host        = module.worker_1_ec2_instance.id.public_dns
  }
  depends_on = [
    module.worker_1_ec2_instance
  ]
}

resource "aws_instance" "worker_2_exec" {
  provisioner "remote-exec" {
    inline = [
      "cd randomnumber",
      "python -m venv .venv",
      "source .venv/bin/activate",
      "python -m pip install -r requirements.txt",
      "python manage.py migrate",
      "python manage.py createsuperuser",
      "python manage.py runserver",
    ]
  }
  connection {
    type        = "ssh"
    user        = "ec2-user"
    private_key = file("./worker_key.pem")
    host        = module.worker_1_ec2_instance.id.public_dns
  }
  depends_on = [
    module.worker_1_ec2_instance
  ]
}
