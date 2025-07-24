//(search for all resource on the terraform website)

//create vpc resource
resource "aws_vpc" "webblog-cdn-server" {
  cidr_block = "10.10.0.0/16"
}

// create Internet Gateway
resource "aws_internet_gateway" "webblog_igw" {
  vpc_id = aws_vpc.webblog-cdn-server.id
  tags = {
    Name = "webblog-igw"
  }
}

//create the two public subnets 

resource "aws_subnet" "webblog-pub1-subnet" {
  vpc_id     = aws_vpc.webblog-pub1-subnet.id
  cidr_block = "10.10.1.0/24"
  availability_zone     = "eu-west-1a"
  map_public_ip_on_launch = true

  tags = {
    Name = "Webblog-public1-subnet"
  }
}


resource "aws_subnet" "webblog-pub2-subnet" {
  vpc_id     = aws_vpc.webblog-pub2-subnet.id
  cidr_block = "10.10.2.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = true

  tags = {
    Name = "Webblog-public2-subnet"
  }
}


//create the two private subnet

resource "aws_subnet" "webblog-prv1-subnet" {
  vpc_id     = aws_vpc.webblog-prv1-subnet.id
  cidr_block = "10.10.3.0/24"
  availability_zone       = "eu-west-1a"
  map_public_ip_on_launch = false

  tags = {
    Name = "Webblog-private1-subnet"
  }
}


resource "aws_subnet" "webblog-prv2-subnet" {
  vpc_id     = aws_vpc.webblog-prv2-subnet.id
  cidr_block = "10.10.4.0/24"
  availability_zone       = "eu-west-1b"
  map_public_ip_on_launch = false

  tags = {
    Name = "Webblog-private2-subnet"
  }
}


//Create the four routine tables
resource "aws_route_table" "pub_rt_1" {
  vpc_id = aws_vpc.webblog-cdn-server.id
  tags = {
    Name = "public-rt-1"
  }
}

resource "aws_route_table" "pub_rt_2" {
  vpc_id = aws_vpc.webblog_cdn_server.id
  tags = {
    Name = "public-rt-2"
  }
}

resource "aws_route_table" "prv_rt_1" {
  vpc_id = aws_vpc.webblog_cdn_server.id
  tags = {
    Name = "private-rt-1"
  }
}

resource "aws_route_table" "prv_rt_2" {
  vpc_id = aws_vpc.webblog_cdn_server.id
  tags = {
    Name = "private-rt-2"
  }
}


// Create Routes to Internet Gate way (igw)
resource "aws_route" "pub_route_1" {
  route_table_id         = aws_route_table.pub_rt_1.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.webblog_igw.id
}

resource "aws_route" "pub_route_2" {
  route_table_id         = aws_route_table.pub_rt_2.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.webblog_igw.id
}

// Create Subnet Associations
resource "aws_route_table_association" "pub_1_assoc" {
  subnet_id      = aws_subnet.webblog_pub1_subnet.id
  route_table_id = aws_route_table.pub_rt_1.id
}

resource "aws_route_table_association" "pub_2_assoc" {
  subnet_id      = aws_subnet.webblog_pub2_subnet.id
  route_table_id = aws_route_table.pub_rt_2.id
}

resource "aws_route_table_association" "prv_1_assoc" {
  subnet_id      = aws_subnet.webblod_prv1_subnet.id
  route_table_id = aws_route_table.prv_rt_1.id
}

resource "aws_route_table_association" "prv_2_assoc" {
  subnet_id      = aws_subnet.webblod_prv2_subnet.id
  route_table_id = aws_route_table.prv_rt_2.id
}