# – OpenSearch Serverless Index – 

variable "create_vector_index" {
    description = "Whether or not to create vector index."
    type        = bool
    default     = false
}

variable "index_knn_algo_param_ef_search" {
    description = "The size of the dynamic list used during k-NN searches. Higher values lead to more accurate but slower searches."
    type        = string
    default     = "512"
}

variable "vector_index_mappings" {
    description = " A JSON string defining how documents in the index, and the fields they contain, are stored and indexed. To avoid the complexities of field mapping updates, updates of this field are not allowed via this provider."
    type        = string
    default     = <<-EOF
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
}