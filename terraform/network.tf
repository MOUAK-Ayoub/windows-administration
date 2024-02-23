data "aws_availability_zones" "azs" {
  state = "available"
}


resource "aws_vpc" "main" {

  cidr_block           = "10.0.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support   = true
  tags = {
    Name = "main_vpc"
  }

}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
}


resource "aws_subnet" "subnet-main" {
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.1.0/24"
}


resource "aws_route_table" "main-route" {
  vpc_id = aws_vpc.main.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id

  }

  lifecycle {
    ignore_changes = all
  }

  tags = {
    Name = "Route table of the main vpc"
  }
}


resource "aws_main_route_table_association" "vpc_route_asso" {
  route_table_id = aws_route_table.main-route.id
  vpc_id         = aws_vpc.main.id

}

