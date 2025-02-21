resource "random_string" "solution_suffix" {
  length  = 4
  special = false
  upper   = false
}

data "aws_caller_identity" "current" {}

# – OpenSearch Serverless –

# Create a Collection
resource "awscc_opensearchserverless_collection" "os_collection" {
  name        = "os-collection-${random_string.solution_suffix.result}"
  type        = "VECTORSEARCH"
  description = "OpenSearch collection created by Terraform."
  depends_on = [
    aws_opensearchserverless_security_policy.security_policy,
    aws_opensearchserverless_security_policy.nw_policy
  ]
}

# Encryption Security Policy
resource "aws_opensearchserverless_security_policy" "security_policy" {
  name  = "security-policy-${random_string.solution_suffix.result}"
  type  = "encryption"
  policy = jsonencode({
    Rules = [
      {
        Resource     = ["collection/os-collection-${random_string.solution_suffix.result}"]
        ResourceType = "collection"
      }
    ],
    AWSOwnedKey = true
  })
}

# Network policy
resource "aws_opensearchserverless_security_policy" "nw_policy" {
  name  = "nw-policy-${random_string.solution_suffix.result}"
  type  = "network"
  policy = jsonencode([
    {
      Rules = [
        {
          ResourceType = "collection"
          Resource     = ["collection/os-collection-${random_string.solution_suffix.result}"]
        },
      ]
      AllowFromPublic = true,
    },
    {
      Description = "Public access for dashboards",
      Rules = [
        {
          ResourceType = "dashboard"
          Resource = [
            "collection/os-collection-${random_string.solution_suffix.result}"
          ]
        }
      ],
      AllowFromPublic = true
    }

  ])
}


# Data policy
resource "aws_opensearchserverless_access_policy" "data_policy" {
  name  = "os-access-policy-${random_string.solution_suffix.result}"
  type  = "data"
  policy = jsonencode([
    {
      Rules = [
        {
          ResourceType = "index"
          Resource = [
            "index/${awscc_opensearchserverless_collection.os_collection.name}/*"
          ]
          Permission = [
            "aoss:UpdateIndex",
            "aoss:DeleteIndex",
            "aoss:DescribeIndex",
            "aoss:ReadDocument",
            "aoss:WriteDocument",
            "aoss:CreateIndex"
          ]
        },
        {
          ResourceType = "collection"
          Resource = [
            "collection/${awscc_opensearchserverless_collection.os_collection.name}"
          ]
          Permission = [
            "aoss:DescribeCollectionItems",
            "aoss:DeleteCollectionItems",
            "aoss:CreateCollectionItems",
            "aoss:UpdateCollectionItems"
          ]
        }
      ],
      Principal = [
        data.aws_caller_identity.current.arn
      ]
    }
  ])
}

# OpenSearch index

resource "time_sleep" "wait_before_index_creation" {
  count           = var.create_oss_index ? 1 : 0
  depends_on      = [aws_opensearchserverless_access_policy.data_policy]
  create_duration = "60s" # Wait for 60 seconds before creating the index
}

resource "opensearch_index" "default_oss_index" {
  count                          = var.create_oss_index ? 1 : 0
  name                           = "os-index-${random_string.solution_suffix.result}"
  number_of_shards               = "2"
  number_of_replicas             = "0"
  index_knn                      = true
  index_knn_algo_param_ef_search = "512"
  mappings                       = <<-EOF
    {
      "properties": {
        "bedrock-knowledge-base-default-vector": {
          "type": "knn_vector",
          "dimension": 1536,
          "method": {
            "name": "hnsw",
            "engine": "faiss",
            "parameters": {
              "m": 16,
              "ef_construction": 512
            },
            "space_type": "l2"
          }
        },
        "AMAZON_BEDROCK_METADATA": {
          "type": "text",
          "index": "false"
        },
        "AMAZON_BEDROCK_TEXT_CHUNK": {
          "type": "text",
          "index": "true"
        }
      }
    }
  EOF
  force_destroy                  = true
  depends_on                     = [time_sleep.wait_before_index_creation[0], aws_opensearchserverless_access_policy.data_policy]
}
