resource "aws_route_table" "fp-Public-routingtable" {
    vpc_id = aws_vpc.fp-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.fp-IGW.id
    }

    route {
        cidr_block = "172.24.0.0/24"
        gateway_id = aws_vpn_gateway.fp-VPG.id
    }

    tags = {
        Name = "fp-Public-routingtable"
    }
}


resource "aws_route_table_association" "public01-connection" {
    subnet_id = aws_subnet.fp-Public-Subnet-01.id
    route_table_id = aws_route_table.fp-Public-routingtable.id
}


resource "aws_route_table_association" "public02-connection" {
    subnet_id = aws_subnet.fp-Public-Subnet-02.id
    route_table_id = aws_route_table.fp-Public-routingtable.id
}


resource "aws_route_table" "fp-Private-routingtable" {
    vpc_id = aws_vpc.fp-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.fp-NAT-GW-01.id
    }
    route {
        cidr_block = "172.24.0.0/24"
        gateway_id = aws_vpn_gateway.fp-VPG.id
    }

    tags = {
        Name = "fp-Private-routingtable"
    }
}

resource "aws_route_table_association" "private01-connection" {
    subnet_id = aws_subnet.fp-Private-Subnet-01.id
    route_table_id = aws_route_table.fp-Private-routingtable.id
}

resource "aws_route_table_association" "private02-connection" {
    subnet_id = aws_subnet.fp-Private-Subnet-02.id
    route_table_id = aws_route_table.fp-Private-routingtable.id
}




resource "aws_route_table" "fp-DB-Private-routingtable" {
    vpc_id = aws_vpc.fp-VPC.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.fp-NAT-GW-01.id
    }

    route {
        cidr_block = "172.24.0.0/24"
        gateway_id = aws_vpn_gateway.fp-VPG.id
    }

    tags = {
      Name = "fp-DB-Private-routingtable"
    }
  
}


resource "aws_route_table_association" "DB-Private-01-connection" {
    subnet_id = aws_subnet.fp-DB-Private-Subnet-01.id
    route_table_id = aws_route_table.fp-DB-Private-routingtable.id 
}

resource "aws_route_table_association" "DB-Private-02-connection" {
    subnet_id = aws_subnet.fp-DB-Private-Subnet-02.id
    route_table_id = aws_route_table.fp-DB-Private-routingtable.id
}