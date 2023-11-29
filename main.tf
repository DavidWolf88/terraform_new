resource "aws_instance" "example_ec" {
  ami           = "ami-0a3ca859119c1ee3c"
  instance_type = "t2.micro"

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, World" > index.html
              nohup busybox httpd -f -p 8080 &
              EOF

  user_data_replace_on_change = true
  vpc_security_group_ids = [aws_security_group.instance-ec.id]

  tags = {
    Name = "new-machine"
  }
}

resource "aws_security_group" "instance-ec" {
  name = "terraform-example-instance"

  ingress {
    from_port = 8080
    to_port = 8080
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}