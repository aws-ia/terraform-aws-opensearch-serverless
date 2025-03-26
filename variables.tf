# - OpenSearch Serverless Collection -

variable "collection_tags" {
    description = "Tags to apply to the OpenSearch collection."
    type        = list(object({
        key   = string
        value = string
    }))
    default     = []
}

variable "allow_public_access_network_policy" {
    description = "Whether or not to allow public access to the OpenSearch collection endpoint and the Dashboards endpoint."
    type        = bool
    default     = true
}

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

variable "number_of_shards" {
    description = "The number of shards for the index. This setting cannot be changed after index creation."
    type        = string
    default     = "1"
}

variable "number_of_replicas" {
   description = "The number of replica shards." 
   type        = string
   default     = "1"

}

variable "vector_index_mappings" {
    description = " A JSON string defining how documents in the index, and the fields they contain, are stored and indexed. To avoid the complexities of field mapping updates, updates of this field are not allowed via this provider."
    type        = string
    default     = null
}

variable "force_destroy_vector_index" {
   description = "Whether or not to force destroy the vector index."
   type        = bool
   default     = true
}

# Analysis Plugins

variable "analysis_analyzer" {
    description = "A JSON string defining the analyzer applied to the index."
    type        = string
    default     = null
}

variable "analysis_char_filter" {
    description = "A JSON string defining the char filter applied to the index."
    type        = string
    default     = null
}

variable "analysis_filter" {
    description = "A JSON string defining the filters applied to the index."
    type        = string
    default     = null
}

variable "analysis_normalizer" {
    description = "A JSON string defining the normalizers applied to the index."
    type        = string
    default     = null
}

variable "analysis_tokenizer" {
    description = "A JSON string defining the tokenizer applied to the index."
    type        = string
    default     = null
}
