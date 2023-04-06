resource "aws_eip" "webserver0" {
  instance = aws_instance.webserver[0].id
  vpc      = true
}

resource "aws_eip" "webserver1" {
  instance = aws_instance.webserver[1].id
  vpc      = true
}

