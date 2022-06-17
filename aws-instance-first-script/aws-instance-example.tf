resource "aws_instance" "web1" {
   ami           = "${lookup(var.ami_id, var.region)}"
   instance_type = "t2.micro"
   vpc_security_group_ids = ["sg-0595c8458d4d78fe9"]

    tags = {
    Name = "myFirstWebServer"
  }

    provisioner "remote-exec" {
    inline = [
      "cloud-init status --wait"
    ]
  }
    provisioner "file" {
    source      = "web/index.html"
    destination = "/opt/index.html"
  }
    provisioner "file" {
    source      = "web/iei.jpg"
    destination = "/opt/iei.jpg"
  }

    connection {
    user        = "ec2-user"
    private_key = "${TF_VAR_keypem}"
      host = "${aws_instance.web-server.public_ip}"
  }

 }
