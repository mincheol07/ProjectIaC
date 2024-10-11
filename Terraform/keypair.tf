
resource "tls_private_key" "fp-keypair" {
  algorithm = "RSA"
  rsa_bits = 4096
}

resource "aws_key_pair" "fp-keypair" {
  key_name = "FP_keypair.pem"
  public_key = tls_private_key.fp-keypair.public_key_openssh 
}

resource "local_file" "fp_keypair" {
  filename = "./FP_keypair.pem"
  content = tls_private_key.fp-keypair.private_key_pem 
  file_permission = "0400"
}
