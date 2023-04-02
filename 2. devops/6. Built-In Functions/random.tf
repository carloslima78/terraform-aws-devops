/* Nomeará o resource Usando o argumento length para a quantidade de caracteres pra um 
   nome randômico para bucket */
resource "random_pet" "bucket" {

  length = 2

}