############
#Create VPC###
############
resource "aws_vpc" "new-vpc" {
  cidr_block = "10.0.0.0/16"
  tags = {
      Name = "one-vpc"
  }
}

#############################
#List the subnet zones###
#############################
data "aws_availability_zones" "available" {}
# output az {
#   value       = "${data.aws_availability_zones.available.names}"

# }

###############################
# CREATING SUBNETS ONE BY ONE #
###############################
# resource "aws_subnet" "new-subnet-1" {
#     availability_zone = "us-east-1a"
#   vpc_id = aws_vpc.new-vpc.id
#   cidr_block = "10.0.0.0/24"
#   tags = {
#     Name = "one-subnet-1"
#   }

# }

# resource "aws_subnet" "new-subnet-2" {
#     availability_zone = "us-east-1b"
#   vpc_id = aws_vpc.new-vpc.id
#   cidr_block = "10.0.1.0/24"
#   tags = {
#     Name = "one-subnet-2"
#   }

# }

#############################
#Create 2 subnets ##########
#############################
resource "aws_subnet" "subnets" {
  count = 2
  availability_zone = data.aws_availability_zones.available.names[count.index]
  vpc_id = aws_vpc.new-vpc.id
  cidr_block = "10.0.${count.index}.0/24"
  map_public_ip_on_launch = true
  tags = {
      Name = "${var.prefix}-subnet-${count.index}"
  }
}


#############################
#Create Internet Gateway###
#############################
resource "aws_internet_gateway" "new-igw" {
  vpc_id = aws_vpc.new-vpc.id
  tags = {
      Name = "${var.prefix}-igw"
  }
}

#############################
#Create route table########
#############################
resource "aws_route_table" "new-rtb" {
  vpc_id = aws_vpc.new-vpc.id
  route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.new-igw.id
  }
  tags = {
      Name = "${var.prefix}-rtb"
  }
}

#############################################
#Associate the subnets to the route table ###
#############################################
resource "aws_route_table_association" "new-rtb-association" {
  count = 2
  route_table_id = aws_route_table.new-rtb.id
  subnet_id = aws_subnet.subnets.*.id[count.index]
}

#############################
#Cria um security group###
#############################
resource "aws_security_group" "sg" {
  vpc_id = aws_vpc.new-vpc.id
  egress {
      from_port = 0
      to_port = 0
      protocol = "-1"
      cidr_blocks = ["0.0.0.0/0"]
      prefix_list_ids = []
  }
  tags = {
      Name = "${var.prefix}-sg"
  }
}

