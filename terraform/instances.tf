data "aws_ssm_parameter" "ami-windows-server-2019" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2019-English-Full-Base"
}


resource "aws_instance" "master" {

  ami           = data.aws_ssm_parameter.ami-windows-server-2019.value
  instance_type = var.instance-type

  key_name = aws_key_pair.key.key_name

  vpc_security_group_ids = [aws_security_group.allow_windows_rdp.id]
  subnet_id              = aws_subnet.subnet-main.id

  associate_public_ip_address = true
  count                       = var.instance-count

  tags = {
    Name = count.index == 0 ? "DomainController" : "Slave-${count.index}"
  }

  depends_on = [aws_main_route_table_association.vpc_route_asso]

}

