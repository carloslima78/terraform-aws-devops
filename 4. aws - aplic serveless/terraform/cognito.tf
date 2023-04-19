

# Declara o resource User Pool (Grupo de Usuários)
resource "aws_cognito_user_pool" "my-pool" {

  name = var.service_name
  tags = local.common_tags
}

# Declara o resource User Pool Client 
resource "aws_cognito_user_pool_client" "my-client" {

  name            = var.service_name
  user_pool_id    = aws_cognito_user_pool.my-pool.id
  generate_secret = false

  allowed_oauth_flows                  = ["implicit"]
  allowed_oauth_flows_user_pool_client = true
  allowed_oauth_scopes                 = ["openid"]
  callback_urls                        = ["http://localhost:3000"]
  supported_identity_providers         = ["COGNITO"]
}

# Declara o resource User Pool Domain
resource "aws_cognito_user_pool_domain" "my-domain" {

  domain       = var.service_domain
  user_pool_id = aws_cognito_user_pool.my-pool.id
}


