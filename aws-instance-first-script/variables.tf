variable "region" {
  default = "eu-west-1"
}

variable "ami_id" {
  type = map

  default = {
    eu-west-1    = "ami-d12741a2"
    eu-west-2    = "ami-d12741a2"
    eu-south-1   = "ami-d12741a2"
  }
}

variable "private_key" {
  type = string
  description = "SSH private key for accessing the EC2 instance."
}

variable "private_key_file" {
  type = string
  description = "SSH private key for accessing the EC2 instance."
}
