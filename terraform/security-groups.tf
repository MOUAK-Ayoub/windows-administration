

resource "aws_security_group" "allow_windows_rdp" {
  name        = "allow_windows_rdp"
  description = "Allow windows RDP inbound traffic and all outbound traffic"
  vpc_id      = aws_vpc.main.id

  tags = {
    Name = "allow_rdp"
  }
}

resource "aws_security_group_rule" "allow_windows_rdp" {
  type              = "ingress"
  security_group_id = aws_security_group.allow_windows_rdp.id
  cidr_blocks       = [var.external-ip]
  from_port         = 3389
  to_port           = 3389
  protocol          = "tcp"

}
