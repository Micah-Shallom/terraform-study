provider "aws" {}

variable "cidr_blocks" {
    description = "cidr blocks and name tags for vpc and subnet"
    # type = list(string)
    type = list(object({
        cidr_block = string,
        name = string
    }))
}

# variable "subnet_cidr" {
#     description = "cidr block for subnet 1"
# }
# variable "vpc_cidr" {
#     description = "vpc cidr block"
#     default = "10.0.0.0/16"
# }


variable "environment" {
    description = "environment names"
}

resource "aws_vpc" "dev-vpc" {
    cidr_block = var.cidr_blocks[0].cidr_block
    tags = {
        # Name: var.environment
        Name: var.cidr_blocks[0].name
    }
}


resource "aws_subnet" "dev-subnet-1"{
    vpc_id = aws_vpc.dev-vpc.id
    # cidr_block = var.subnet_cidr
    cidr_block = var.cidr_blocks[1].cidr_block
    availability_zone = "us-east-1a"
    tags = {
        # Name: "subnet-1-dev"
        Name: var.cidr_blocks[1].name
    }
}

data "aws_vpc" "existing_vpc" {
    default =  true
}

resource "aws_subnet" "dev-subnet-2" {
    vpc_id = data.aws_vpc.existing_vpc.id
    cidr_block = "172.31.48.0/20"
    availability_zone = "us-east-1a"
    tags = {
        Name: "subnet-2-dev"
    }
}

output "dev-vpc-id" {
    value = aws_vpc.dev-vpc.id
}
output "dev-subnet-id1" {
    value = aws_subnet.dev-subnet-1.id
}
output "dev-subnet-id2" {
    value = aws_subnet.dev-subnet-2.id
}