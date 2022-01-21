resource "aws_eks_cluster" "default" {
  name     = var.cluster_name
  role_arn = aws_iam_role.cluster_control_plane_role.arn

  vpc_config {
    subnet_ids = concat(var.private_subnet_ids, var.public_subnet_ids)
  }

  depends_on = [
    aws_iam_role_policy_attachment.cluster_policy,
    aws_iam_role_policy_attachment.cluster_vpc_resource_controller,
  ]

  timeouts {
    create = "25m"
    delete = "25m"
  }
}
