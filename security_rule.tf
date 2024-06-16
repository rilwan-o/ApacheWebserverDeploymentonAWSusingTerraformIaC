# Allow traffic from the load balancer to the instances
resource "aws_security_group_rule" "instance_from_lb" {
  type                     = "ingress"
  from_port                = 3000
  to_port                  = 3000
  protocol                 = "tcp"
  security_group_id        = aws_security_group.instance_sg.id
  source_security_group_id = aws_security_group.sg.id
}
