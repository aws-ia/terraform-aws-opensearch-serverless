<!-- BEGIN_TF_DOCS -->
# Terraform OpenSearch Serverless Module

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
| [aws_iam_session_context.current](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/data-sources/iam_session_context) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_public_access_network_policy"></a> [allow\_public\_access\_network\_policy](#input\_allow\_public\_access\_network\_policy) | Whether or not to allow public access to the OpenSearch collection endpoint and the Dashboards endpoint. | `bool` | `true` | no |
| <a name="input_analysis_analyzer"></a> [analysis\_analyzer](#input\_analysis\_analyzer) | A JSON string defining the analyzer applied to the index. | `string` | `null` | no |
| <a name="input_analysis_char_filter"></a> [analysis\_char\_filter](#input\_analysis\_char\_filter) | A JSON string defining the char filter applied to the index. | `string` | `null` | no |
| <a name="input_analysis_filter"></a> [analysis\_filter](#input\_analysis\_filter) | A JSON string defining the filters applied to the index. | `string` | `null` | no |
| <a name="input_analysis_normalizer"></a> [analysis\_normalizer](#input\_analysis\_normalizer) | A JSON string defining the normalizers applied to the index. | `string` | `null` | no |
| <a name="input_analysis_tokenizer"></a> [analysis\_tokenizer](#input\_analysis\_tokenizer) | A JSON string defining the tokenizer applied to the index. | `string` | `null` | no |
| <a name="input_collection_tags"></a> [collection\_tags](#input\_collection\_tags) | Tags to apply to the OpenSearch collection. | <pre>list(object({<br>        key   = string<br>        value = string<br>    }))</pre> | `[]` | no |
| <a name="input_create_vector_index"></a> [create\_vector\_index](#input\_create\_vector\_index) | Whether or not to create vector index. | `bool` | `false` | no |
| <a name="input_force_destroy_vector_index"></a> [force\_destroy\_vector\_index](#input\_force\_destroy\_vector\_index) | Whether or not to force destroy the vector index. | `bool` | `true` | no |
| <a name="input_index_knn_algo_param_ef_search"></a> [index\_knn\_algo\_param\_ef\_search](#input\_index\_knn\_algo\_param\_ef\_search) | The size of the dynamic list used during k-NN searches. Higher values lead to more accurate but slower searches. | `string` | `"512"` | no |
| <a name="input_number_of_replicas"></a> [number\_of\_replicas](#input\_number\_of\_replicas) | The number of replica shards. | `string` | `"1"` | no |
| <a name="input_number_of_shards"></a> [number\_of\_shards](#input\_number\_of\_shards) | The number of shards for the index. This setting cannot be changed after index creation. | `string` | `"1"` | no |
| <a name="input_vector_index_mappings"></a> [vector\_index\_mappings](#input\_vector\_index\_mappings) | A JSON string defining how documents in the index, and the fields they contain, are stored and indexed. To avoid the complexities of field mapping updates, updates of this field are not allowed via this provider. | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_opensearch_serverless_collection"></a> [opensearch\_serverless\_collection](#output\_opensearch\_serverless\_collection) | Opensearch collection value. |
| <a name="output_opensearch_serverless_data_policy"></a> [opensearch\_serverless\_data\_policy](#output\_opensearch\_serverless\_data\_policy) | Opensearch serverless data policy value. |
| <a name="output_vector_index"></a> [vector\_index](#output\_vector\_index) | Opensearch vector index value. |
<!-- END_TF_DOCS -->