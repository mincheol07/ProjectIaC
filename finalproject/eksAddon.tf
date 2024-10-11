resource "aws_eks_addon" "vpc-cni" {
  cluster_name    = aws_eks_cluster.fp-eks-cluster.name
  addon_name      = "vpc-cni"
  service_account_role_arn = aws_iam_role.cni_role.arn
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "vpc-kube-proxy" {
  cluster_name    = aws_eks_cluster.fp-eks-cluster.name
  addon_name      = "kube-proxy"
  resolve_conflicts_on_create = "OVERWRITE"
}

resource "aws_eks_addon" "vpc-coredns" {
  cluster_name    = aws_eks_cluster.fp-eks-cluster.name
  addon_name      = "coredns"
  resolve_conflicts_on_create = "OVERWRITE"
  depends_on = [ aws_eks_cluster.fp-eks-cluster,aws_eks_node_group.fp-eks-node-group ]
}
