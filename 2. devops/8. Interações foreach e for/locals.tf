
locals {
  
  // Coleção de arquivos
  files = ["ips.json", "report.csv", "sitemap.xml"]

  // Interação for para imprimir a extensão de cada arquivo na coleção.
  file_extensions = [for file in local.files : regex("\\.[0-9a-z]+$", file)]
}