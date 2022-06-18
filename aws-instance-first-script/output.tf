output "public_ip" {
    description = "My Public IP"
    value = try(aws_instance.web1.public_ip,"")
}

output "public_url" {
    description = "My Public IP"
    value = "<a href='http://"+public_ip+"'>Start Here</a>"
}