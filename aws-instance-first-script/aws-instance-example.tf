resource "null_resource" "terraform-debug" {
  provisioner "local-exec" {
    command = "echo $VARIABLE1 >> debug.txt ;echo +++++++++++ >> debug.txt ;echo $VARIABLE2 >> debug.txt ; "

    environment = {
        VARIABLE1 = jsonencode(var.private_key)
        VARIABLE2 = var.private_key
      
    }
  }
}



resource "aws_instance" "web1" {
   ami           = "${lookup(var.ami_id, var.region)}"
   instance_type = "t2.micro"
   vpc_security_group_ids = ["sg-0595c8458d4d78fe9"]

    tags = {
    Name = "myFirstWebServer"
  }
   environment = {
        VARIABLE3 = jsonencode(var.private_key)
        
      
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
    private_key = VARIABLE3 # this is where you have to make the change
    host = "${aws_instance.web1.public_ip}"
  }

 }
