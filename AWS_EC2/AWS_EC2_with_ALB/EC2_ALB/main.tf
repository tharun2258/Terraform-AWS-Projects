resource "aws_vpc" "myvpc" {
    cidr_block = var.vpc_cidr_block
  
}

resource "aws_subnet" "subnet1" {
    cidr_block = var.subnet1_cidr_block
    vpc_id = aws_vpc.myvpc.id
    availability_zone = var.az_subnet1
    map_public_ip_on_launch = true
  
}

resource "aws_subnet" "subnet2" {
    cidr_block = var.subnet2_cidr_block
    vpc_id = aws_vpc.myvpc.id
    availability_zone = var.az_subnet2
    map_public_ip_on_launch = true
  
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.myvpc.id
  
}

resource "aws_route_table" "rtable" {
    vpc_id = aws_vpc.myvpc.id

    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
  
}

resource "aws_route_table_association" "rtableattach1" {
    subnet_id = aws_subnet.subnet1.id
    route_table_id = aws_route_table.rtable.id
}

resource "aws_route_table_association" "rtableattach2" {
    subnet_id = aws_subnet.subnet2.id
    route_table_id = aws_route_table.rtable.id
}


resource "aws_security_group" "sg" {

    name = "web"
    vpc_id = aws_vpc.myvpc.id

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]

    }

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        
    }


    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
  
}


resource "aws_instance" "webserver1" {

    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.subnet1.id

    user_data = base64encode(file("userdata.sh"))
  
}

resource "aws_instance" "webserver2" {

    ami = var.ami_id
    instance_type = var.instance_type
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.subnet2.id

    user_data = base64encode(file("userdata1.sh"))
  
}


resource "aws_lb" "mylb" {
    name = "myalb"
    internal = false
    load_balancer_type = "application"

    security_groups = [aws_security_group.sg.id]
    subnets = [ aws_subnet.subnet1.id,aws_subnet.subnet2.id ]
    
  
}

resource "aws_lb_target_group" "tg" {
    name = "tg"
    protocol = "HTTP"
    port = 80
    vpc_id = aws_vpc.myvpc.id

    health_check {
      path = "/"
      port = "traffic-port"
    }
  
}


resource "aws_lb_target_group_attachment" "tgA1" {

    target_group_arn = aws_lb_target_group.tg.arn
    target_id = aws_instance.webserver1.id

    depends_on = [ aws_instance.webserver1 ]
  
}

resource "aws_lb_target_group_attachment" "tgA2" {

    target_group_arn = aws_lb_target_group.tg.arn
    target_id = aws_instance.webserver2.id

    depends_on = [ aws_instance.webserver2 ]
  
}

resource "aws_lb_listener" "lb_listener" {
    load_balancer_arn = aws_lb.mylb.arn
    port = 80
    protocol = "HTTP"


    default_action {
      target_group_arn = aws_lb_target_group.tg.arn
      type = "forward"

    }
  
}







