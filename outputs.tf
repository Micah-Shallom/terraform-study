output "aws_ami_id" {
    value = module.myapp-server.ami_id
}
output "ec2_public_ip" {
    value = module.myapp-server.instance_ip
}