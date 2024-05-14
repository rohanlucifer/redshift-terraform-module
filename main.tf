provider "aws" {
  region  = "eu-central-1"
}

data "aws_vpc" "vpc" {
    filter {
      name   = "tag:Name"
      values = ["ec-nonprod-vpc1"]
    }
  }

data "aws_subnet" "private1" {

   filter {
    name   = "tag:Name"
    values = ["ec-nonprod-vpc1-private-eu-central-1a"]
  }
  vpc_id = data.aws_vpc.vpc.id
}

data "aws_subnet" "private2" {

   filter {
    name   = "tag:Name"
    values = ["ec-nonprod-vpc1-private-eu-central-1c"]
  }
  vpc_id = data.aws_vpc.vpc.id
}

resource "aws_security_group" "redshift-sg" {
  name        = "redshift-sg"
  description = "Allow Redshift to connection form eks and rds"
  vpc_id      = data.aws_vpc.vpc.id
  #vpc_id = "vpc-0b48139531455ec15"
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["10.20.0.0/16"]
    #cidr_blocks = var.port_cidr_blocks
  }
   ingress {
    from_port   = 5439
    to_port     = 5439
    protocol    = "TCP"
    cidr_blocks = ["10.20.0.0/16"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]

  }
  tags = {
    Name = "redshift-sg"
  }
}


module "redshift" {
  source  = "terraform-aws-modules/redshift/aws"
  version = "~> 6.0.0"

  cluster_identifier      = "redshift"
  node_type = "dc2.large"
  number_of_nodes = "2"
  allow_version_upgrade  = true
  #automated_snapshot_retention_period = var.automated_snapshot_retention_period
  
  #redshift_subnet_group_name = "redshift-subnet-group"
  subnet_ids = [data.aws_subnet.private1.id, data.aws_subnet.private2.id]
#subnet_ids = ["subnet-02e7ba12d1a3bf279","subnet-08b43e42e63001e07"]
  #snapshot_identifier = var.snapshot_identifier
  vpc_security_group_ids = [aws_security_group.redshift-sg.id]
 # owner_account = "018028332614"
  #owner_account = var.owner_account
  
  # Group parameters
  #wlm_json_configuration = "[{\"query_concurrency\": 5}]"


  # IAM Roles
  #cluster_iam_roles = ["arn:aws:iam::225367859851:role/developer"]

  master_username = "admin"
  database_name = "redshift"
  master_password = "Test1234"
  create_random_password = false
}
 

/*
 module "redshift_cluster" {
  source = "cloudposse/redshift-cluster/aws"
  # Cloud Posse recommends pinning every module to a specific version
  # version = "x.x.x"
   subnet_ids = ["subnet-02e7ba12d1a3bf279","subnet-08b43e42e63001e07"]
  #subnet_ids          = [data.aws_subnet.private1.id, data.aws_subnet.private1.id]
  vpc_security_group_ids = [aws_security_group.redshift-sg.id]
  cluster_identifier = "red"
  admin_user            = "admin"
  admin_password        = "test1234"
  database_name         = "red"
  node_type             = "dc2.large"
  number_of_nodes =            2
  cluster_type          = "multi-node"
  engine_version        = "1.0.67308"
  publicly_accessible   = false
  allow_version_upgrade = false
  #aws_redshift_subnet_group = "redshift-subnet-group" 
  #aws_redshift_parameter_group = "redshift-parameter-group"
}
*/