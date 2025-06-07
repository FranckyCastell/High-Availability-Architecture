data "aws_instances" "asg_instances" {
  filter {
    name   = "tag:aws:autoscaling:groupName"
    values = [module.asg.autoscaling_group_name]
  }

  filter {
    name   = "instance-state-name"
    values = ["running"]
  }

  depends_on = [module.asg]
}

output "nat_gateway_public_ips" {
  description = "Public IP addresses of the NAT Gateways"
  value       = module.vpc.nat_public_ips
}

output "alb_url" {
  description = "URL of the Application Load Balancer"
  value       = "http://${module.alb.dns_name}"
}
