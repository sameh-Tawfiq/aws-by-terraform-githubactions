resource "aws_instance" "vm" {
  ami           = "ami-0359b3157f016ae46"
  instance_type = "t2.micro"
  tags = {
    Name = "my-first-tf-node2"
  }
}
