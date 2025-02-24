output "opensearch_serverless_collection" {
  value       = awscc_opensearchserverless_collection.os_collection
  description = "Opensearch collection value."
}

output "opensearch_serverless_data_policy" {
  value       = aws_opensearchserverless_access_policy.data_policy
  description = "Opensearch serverless data policy value."
}

output "vector_index" {
    value       = var.create_vector_index ? opensearch_index.vector_index[0] : null
    description = "Opensearch vector index value."
}