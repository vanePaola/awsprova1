output "public_ip" {
    description = "My Public IP"
    value = try(aws_instance.web1.public_ip,"")
}

locals {
  myIp = try(aws_instance.web1.public_ip,"")
}

output "public_url" {
    description = "My Public IP"
    value = "<a href='http://"+local.myIp+"'>Start Here</a>"
}