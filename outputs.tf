output "opensearch_serverless_collection" {
  value       = awscc_opensearchserverless_collection.os_collection
  description = "Opensearch collection value."
}

output "opensearch_serverless_data_policy" {
  value = aws_opensearchserverless_access_policy.data_policy
  description = "Opensearch serverless data policy value."
}