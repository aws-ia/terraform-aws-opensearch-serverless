module "oss-for-knowledgebase" {
    source = "../.." # local example
    create_vector_index = true
    analysis_char_filter = jsonencode({
        "icu_normalizer": {
            "type": "icu_normalizer"
        }
    })

    analysis_analyzer = jsonencode({
        "kuromoji_analyzer": {
            "type": "custom",
            "tokenizer": "kuromoji_tokenizer",
            "char_filter": ["icu_normalizer"],
            "filter": [
                "kuromoji_baseform",
                "ja_stop"
            ]
        }
    })

    analysis_tokenizer = jsonencode({
        "kuromoji_tokenizer": {
            "type": "kuromoji_tokenizer",
            "mode": "search"
        }
    })

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
