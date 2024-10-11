resource "aws_eip" "fp-NAT-eip-01" {
  domain   = "vpc"
}

resource "aws_eip" "fp-NAT-eip-02" {
  domain   = "vpc"
}



resource "aws_nat_gateway" "fp-NAT-GW-01" {
    subnet_id = aws_subnet.fp-Public-Subnet-01.id
    allocation_id = aws_eip.fp-NAT-eip-01.id
    connectivity_type = "public"
    tags = {
        Name = "fp-NAT-GW-01"
    }
} 


resource "aws_nat_gateway" "fp-NAT-GW-02" {
    subnet_id = aws_subnet.fp-Public-Subnet-02.id
    allocation_id = aws_eip.fp-NAT-eip-02.id
    connectivity_type = "public"
    tags = {
        Name = "fp-NAT-GW-02"
    }
}