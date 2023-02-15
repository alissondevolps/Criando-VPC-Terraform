# Criando-VPC-Terraform
- VPC
- Subnets
- Internet gateway
- Route table
- Associate the subnets to the route table
- Security group

#  O QUE FAZER ANTES DE CLONAR O PROJETO ?
- Have an aws account
- Install the terraform in a vm
- Install the AWS CLI
- create an admin user in IAM to use with terraform

# Comandos após instalar AWS CLI
- aws configure
- Access key ID = User ID
- Secret access key = user-generated password token
- region = us-east-1

# Link Comandos úteis terraform
- https://github.com/alissondevolps/Comando-Terraform

# Comandos após clonar projeto
- terraform init
- terraform plan
- terraform apply --auto-approve

# Caso deseje excluir tudo da AWS após fazerem testes, é só o usar o comando:
- terraform destroy