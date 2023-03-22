variable "aws_region" {
  default = "us-east-1"
}

variable "ami_id" {
  default = "ami-0557a15b87f6559cf" # Amazon ubuntu jammy
}

variable "instance_type" {
  default = "t2.micro"
}

variable "key_pair" {
  type        = string
  description = "Name of the key pair to use for SSH access"
  default = "new-key"
}
