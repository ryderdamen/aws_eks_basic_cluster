resource "aws_cloudwatch_log_group" "cloudwatch_log_group" {
  name              = "/aws/eks/${var.environment}/${var.cluster_name}/control"
  retention_in_days = 7
  tags = {
    Name = "${var.cluster_name}-default-lg"
  }
}
