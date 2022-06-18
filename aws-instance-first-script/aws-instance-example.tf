resource "null_resource" "terraform-debug" {
  provisioner "local-exec" {
    command = "echo $VARIABLE1 > debug.txt ; cat $VARIABLE1 > debug2.txt ; "

    environment = {
        VARIABLE1 = var.private_key_file
       
    }
  }
}



resource "aws_instance" "web1" {
   ami           = "${lookup(var.ami_id, var.region)}"
   instance_type = "t2.micro"
   vpc_security_group_ids = ["sg-0595c8458d4d78fe9"]
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

 }
