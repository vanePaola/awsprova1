sudo amazon-linux-extras install -y java-openjdk11
java -version
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
