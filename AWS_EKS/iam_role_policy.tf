resource "aws_iam_role" "eks_cluster_role" {
    
    assume_role_policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                "Action" = "sts:AssumeRole"
                "Effect" = "Allow"
                "Principal" = {
                    Service = "eks.amazonaws.com"
                }
            }
        ]
    })
}

resource "aws_iam_role_policy_attachment" "clusterPolicy" {
   role = aws_iam_role.eks_cluster_role.name
   policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "ServicePolicy" {
    role = aws_iam_role.eks_cluster_role.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSServicePolicy"
  
}


resource "aws_iam_role" "Nodegrouprole" {
    name = "nodegrouprole"
    assume_role_policy = jsonencode({

        Version = "2012-10-17"
        Statement = [
            {
                "Action" = "sts:AssumeRole"
                "Effect" = "Allow"
                "Principal" = {
                    Service = "ec2.amazonaws.com"
                }
            }
        ]

    })
  
}


resource "aws_iam_role_policy_attachment" "workernodepolicy" {
    role = aws_iam_role.Nodegrouprole.id
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  
}

resource "aws_iam_role_policy_attachment" "CNIPolicy" {
    role = aws_iam_role.Nodegrouprole.id
    policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  
}

resource "aws_iam_role_policy_attachment" "Ec2ContainerRegistryPolicy" {
    role = aws_iam_role.Nodegrouprole.name
    policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  
}


