resource "null_resource" "terraform-debug" {
  provisioner "local-exec" {
    command = "echo $VARIABLE1 > debug.txt ; cat $VARIABLE1 > debug2.txt ; "
    command = "echo [webservers] > ansible-tomcat/dev2.inv ; cat $VARIABLE2 >> ansible-tomcat/dev2.inv ; "


    environment = {
        VARIABLE1 = var.private_key_file
        VARIABLE2 = aws_instance.web1.public_ip
       
    }
  }
}



resource "aws_instance" "web1" {
   ami           = "${lookup(var.ami_id, var.region)}"
   instance_type = "t2.micro"
   vpc_security_group_ids = ["${aws_security_group.webSG.id}"]
   key_name = "myKeyPair"
   

    tags = {
    Name = "myFirstWebServer"
  }
 #   provisioner "remote-exec" {
 #   inline = [
 #     "cloud-init status --wait"
 #   ]
 # }

  provisioner "remote-exec" {
          # Leave this here so we know when to start with Ansible local-exec
    inline = [ "echo 'Cool, we are ready for provisioning'"]
  }

    provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
  }

    provisioner "file" {
    source      = "web/index.html"
    destination = "/tmp/index.html"
  }
    provisioner "file" {
    source      = "web/iei.jpg"
    destination = "/tmp/iei.jpg"
  }



  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "/tmp/script.sh args",
    ]
  }


    connection {
    user        = "ec2-user"
    private_key = "${file("${var.private_key_file}")}"
    host = "${aws_instance.web1.public_ip}"
    agent = false
    timeout = "3m"
  }

depends_on = [ aws_instance.web1 ]
 }



 resource "aws_security_group" "webSG" {
  name        = "webSG"
  description = "Allow ssh  inbound traffic"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80  
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  ingress {
    from_port   = 8080  
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port       = 0
    to_port         = 0
    protocol        = "-1"
    cidr_blocks     = ["0.0.0.0/0"]
    
  }
}
