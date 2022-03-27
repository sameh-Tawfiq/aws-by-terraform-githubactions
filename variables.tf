variable "key_name" {
      description= "The name of key pairs"
      type= string
}

variable "public_key" {
      description = "The public key"
      type = string
}

variable "SG_name" {
      description = "The Security group name"
      type = string
}
variable "vpc_id" {
      description = "The id of the traget VPC"
      type = string
}
variable "ami" {
      description = "The ami id"
      type = string
}
variable "instance_type" {
      description = "The type of EC2 instance to be created"
      type = string
}
variable "tags" {
      description = "The EC2 tags"
      type = map(string)
}
