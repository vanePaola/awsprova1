output "public_ip" {
    description = "My Public IP"
    value = try(aws_instance.web1.public_ip,"")
}