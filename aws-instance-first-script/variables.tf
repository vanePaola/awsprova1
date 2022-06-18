variable "region" {
  default = "eu-west-1"
}

variable "ami_id" {
  type = map

  default = {
    eu-west-1    = "ami-0d71ea30463e0ff8d"
    eu-west-2    = "ami-0d71ea30463e0ff8d"
    eu-south-1   = "ami-0d71ea30463e0ff8d"
  }
}


variable "private_key_file" {
  type = string
  description = "SSH private key for accessing the EC2 instance."
}
