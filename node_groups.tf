# Default node group
resource "aws_eks_node_group" "default_ondemand" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "${var.cluster_name}-default"
  node_role_arn   = aws_iam_role.default_node_group.arn
  subnet_ids      = var.public_subnet_ids

  scaling_config {
    desired_size = 1
    max_size     = 3
    min_size     = 1
  }

  instance_types = ["t2.medium"]
  disk_size = 20
  capacity_type = "ON_DEMAND"

  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role_policy_attachment.default_node_policy,
    aws_iam_role_policy_attachment.default_node_pod_networking_policy,
    aws_iam_role_policy_attachment.default_node_container_read_policy,
  ]
}


# Spot node group
resource "aws_eks_node_group" "default_spot" {
  cluster_name    = aws_eks_cluster.default.name
  node_group_name = "${var.cluster_name}-default-spot"
  node_role_arn   = aws_iam_role.default_node_group.arn
  subnet_ids      = var.public_subnet_ids

  scaling_config {
    desired_size = 3
    max_size     = 6
    min_size     = 3
  }

  instance_types = ["t2.large"]
  disk_size = 20
  capacity_type = "SPOT"


  lifecycle {
    ignore_changes = [scaling_config[0].desired_size]
  }

  depends_on = [
    aws_iam_role_policy_attachment.default_node_policy,
    aws_iam_role_policy_attachment.default_node_pod_networking_policy,
    aws_iam_role_policy_attachment.default_node_container_read_policy,
  ]
}
