
# Declara uma REST API, que será o proxy para a aplicação
resource "aws_api_gateway_rest_api" "this" {

  name = var.service_name
}

# Declara um recurso para a API "minhaapi/v1"
resource "aws_api_gateway_resource" "v1" {

  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_rest_api.this.root_resource_id
  path_part   = "v1"
}

# Declara um segundo recurso para a API "minhaapi/v1/todos"
resource "aws_api_gateway_resource" "todos" {

  rest_api_id = aws_api_gateway_rest_api.this.id
  parent_id   = aws_api_gateway_resource.v1.id
  path_part   = "todos"
}

# Declara o authorizer para a API, neste caso, será o Cognito declarado no arquivo cognito.tf
resource "aws_api_gateway_authorizer" "this" {

  rest_api_id   = aws_api_gateway_rest_api.this.id
  name          = "CognitoUserPoolAuthorizer"
  type          = "COGNITO_USER_POOLS"
  provider_arns = [aws_cognito_user_pool.my-pool.arn]
}

# Declara os métodos que a API vai responder (GET, PUT, POST, DELETE)
resource "aws_api_gateway_method" "any" {

  rest_api_id   = aws_api_gateway_rest_api.this.id
  resource_id   = aws_api_gateway_resource.todos.id
  authorization = "COGNITO_USER_POOLS"
  http_method   = "ANY"
  authorizer_id = aws_api_gateway_authorizer.this.id
}

# Declara a integração
resource "aws_api_gateway_integration" "this" {

  rest_api_id             = aws_api_gateway_rest_api.this.id
  resource_id             = aws_api_gateway_resource.todos.id
  http_method             = aws_api_gateway_method.any.http_method
  integration_http_method = "POST"
  type                    = "AWS_PROXY"
  uri                     = aws_lambda_function.dynamo.invoke_arn
}

# Declara um deployment
resource "aws_api_gateway_deployment" "this" {

  rest_api_id = aws_api_gateway_rest_api.this.id
  stage_name  = "dev"

  depends_on = [aws_api_gateway_integration.this]
}