#VPC
resource "aws_vpc" "test-kaushik-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
    Name = "test-kaushik-vpc"
  }
}

#Internet gateway
resource "aws_internet_gateway" "test-kaushik-igw" {
    vpc_id = "${aws_vpc.test-kaushik-vpc.id}"
    tags = {
        Name = "test-kaushik-igw"
    }
}

#Private subnets
resource "aws_subnet" "test-kaushik-private-subnet-1" {
  vpc_id     = aws_vpc.test-kaushik-vpc.id
  cidr_block = "10.0.0.0/24"
  #availability_zone = "${aws_vpc.test-kaushik-vpc.region}a"
  availability_zone = "${var.region}a"
  tags = {
    Name = "test-kaushik-private-subnet-1"
  }
}

resource "aws_subnet" "test-kaushik-private-subnet-2" {
  vpc_id     = aws_vpc.test-kaushik-vpc.id
  cidr_block = "10.0.1.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "test-kaushik-private-subnet-2"
  }
}

#Public subnets
resource "aws_subnet" "test-kaushik-public-subnet-1" {
  vpc_id     = aws_vpc.test-kaushik-vpc.id
  cidr_block = "10.0.2.0/24"
  availability_zone = "${var.region}a"
  tags = {
    Name = "test-kaushik-public-subnet-1"
  }
}

resource "aws_subnet" "test-kaushik-public-subnet-2" {
  vpc_id     = aws_vpc.test-kaushik-vpc.id
  cidr_block = "10.0.3.0/24"
  availability_zone = "${var.region}b"
  tags = {
    Name = "test-kaushik-public-subnet-2"
  }
}

#Route tables
resource "aws_route_table" "test-kaushik-private-route-table" {
  vpc_id = aws_vpc.test-kaushik-vpc.id

  tags = {
    Name = "test-kaushik-private-route-table"
  }
}

resource "aws_route_table" "test-kaushik-public-route-table" {
  vpc_id = aws_vpc.test-kaushik-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.test-kaushik-igw.id
  }

  tags = {
    Name = "test-kaushik-public-route-table"
  }
}

#Route table associations
resource "aws_route_table_association" "test-kaushik-private-route-table-association-1" {
  subnet_id      = aws_subnet.test-kaushik-private-subnet-1.id
  route_table_id = aws_route_table.test-kaushik-private-route-table.id
}

resource "aws_route_table_association" "test-kaushik-private-route-table-association-2" {
  subnet_id      = aws_subnet.test-kaushik-private-subnet-2.id
  route_table_id = aws_route_table.test-kaushik-private-route-table.id
}

resource "aws_route_table_association" "test-kaushik-public-route-table-association-1" {
  subnet_id      = aws_subnet.test-kaushik-public-subnet-1.id
  route_table_id = aws_route_table.test-kaushik-public-route-table.id
}

resource "aws_route_table_association" "test-kaushik-public-route-table-association-2" {
  subnet_id      = aws_subnet.test-kaushik-public-subnet-2.id
  route_table_id = aws_route_table.test-kaushik-public-route-table.id
}