# Create SG for LB, only TCP/80 and TCP/443 and outbound access
resource "aws_security_group" "lb_sg" {
  provider    = aws.region-master
  name        = "lb_sg"
  description = "Allow 443 and traffic to Jenkins SG"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    description = "Allow 443 from anywhere"
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    description = "Allow 80 from anywhere"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All ports
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Create SG for Jenkins, allowing TCP/8080 from * and and TCP/22 from specific IP in us-east-1
resource "aws_security_group" "jenkins_sg" {
  provider    = aws.region-master
  name        = "jenkins_sg"
  description = "Allow TCP/8080 and TCP/22"
  vpc_id      = aws_vpc.vpc_master.id
  ingress {
    description = "Allow 22 from a external IP"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = [var.external_ip]
  }
  ingress {
    description = "Allow anyone on port 8080 throught SG"
    from_port   = 8080
    to_port     = 8080
    protocol    = "tcp"
    cidr_blocks = [aws_security_group.lb_sg.id]
  }
  ingress {
    description = "Allow traffic from us-west-2"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["192.168.1.0/24"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # All ports
    cidr_blocks = ["0.0.0.0/0"]
  }
}