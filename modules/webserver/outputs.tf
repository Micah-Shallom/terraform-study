output "ami_id" {
    value = aws_instance.myapp-server.ami
}
output "instance_ip" {
    value = aws_instance.myapp-server.public_ip
}