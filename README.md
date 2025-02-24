<!-- BEGIN_TF_DOCS -->
# Terraform OpenSearch Module

This module creates an Amazon OpenSearch Serverless collection optimized for vector search operations. OpenSearch Serverless automatically provisions and scales the underlying resources to deliver fast data ingestion and millisecond query response times.

## Vector Collection

This module creates an Amazon OpenSearch Serverless collection configured for VECTORSEARCH. It creates default encryption, network, and data policies for use with Amazon Bedrock Knowledge Bases. For encryption, it uses the default AWS owned KMS key. It allows network connections from the public internet, but access is restricted to specific IAM principals.

## Access Control

Access to the collection is secured through:

- IAM-based authentication
- Data access policies
- Network policies
- Encryption policies

## Vector Index

This module also supports the creation of a vector index. The vector index resource connects to OpenSearch and creates an index suitable for use with Amazon Bedrock Knowledge Bases. You can create a vector index by setting the input variable `create_vector_index` to `true`. You can pass in values for the `index_knn_algo_param_ef_search` and the `vector_index_mappings` or you can leave the default values.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.7 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | ~>5.0 |
| <a name="requirement_awscc"></a> [awscc](#requirement\_awscc) | >= 1.0.0 |
| <a name="requirement_opensearch"></a> [opensearch](#requirement\_opensearch) | = 2.2.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.6.0 |
| <a name="requirement_time"></a> [time](#requirement\_time) | ~> 0.6 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | ~>5.0 |
| <a name="provider_awscc"></a> [awscc](#provider\_awscc) | >= 1.0.0 |
| <a name="provider_opensearch"></a> [opensearch](#provider\_opensearch) | = 2.2.0 |
| <a name="provider_random"></a> [random](#provider\_random) | >= 3.6.0 |
| <a name="provider_time"></a> [time](#provider\_time) | ~> 0.6 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_opensearchserverless_access_policy.data_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_access_policy) | resource |
| [aws_opensearchserverless_security_policy.nw_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_security_policy) | resource |
| [aws_opensearchserverless_security_policy.security_policy](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/opensearchserverless_security_policy) | resource |
| [awscc_opensearchserverless_collection.os_collection](https://registry.terraform.io/providers/hashicorp/awscc/latest/docs/resources/opensearchserverless_collection) | resource |
| [opensearch_index.vector_index](https://registry.terraform.io/providers/opensearch-project/opensearch/2.2.0/docs/resources/index) | resource |
| [random_string.solution_suffix](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string) | resource |
| [time_sleep.wait_before_index_creation](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/sleep) | resource |
| [aws_caller_identity.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/caller_identity) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create_vector_index"></a> [create\_vector\_index](#input\_create\_vector\_index) | Whether or not to create vector index. | `bool` | `false` | no |
| <a name="input_index_knn_algo_param_ef_search"></a> [index\_knn\_algo\_param\_ef\_search](#input\_index\_knn\_algo\_param\_ef\_search) | The size of the dynamic list used during k-NN searches. Higher values lead to more accurate but slower searches. | `string` | `"512"` | no |
| <a name="input_vector_index_mappings"></a> [vector\_index\_mappings](#input\_vector\_index\_mappings) | A JSON string defining how documents in the index, and the fields they contain, are stored and indexed. To avoid the complexities of field mapping updates, updates of this field are not allowed via this provider. | `string` | `"{\n  \"properties\": {\n    \"bedrock-knowledge-base-default-vector\": {\n      \"type\": \"knn_vector\",\n      \"dimension\": 1536,\n      \"method\": {\n        \"name\": \"hnsw\",\n        \"engine\": \"faiss\",\n        \"parameters\": {\n          \"m\": 16,\n          \"ef_construction\": 512\n        },\n        \"space_type\": \"l2\"\n      }\n    },\n    \"AMAZON_BEDROCK_METADATA\": {\n      \"type\": \"text\",\n      \"index\": \"false\"\n    },\n    \"AMAZON_BEDROCK_TEXT_CHUNK\": {\n      \"type\": \"text\",\n      \"index\": \"true\"\n    }\n  }\n}\n"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_opensearch_serverless_collection"></a> [opensearch\_serverless\_collection](#output\_opensearch\_serverless\_collection) | Opensearch collection value. |
| <a name="output_opensearch_serverless_data_policy"></a> [opensearch\_serverless\_data\_policy](#output\_opensearch\_serverless\_data\_policy) | Opensearch serverless data policy value. |
| <a name="output_vector_index"></a> [vector\_index](#output\_vector\_index) | Opensearch vector index value. |
<!-- END_TF_DOCS -->