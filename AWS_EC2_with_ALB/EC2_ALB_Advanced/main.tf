resource "aws_vpc" "myvpc" {
  cidr_block = var.vpc_cidr_block

}

resource "aws_subnet" "subnet" {

  for_each          = var.subnet_cidr_block
  cidr_block        = each.value
  availability_zone = lookup(var.availability_zone, each.key, "")
  vpc_id            = aws_vpc.myvpc.id



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

resource "aws_route_table_association" "rtableattach" {

  for_each = aws_subnet.subnet

  subnet_id      = each.value.id
  route_table_id = aws_route_table.rtable.id
}



resource "aws_security_group" "sg" {

  name   = "web"
  vpc_id = aws_vpc.myvpc.id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }


  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_instance" "webserver" {

  for_each = aws_subnet.subnet

  ami                    = var.ami_id
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.sg.id]
  subnet_id              = each.value.id
  user_data              = each.key == "subnet1" ? base64encode(file("userdata.sh")) : base64encode(file("userdata1.sh"))

}




resource "aws_lb" "mylb" {
  name               = "myalb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.sg.id]
  subnets            = [for subnet in aws_subnet.subnet : subnet.id]


}

resource "aws_lb_target_group" "tg" {
  name     = "tg"
  protocol = "HTTP"
  port     = 80
  vpc_id   = aws_vpc.myvpc.id

  health_check {
    path = "/"
    port = "traffic-port"
  }

}


resource "aws_lb_target_group_attachment" "tgA" {

  target_group_arn = aws_lb_target_group.tg.arn
  for_each         = aws_instance.webserver
  target_id        = each.value.id

  depends_on = [aws_instance.webserver]

}



resource "aws_lb_listener" "lb_listener" {
  load_balancer_arn = aws_lb.mylb.arn
  port              = 80
  protocol          = "HTTP"


  default_action {
    target_group_arn = aws_lb_target_group.tg.arn
    type             = "forward"

  }

}







