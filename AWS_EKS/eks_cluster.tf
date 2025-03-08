resource "aws_eks_cluster" "eks_cluster" {
    name = var.eks_cluster_name
    role_arn = aws_iam_role.eks_cluster_role.arn
    vpc_config {
      subnet_ids = ["subnet ids of 2 different AZ's"]
    }

    tags = {
      Name = var.eks_cluster_tag_name
    }
  
}






