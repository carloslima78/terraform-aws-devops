
# Declara uma VPC, rede privada na conta AWS
resource "aws_vpc" "this" {

  cidr_block = "192.168.0.0/16"
  tags       = merge(local.common_tags, { Name = "Terraform VPC " })
}

# Declara um Internet Gateway que estará associado ao VPC para estabelcer a camada de entrada na rede privada via Internet
resource "aws_internet_gateway" "this" {

  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "Terraform IGW " })
}

# Declara a subnet pública que estará associada ao VPC e zona de disponibilidade A
resource "aws_subnet" "public_a" {

  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.0.0/24"
  availability_zone = "${var.aws_region}a"

  tags = merge(local.common_tags, { Name = "Public A" })
}

# Declara a subnet pública que estará associada ao VPC e zona de disponibilidade B
resource "aws_subnet" "public_b" {

  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.1.0/24"
  availability_zone = "${var.aws_region}b"

  tags = merge(local.common_tags, { Name = "Public B" })
}

# Declara a subnet privada que estará associada ao VPC e zona de disponibilidade A
resource "aws_subnet" "private_a" {

  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.2.0/24"
  availability_zone = "${var.aws_region}a"

  tags = merge(local.common_tags, { Name = "Private A" })
}

# Declara a subnet privada que estará associada ao VPC e zona de disponibilidade B
resource "aws_subnet" "private_b" {

  vpc_id            = aws_vpc.this.id
  cidr_block        = "192.168.3.0/24"
  availability_zone = "${var.aws_region}b"

  tags = merge(local.common_tags, { Name = "Private B" })
}

/*
  O código abaixo refatora e substitui os 4 blocos das Subnets acima:

  - Otimiza a declaração das Subnets, onde são declaradas por meio de interação foreach, evitando
  a duplicação do código e substituindo os 4 blocos acima em um único bloco.

# Declara as Subnets públicas A e B e as Subnets privadas A e B que estarão associadas ao VPC
resource "aws_subnet" "this" {
  
  for_each = {

    "pub_a" : ["192.168.1.0/24", "${var.aws_region}a", "Public A"]
    "pub_b" : ["192.168.2.0/24", "${var.aws_region}b", "Public B"]
    "pvt_a" : ["192.168.3.0/24", "${var.aws_region}a", "Private A"]
    "pvt_b" : ["192.168.4.0/24", "${var.aws_region}b", "Private B"]
  }

  vpc_id            = aws_vpc.this.id
  cidr_block        = each.value[0]
  availability_zone = each.value[1]

  tags = merge(local.common_tags, { Name = each.value[2] })
}


*/

# Declara uma Route Table pública 
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {

    # Acesso aberto para qualquer endereço da internet
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = merge(local.common_tags, { Name = "Terraform Public" })
}

# Declara uma Route Table privada 
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags   = merge(local.common_tags, { Name = "Terraform Private" })
}

# Declara uma associação entre a subnet pública A e a route table pública
resource "aws_route_table_association" "public_a_association" {

  subnet_id      = aws_subnet.public_a.id
  route_table_id = aws_route_table.public.id
}

# Declara uma associação entre a subnet pública B e a route table pública
resource "aws_route_table_association" "public_b_association" {

  subnet_id      = aws_subnet.public_b.id
  route_table_id = aws_route_table.public.id
}

# Declara uma associação entre a subnet privada A e a route table privada
resource "aws_route_table_association" "private_a_association" {

  subnet_id      = aws_subnet.private_a.id
  route_table_id = aws_route_table.private.id
}

# Declara uma associação entre a subnet privada B e a route table privada
resource "aws_route_table_association" "private_b_association" {

  subnet_id      = aws_subnet.private_b.id
  route_table_id = aws_route_table.private.id
}


/*

  O código abaixo refatora e substitui os 4 blocos das associações entre subnets e route tables acima:

# resource "aws_route_table_association" "this" {
  
#   for_each = local.subnet_ids

#   subnet_id      = each.value
#   route_table_id = substr(each.key, 0, 3) == "Pub" ? aws_route_table.public.id : aws_route_table.private.id
# }

*/