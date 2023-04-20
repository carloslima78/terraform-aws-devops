

# Assume a role e torna a Lambda capaz de se integrar a outros serviços da AWS
data "aws_iam_policy_document" "lambda-assume-role" {
  statement {
    actions = ["sts:AssumeRole"]

    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

# --------------- S3 Role --------------------

# Data contendo as Policies para permitir que a Lambda faça interação com recursos do S3, SNS, Lambda e CloudWatch
data "aws_iam_policy_document" "s3" {

  # Política que permite que Lambda execute ações no S3 e SNS
  statement {
    sid    = "AllowS3AndSNSActions"
    effect = "Allow"

    // Permitirá ações em todos os recursos no S3 e SNS
    resources = ["*"]

    # Permitirá todas as ações no S3 e SNS
    actions = [
      "s3:*",
      "sns:*",
    ]
  }

  # Política que permite que a Lambda invoque outras Lambdas
  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:*:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  # Política que permite que a Lambda crie grupos no CloudWatch
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  # Política que permite que a Lambda escreva Logs no CloudWatch
  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

# Declara a IAM Role 
resource "aws_iam_role" "s3" {

  name               = "${var.service_domain}-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

# Declara a IAM Policy
resource "aws_iam_policy" "s3" {

  name   = "${aws_lambda_function.s3.function_name}-lambda-execute-policy"
  policy = data.aws_iam_policy_document.s3.json
}

# Declara que a IAM Policy está sendo anexada na IAM Role
resource "aws_iam_role_policy_attachment" "s3-execute" {

  policy_arn = aws_iam_policy.s3.arn
  role       = aws_iam_role.s3.name
}

# --------------- Dynamo Role --------------------

# Data contendo as Policies para permitir que a Lambda faça interação com recursos do DynamoDB
data "aws_iam_policy_document" "dynamo" {
  statement {
    sid       = "AllowDynamoPermissions"
    effect    = "Allow"
    resources = ["*"]

    actions = ["dynamodb:*"]
  }

  # Política que permite que o Dynamo invoque funções Lambdas
  statement {
    sid       = "AllowInvokingLambdas"
    effect    = "Allow"
    resources = ["arn:aws:lambda:*:*:function:*"]
    actions   = ["lambda:InvokeFunction"]
  }

  # Política que permite que o Dynamo crie grupos no CloudWatch
  statement {
    sid       = "AllowCreatingLogGroups"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:*"]
    actions   = ["logs:CreateLogGroup"]
  }

  # Política que permite que o Dynamo escreva logs no CloudWatch
  statement {
    sid       = "AllowWritingLogs"
    effect    = "Allow"
    resources = ["arn:aws:logs:*:*:log-group:/aws/lambda/*:*"]

    actions = [
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
  }
}

# Declara a IAM Role 
resource "aws_iam_role" "dynamo" {

  name               = "dynamo-lambda-role"
  assume_role_policy = data.aws_iam_policy_document.lambda-assume-role.json
}

# Declara a IAM Policy 
resource "aws_iam_policy" "dynamo" {

  name   = "dynamo-lambda-execute-policy"
  policy = data.aws_iam_policy_document.dynamo.json
}

# Declara que a IAM Policy está sendo anexada na IAM Role
resource "aws_iam_role_policy_attachment" "dynamo" {

  policy_arn = aws_iam_policy.dynamo.arn
  role       = aws_iam_role.dynamo.name
}