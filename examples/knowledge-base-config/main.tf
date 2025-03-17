module "oss-for-knowledgebase" {
    source = "../.." # local example
    create_vector_index = true
    vector_index_mappings = <<-EOF
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