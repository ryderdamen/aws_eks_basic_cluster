resource "aws_eks_fargate_profile" "default" {
  cluster_name           = aws_eks_cluster.default.name
  fargate_profile_name   = "${var.cluster_name}-fargate-profile"
  pod_execution_role_arn = aws_iam_role.default_fargate_pod_execution_role.arn
  subnet_ids             = var.private_subnet_ids

  selector {
    namespace = var.default_fargate_k8_namespace
  }

  timeouts {
    create = "25m"
    delete = "25m"
  }

  depends_on = [
    aws_iam_role_policy_attachment.default_fargate_vpc_resource_controller,
    aws_iam_role_policy_attachment.default_fargate_cluster_policy,
    aws_iam_role_policy_attachment.default_fargate_pod_execution_policy,
  ]
}
