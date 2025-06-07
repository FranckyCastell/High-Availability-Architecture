# ACCOUNT VARIABLES
variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}
variable "aws_profile" {
  description = "The AWS profile to use for authentication"
  type        = string
}
variable "environment" {
  description = "The environment for which the resources are being deployed (e.g., test, prod)"
  type        = string
}
variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
# ACCOUNT VARIABLES

# S3 VARIABLES
variable "bucket_name" {
  description = "The name of the S3 bucket to create"
  type        = string
}
# S3 VARIABLES

# NETWORKING VARIABLES
variable "vpc_name" {
  description = "The name of the VPC to create"
  type        = string
}
variable "cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}
variable "azs" {
  description = "List of availability zones to use for the deployment"
  type        = list(string)
}
variable "public_subnets_cidr" {
  description = "List of CIDR blocks for public subnets"
  type        = list(string)
}
variable "private_subnets_cidr" {
  description = "List of CIDR blocks for private subnets"
  type        = list(string)
}
# NETWORKING VARIABLES

# ALB VARIABLES
variable "alb_name" {
  description = "The name of the Application Load Balancer"
  type        = string
}
# ALB VARIABLES

# SECURITY GROUP VARIABLES
variable "sg_name" {
  description = "The name of the security group for the Auto Scaling Group"
  type        = string
}
variable "sg_description" {
  description = "Description for the security group associated with the Auto Scaling Group"
  type        = string
}
# SECURITY GROUP VARIABLES

# ASG VARIABLES
variable "asg_name" {
  description = "The name of the Auto Scaling Group"
  type        = string
}
variable "asg_triggers" {
  description = "Triggers for the Auto Scaling Group instance refresh"
  type        = list(string)
}
variable "ami_id" {
  description = "The AMI ID to use for EC2 instances"
  type        = string
}
variable "ec2_instance_type" {
  description = "The type of EC2 instance to use"
  type        = string
}
# ASG VARIABLES
