resource "tls_private_key" "key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_file" "key" {
  content  = tls_private_key.key.private_key_pem
  filename = "win_key.pem"
}

resource "aws_key_pair" "key" {
  key_name   = "win-key"
  public_key = tls_private_key.key.public_key_openssh
}
