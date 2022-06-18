sudo amazon-linux-extras install -y java-openjdk11
java -version
sudo yum update -y
sudo yum install -y httpd.x86_64
sudo systemctl start httpd.service
sudo systemctl enable httpd.service
sudo cp /tmp/index.html /var/www/html/index.html
sudo cp /tmp/iei.jpg /var/www/html/iei.jpg

