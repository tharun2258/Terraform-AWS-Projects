resource "aws_key_pair" "ec2_key_pair" {
    key_name = "ec2_key"
    public_key = file(var.key_name)

  
}

resource "aws_vpc" "vpc" {
    cidr_block = var.vpc_cidr_block
  
}

resource "aws_subnet" "subnet" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.subnet_cidr_block
    availability_zone = var.availability_zone
    map_public_ip_on_launch = true


}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.vpc.id

}

resource "aws_route_table" "rtable" {
    vpc_id = aws_vpc.vpc.id

    route  {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

}

resource "aws_route_table_association" "rtable_association" {
    subnet_id = aws_subnet.subnet.id
    route_table_id = aws_route_table.rtable.id
  
}


resource "aws_security_group" "sg" {

    name = "web"
    vpc_id = aws_vpc.vpc.id

    ingress  {
        from_port = 5000
        to_port = 5000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "to allow 5000 port to access python application"

    }

    ingress  {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
        description = "to allow to login and to access ec2 instance"
    }


    egress  {

        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]

    }
}


resource "aws_instance" "ec2_instance" {
    ami = var.ami
    instance_type = var.instance_type 
    vpc_security_group_ids = [aws_security_group.sg.id]
    subnet_id = aws_subnet.subnet.id
    key_name = aws_key_pair.ec2_key_pair.key_name
    

    connection {
      user = "ec2-user"
      type = "ssh"
      private_key = file("path/.ssh/id_rsa")
      host = self.public_ip
    }
   
    
    provisioner "file"{
        source = "app.py"
        destination = "/home/ec2-user/app.py"
    }

    provisioner "remote-exec"{
        inline = [ 
            "echo hello from the remote ec2 istance",
            "python3 --version",
            "sudo yum install python3-pip -y",
            "pip3 --version",
            "pwd",
            "cd /home/ec2-user",
            "pwd",
            "pip3 install flask",
            "python3 app.py",
         ]
    }
}