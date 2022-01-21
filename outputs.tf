output "cluster_endpoint" {
  description = "The endpoint of the EKS cluster"
  value       = aws_eks_cluster.default.endpoint
}

output "cluster_cert_authority_data" {
  description = "The cert authority data of the EKS cluster"
  value       = aws_eks_cluster.default.certificate_authority[0].data
}

output "cluster_id" {
  description = "The ID of the EKS cluster"
  value       = aws_eks_cluster.default.id
}
