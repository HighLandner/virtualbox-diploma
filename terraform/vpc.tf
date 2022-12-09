resource "aws_vpc" "main" {
  cidr_block       = var.vpc_main_cidr
  instance_tenancy = "default"

  tags = {
    Name  = "main"
    Stage = "Diploma"
  }
}

resource "aws_subnet" "public" {
  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnet_cidr
  availability_zone = var.availability_zone

  tags = {
    Name  = "public-diploma"
    State = "public"
  }
}