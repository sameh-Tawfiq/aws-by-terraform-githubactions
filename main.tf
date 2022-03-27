resource "aws_key_pair" "Sameh_key_pair" {
  key_name   = var.key_name
  public_key = var.public_key
}

resource "aws_security_group" "Sameh-SG" {
  name        = var.SG_name
  description = "Allow SSH inbound traffic only"
  vpc_id      = var.vpc_id
  ingress {
    description      = "SSH allowed"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  ingress {
    description      = "HTTP allowed"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  egress {
    description      = "ALL"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

/*
output "Security_group" {
  value = aws_security_group.Sameh-SG
}
*/

resource "aws_instance" "vm" {
  ami           = var.ami
  instance_type = var.instance_type
  key_name = aws_key_pair.Sameh_key_pair.key_name
  vpc_security_group_ids = [aws_security_group.Sameh-SG.id]
  tags = var.tags
  provisioner "remote-exec" {
    inline = [
      "sudo yum -y install httpd && sudo systemctl start httpd",
      "echo '<h1><center>My Test Website With Help From Terraform Provisioner</center></h1>' > index.html",
      "sudo mv index.html /var/www/html/"
    ]
    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/id_rsa")
      host        = self.public_ip
    }
  }
}
