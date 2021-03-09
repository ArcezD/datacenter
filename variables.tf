variable "repo_url" {
  description = "Git repo url"
  type        = string
  default     = "https://github.com/ArcezD/datacenter"
}

variable "vpc_cidr_block" {
  description = "AWS VPC cidr block"
  type        = string
}

variable "subnet_cidr_block" {
  description = "AWS subnet cidr block"
  type        = string
}

variable "ec2_ip_address" {
  description = "AWS ec2 ip address"
  type        = string
}

variable "ec2_keypair_name" {
  description = "SSH key pair name"
  type        = string
}

variable "ec2_keypair_value" {
  description = "SSH key pair value"
  type        = string
}