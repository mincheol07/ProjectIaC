provider "aws" {
    region = "ap-northeast-1"
}

resource "aws_vpc" "fp-VPC" {
    cidr_block = "10.10.0.0/16"

    tags = {
      Name = "fp-VPC"
  }
}

resource "aws_subnet" "fp-Public-Subnet-01" {
    vpc_id = aws_vpc.fp-VPC.id
    cidr_block = "10.10.1.0/24"
    availability_zone = "ap-northeast-1a"
    tags = {
      Name = "fp-Public-Subnet-01"
    }
}


resource "aws_subnet" "fp-Public-Subnet-02" {
    vpc_id = aws_vpc.fp-VPC.id
    cidr_block = "10.10.2.0/24"
    availability_zone = "ap-northeast-1c"
    tags = {
      Name = "fp-Public-Subnet-02"
    }
}

resource "aws_subnet" "fp-Private-Subnet-01" {
    vpc_id = aws_vpc.fp-VPC.id
    cidr_block = "10.10.3.0/24"
    availability_zone = "ap-northeast-1a"
    tags = {
      Name = "fp-Private-Subnet-01"
    }
}

resource "aws_subnet" "fp-Private-Subnet-02" {
    vpc_id = aws_vpc.fp-VPC.id
    cidr_block = "10.10.4.0/24"
    availability_zone = "ap-northeast-1c"
    tags = {
      Name = "fp-Private-Subnet-02"
    }
}


resource "aws_subnet" "fp-DB-Private-Subnet-01" {
    vpc_id = aws_vpc.fp-VPC.id
    cidr_block = "10.10.5.0/24"
    availability_zone = "ap-northeast-1a"
    tags = {
      Name = "fp-DB-Private-Subnet-02"
    }
}

resource "aws_subnet" "fp-DB-Private-Subnet-02" {
    vpc_id = aws_vpc.fp-VPC.id
    cidr_block = "10.10.6.0/24"
    availability_zone = "ap-northeast-1c"
    tags = {
      Name = "fp-DB-Private-Subnet-02"
    }
}

