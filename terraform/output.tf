output "worker_1_hostname" {
  value = module.worker_1_ec2_instance.public_ip
}

output "worker_2_hostname" {
  value = module.worker_2_ec2_instance.public_ip
}

output "nlb_hostname" {
  value = module.nlb.lb_dns_name
}
