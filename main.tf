provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIA32NYOY3VSSQ4WAZQ"
  secret_key = "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"
}

resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "OWN_VPC"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "ap-south-1a"

  tags = {
    Name = "subnet-1"
  }
}
resource "aws_subnet" "subnet-2" {

  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.11.0/24"
  availability_zone = "ap-south-1b"

  tags = {

    Name = "subnet-2"
  }
}
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.my_vpc.id

  tags = {
    Name = "Own-IGW"
  }
}
resource "aws_route_table" "route_pub" {
 vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.gw.id
  }
}
resource "aws_route_table_association" "rta_1" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.route_pub.id
}
