resource "aws_instance" "web1" {
   ami           = "${lookup(var.ami_id, var.region)}"
   instance_type = "t2.micro"
   vpc_security_group_ids = [sg-0595c8458d4d78fe9]

    tags = {
    Name = "myFirstWebServer"
  }
 }
