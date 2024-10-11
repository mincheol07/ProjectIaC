resource "aws_eks_cluster" "fp-eks-cluster" {
    name = "fpekscluster"
    role_arn = aws_iam_role.eks_cluster_role.arn
    version = "1.28"
    vpc_config {
      subnet_ids = [ aws_subnet.fp-Public-Subnet-01.id,
                     aws_subnet.fp-Public-Subnet-02.id,
                     aws_subnet.fp-Private-Subnet-01.id,
                     aws_subnet.fp-Private-Subnet-02.id 
                  ]

      security_group_ids = [ aws_security_group.fp-test.id ]

      endpoint_private_access = true
      endpoint_public_access = false
    }
  
}


resource "aws_iam_openid_connect_provider" "eks_oidc" {
  client_id_list  = ["sts.amazonaws.com"]
  thumbprint_list = ["9e99a48a9960b14926bb7f3b4e54f1e9ca5a7da6"]

  # EKS 클러스터의 OIDC 공급자 URL을 자동으로 가져옴
  url = aws_eks_cluster.fp-eks-cluster.identity[0].oidc[0].issuer
}


resource "aws_eks_node_group" "fp-eks-node-group" {
    cluster_name = aws_eks_cluster.fp-eks-cluster.name
    node_role_arn = aws_iam_role.eks_node_role.arn
    subnet_ids = [ aws_subnet.fp-Private-Subnet-01.id, aws_subnet.fp-Private-Subnet-02.id ]
    capacity_type = "SPOT"
    instance_types = [ "t3.medium" ]
    ami_type = "AL2_x86_64"

    scaling_config {
      desired_size = 2
      max_size = 3
      min_size = 1
    }
  
}

