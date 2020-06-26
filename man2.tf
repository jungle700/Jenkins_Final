provider "aws" {
profile = "default"
region  = "eu-west-1"
}

resource "aws_key_pair" "tkey" {
key_name   = "tkey"
 public_key = file(var.path_to_public_key)
}

resource "aws_instance" "terra" {
ami           = "ami-0ea3405d2d2522162"
instance_type = "t2.micro"
key_name = "tkey"
#user_data = "${data.template_file.myuserdata.template}"
user_data = data.template_file.myuserdata.template

}

output "instance_ips" {
  value = aws_instance.terra.*.public_ip
}


data "template_file" "myuserdata" {
  template = file("${path.cwd}/tunde.tpl")
}
#template = "${file("${path.cwd}/tunde.tpl")}"