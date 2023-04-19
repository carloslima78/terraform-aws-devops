

# Declara a tabela no DynamoDB
resource "aws_dynamodb_table" "my-table" {

  hash_key       = "TodoId"
  name           = var.service_name
  read_capacity  = 5
  write_capacity = 5

  attribute {

    name = "TodoId"
    type = "S"
  }

  tags = local.common_tags
}

# Declara um item a ser inserido na tabela DynamoDB
resource "aws_dynamodb_table_item" "my-item" {

  table_name = aws_dynamodb_table.my-table.name
  hash_key   = aws_dynamodb_table.my-table.hash_key

  item = <<ITEM
    {
        "TodoId": {"S": "1"},
        "Task": {"S": "Aprender Terraform"},
        "Done": {"S": "0"}
    }
    ITEM   
}