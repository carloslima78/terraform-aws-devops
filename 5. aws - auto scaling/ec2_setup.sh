
#!/bin/bash

# Atualiza os pacotes do sistema operacional Ubuntu na instância EC2
sudo apt-get update

# Instala o Apache na instância EC2
sudo apt-get install -y apache2

# Cria um arquivo HTML na pasta padrão do Apache que exibe a mensagem "Hello from Terraform"

# FIX https://stackoverflow.com/questions/66298968/aws-show-permission-denied-when-try-to-change-the-page-content-of-index-html-of

echo 'Hello from Terraform' > /var/www/html/index.html

# Garante que o serviço Apache seja iniciado automaticamente na inicialização da instância EC2
sudo systemctl enable apache2

# Instala o stress-ng na instância EC2, que é utilizada para realizar testes de stress no sistema
sudo apt-get install -y stress-ng


# Comando que a ferramenta stress-ng realize um teste de estresse no sistema, com uso de 32 CPUs por 180 segundos e métricas resumidas
# sudo stress-ng --cpu 32 --timeout 180 --metrics-brief

