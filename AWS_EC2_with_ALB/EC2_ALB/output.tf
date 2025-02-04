output "instance_id_1" {
    value = aws_instance.webserver1.id
}

output "instance_id_2" {
    value = aws_instance.webserver2.id
}

output "lb_dns_name" {
    value = aws_lb.mylb.dns_name  
}