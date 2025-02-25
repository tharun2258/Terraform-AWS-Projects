resource "aws_eks_cluster" "eks_cluster" {
    name = "demo-eks-cluster-terraform"
    role_arn = aws_iam_role.eks_cluster_role.arn
    vpc_config {
      subnet_ids = ["subnet ids of 2 different AZ's"]
    }

    tags = {
      Name = "eks-demo"
    }
  
}






