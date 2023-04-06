
// Recurso para criar três usuários IAM conforme interação foreach.
resource "aws_iam_user" "users" {
  
  for_each = toset (["Carlos", "Kelli", "Carol"])

  name = each.key
}