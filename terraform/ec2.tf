data "aws_ami" "ubuntu_20_04" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-focal-20.04-amd64-server-*"]
  }
  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
  owners = ["099720109477"]
}

resource "aws_instance" "web" {
  ami           = data.aws_ami.ubuntu_20_04.id
  instance_type = var.jenkins_instance_type
  subnet_id     = aws_subnet.public.id
  user_data_base64 = 

  tags = {
    Name = "jenkins"
  }
}