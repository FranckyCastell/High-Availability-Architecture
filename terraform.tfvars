# ACCOUNT VARIABLES
aws_region  = "eu-west-1"
aws_profile = "" # AWS profile to use
environment = "test"
tags = {
  environment = "test"
  project     = "High Availability Architecture"
  owner      = "Francesc Castell"
}
# ACCOUNT VARIABLES

# S3 VARIABLES
bucket_name = "helloworldfrancesc-test-bucket"
# S3 VARIABLES

# NETWORKING VARIABLES
vpc_name             = "high-availability-vpc"
cidr                 = "10.0.0.0/16"
azs                  = ["eu-west-1a", "eu-west-1b"]
public_subnets_cidr  = ["10.0.0.0/20", "10.0.16.0/20"]
private_subnets_cidr = ["10.0.32.0/20", "10.0.48.0/20"]
# NETWORKING VARIABLES

# ALB VARIABLES
alb_name = "high-availability-alb"
# ALB VARIABLES

# SECURITY GROUP VARIABLES
sg_name        = "high-availability-sg"
sg_description = "Security group for the Auto Scaling Group in the High Availability Architecture"
# SECURITY GROUP VARIABLES

# ASG VARIABLES
asg_name          = "high-availability-asg"
asg_triggers      = ["desired_capacity", "min_size", "max_size"]
ami_id            = "ami-03400c3b73b5086e9"
ec2_instance_type = "t3.micro"
# ASG VARIABLES
