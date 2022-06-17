variable "region" {
  default = "eu-west-1"
}

variable "ami_id" {
  type = map

  default = {
    eu-west-1    = "ami-035b3c7efe6d061d5"
    eu-west-2    = "ami-132b3c7efe6sdfdsfd"
    eu-south-1   = "ami-9787h5h6nsn"
  }
}
