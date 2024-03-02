data "aws_ssm_parameter" "ami-windows-server-2019" {
  name = "/aws/service/ami-windows-latest/Windows_Server-2019-English-Full-Base"
}

data "template_file" "master-user-data" {
  template = file("./files/install_ad.ps1")
  vars = {
    domain_name = "${var.domain-name}"
    pwd         = "${var.pwd}"
    ad_user = jsonencode(
      "${var.ad-user}"
    )

  }
}

data "template_file" "slave-user-data" {
  count    = var.instance-count
  template = file("./files/script_on_launch.ps1")
  vars = {
    slave_number = "${count.index + 1}"
    domain_name  = "${var.domain-name}"
    logon_name   = "${var.ad-user[count.index].logon_name}"
    pwd          = "${var.ad-user[count.index].pwd}"

    master_private_ip = "${aws_instance.master.private_ip}"

  }
}

resource "aws_instance" "master" {

  ami           = data.aws_ssm_parameter.ami-windows-server-2019.value
  instance_type = var.master-instance-type

  key_name = aws_key_pair.key.key_name

  vpc_security_group_ids = [aws_security_group.allow_windows_rdp.id]
  subnet_id              = aws_subnet.subnet-main.id

  associate_public_ip_address = true
  user_data                   = data.template_file.master-user-data.rendered
  tags = {
    Name = "DomainController"
  }

  depends_on = [aws_main_route_table_association.vpc_route_asso]

}


resource "aws_instance" "slave" {

  ami           = data.aws_ssm_parameter.ami-windows-server-2019.value
  instance_type = var.slave-instance-type

  key_name = aws_key_pair.key.key_name

  vpc_security_group_ids = [aws_security_group.allow_windows_rdp.id]
  subnet_id              = aws_subnet.subnet-main.id

  user_data = data.template_file.slave-user-data[count.index].rendered

  associate_public_ip_address = true
  count                       = var.instance-count
  tags = {
    Name = "Slave-${count.index + 1}"
  }

  depends_on = [aws_main_route_table_association.vpc_route_asso, aws_instance.master]

}
