
resource "aws_instance" "fp-Public-EC2" {
  ami           = "ami-00c79d83cf718a893"
  instance_type = "t2.micro"
  key_name = aws_key_pair.fp-keypair.key_name
  subnet_id = aws_subnet.fp-Public-Subnet-01.id
  vpc_security_group_ids = [aws_security_group.fp-test.id]
  associate_public_ip_address = true

  tags = {
    Name = "fp-Public-EC2"
  }
}


resource "aws_instance" "fp-Private-EC2" {
  ami           = "ami-00c79d83cf718a893"
  instance_type = "t2.micro"
  key_name = aws_key_pair.fp-keypair.key_name
  subnet_id = aws_subnet.fp-Private-Subnet-01.id
  vpc_security_group_ids = [aws_security_group.fp-test.id]
  tags = {
    Name = "fp-Private-EC2"
  }
}