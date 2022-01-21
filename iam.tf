# IAM role and attachments for the cluster's control plane
resource "aws_iam_role" "cluster_control_plane_role" {
  name                  = "${var.cluster_name}-control-plane-role"
  description           = "Allows ${var.cluster_name} cluster control plane to manage EC2, Fargate, and Logs"
  force_detach_policies = true
  assume_role_policy    = file("${path.module}/policies/cluster_control_plane_role.json")
}

resource "aws_iam_role_policy_attachment" "cluster_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
  role       = aws_iam_role.cluster_control_plane_role.name
}

resource "aws_iam_role_policy_attachment" "cluster_vpc_resource_controller" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
  role       = aws_iam_role.cluster_control_plane_role.name
}

# Cluster Logging policies and attachments
resource "aws_iam_policy" "cluster_cloudwatch" {
  name   = "AmazonEKSClusterCloudWatchMetricsPolicy"
  policy = file("${path.module}/policies/cloudwatch_put_data.json")
}

resource "aws_iam_role_policy_attachment" "AmazonEKSCloudWatchMetricsPolicy" {
  policy_arn = aws_iam_policy.cluster_cloudwatch.arn
  role       = aws_iam_role.cluster_control_plane_role.name
}

# Kube system node group role, policies and attachments
resource "aws_iam_role" "default_node_group" {
  name               = "${var.cluster_name}-default-node-group"
  assume_role_policy = file("${path.module}/policies/kube_system_node_group_policy.json")
}

resource "aws_iam_role_policy_attachment" "default_node_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.default_node_group.name
}

resource "aws_iam_role_policy_attachment" "default_node_pod_networking_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.default_node_group.name
}

resource "aws_iam_role_policy_attachment" "default_node_container_read_policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.default_node_group.name
}
