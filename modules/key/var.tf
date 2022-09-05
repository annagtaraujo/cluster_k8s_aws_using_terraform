
variable "infra_name" {
  description = "Name to be used on all the resources as identifier"
  type        = string
  default     = ""
}

variable "key_name" {
  description = "Nome da chave de autenticação"
  type        = string
  default     = ""
}

variable "tags"{
  type        = map(string)
  default     = {}
}
