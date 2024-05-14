/*resource "aws_security_group" "nonprod-redshift-sg" {
  name        = var.sg_name
  description = "Allow Redshift to connection form eks and rds"
  vpc_id      = var.vpc_id
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.20.0.0/16"]
    #cidr_blocks = var.port_cidr_blocks
  }
   ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "TCP"
    cidr_blocks = ["10.20.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = var.sg_tags
  }
}

*/