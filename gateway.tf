#Creating internet Gateway
resource "aws_internet_gateway" "shivani-gateway" {
    vpc_id = "${aws_vpc.shivani-vpc.id}"
    tags = {
        Name = "shivani-subnet"
        Owner = "shivani.sharma@cloudeq.com"
        Purpose = "training"
    }
}

#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# This is my Route
resource "aws_route_table" "shivani-route" {
    vpc_id = "${aws_vpc.shivani-vpc.id}"
    
    route {
        cidr_block = "0.0.0.0/0" 
        gateway_id = "${aws_internet_gateway.shivani-gateway.id}" 
    }
    
    tags = {
        Name = "shivani-route"
        Owner = "shivani.sharma@cloudeq.com"
        Purpose = "training"
    }
}


#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>

#for subnet-1
resource "aws_route_table_association" "shivani-crta-public-subnet-1"{
    subnet_id = "${aws_subnet.shivani-subnet-1.id}"
    route_table_id = "${aws_route_table.shivani-route.id}"
}

#for subnet-2
resource "aws_route_table_association" "shivani-crta-public-subnet-2"{
    subnet_id = "${aws_subnet.shivani-subnet-2.id}"
    route_table_id = "${aws_route_table.shivani-route.id}"
}



#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
# Creating aws Security Group
resource "aws_security_group" "shivani-security" {
    vpc_id = "${aws_vpc.shivani-vpc.id}"
    
    egress {
        from_port = 0
        to_port = 0
        protocol = -1
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
     
    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    tags =  {
        Name = "shivani-security"
        Owner = "shivani.sharma@cloudeq.com"
        Purpose = "training"
    }
}
