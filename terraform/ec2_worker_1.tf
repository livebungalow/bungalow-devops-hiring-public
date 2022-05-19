locals {
  worker_1_ec2        = "${local.prefix}-ec2-1"
  worker_1_ec2_pascal = replace(title(replace(local.worker_1_ec2, "-", " ")), " ", "")
}

resource "aws_iam_role" "worker_1_ec2_instance_role" {
  name = "${local.worker_1_ec2_pascal}InstanceRole"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Sid" : "${local.worker_1_ec2_pascal}AssumeRole",
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Name = "${local.worker_1_ec2_pascal}InstanceRole"
  }
}

resource "aws_iam_role_policy_attachment" "worker_1_ec2_instance_role_attach_ssm_managed_instance_core" {
  role       = aws_iam_role.worker_1_ec2_instance_role.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
}

resource "aws_iam_instance_profile" "worker_1_ec2_instance_profile" {
  name = "${local.worker_1_ec2}-instance-profile"
  role = aws_iam_role.worker_1_ec2_instance_role.name
}

# https://registry.terraform.io/modules/terraform-aws-modules/ec2-instance/aws/latest
module "worker_1_ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "3.6.0"

  name = "${local.worker_1_ec2}-instance"

  iam_instance_profile = aws_iam_instance_profile.worker_1_ec2_instance_profile.name

  ami                    = data.aws_ami.ubuntu_ami.id
  instance_type          = "t2.nano"
  key_name               = "worker_key"
  monitoring             = true
  vpc_security_group_ids = [aws_security_group.sg.id]
  availability_zone      = module.main-vpc.azs[0]
  subnet_id              = module.main-vpc.public_subnets[0]

  associate_public_ip_address = true

  ebs_optimized = false

  tags = {
    Name     = "${local.worker_1_ec2}-instance"
    Function = "Docker Host"
  }
  depends_on = [
    module.main-vpc
  ]
}

resource "null_resource" "worker_1_copy" {
  provisioner "file" {
    source      = "../randomnumber"
    destination = "/home/ubuntu/randomnumber"
  }

  triggers = {
    policy_sha1 = "${sha1(file("../randomnumber/manage.py"))}"
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./worker_key.pem")
    host        = module.worker_1_ec2_instance.public_ip
  }
  depends_on = [
    module.worker_1_ec2_instance,
    module.main-vpc
  ]
}

resource "null_resource" "worker_1_exec" {
  provisioner "remote-exec" {
    inline = [
      "sleep 1",
      "sudo apt update",
      "sudo apt install -y python3-pip sqlite3 python3.8-venv",
      "cd randomnumber",
      "python3 -m venv .venv",
      "source .venv/bin/activate",
      "python3 -m pip install -r requirements.txt",
      "python3 manage.py migrate",
      "nohup python3 manage.py runserver 0.0.0.0:8000 &",
      "sleep 5"
    ]
  }

  triggers = {
    policy_sha1 = "${sha1(file("./ec2_worker_1.tf"))}"
  }


  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file("./worker_key.pem")
    host        = module.worker_1_ec2_instance.public_ip
  }
  depends_on = [
    module.worker_1_ec2_instance,
    null_resource.worker_1_copy
  ]
}

