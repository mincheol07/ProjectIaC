resource "aws_internet_gateway" "fp-IGW" {
    vpc_id = aws_vpc.fp-VPC.id
    tags = {
        Name = "fp-IGW"
    }
}
