data "aws_eks_cluster" "fp-eks-cluster" {
  name = aws_eks_cluster.fp-eks-cluster.name
}


resource "aws_security_group" "fp-test" {
    name = "fp-test"
    vpc_id = aws_vpc.fp-VPC.id

    ingress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
  
  tags = {
    Name="test_security_group"
  }
}


resource "aws_security_group_rule" "allow_https_inbound" {
  type              = "ingress"
  from_port         = 443
  to_port           = 443
  protocol          = "tcp"
  security_group_id = data.aws_eks_cluster.fp-eks-cluster.vpc_config[0].cluster_security_group_id
  cidr_blocks       = ["0.0.0.0/0"]
}