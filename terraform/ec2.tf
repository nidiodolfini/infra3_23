resource "aws_instance" "webserver" {
  count                  = 2
  instance_type          = var.tipoinstancia
  ami                    = var.ami
  subnet_id              = var.subrede_pub
  vpc_security_group_ids = ["${aws_security_group.acesso_total_local.id}", "${aws_security_group.acesso_web.id}"]

  tags = {
    "Name" = "webserver-${var.username}-${count.index}"
  }
  key_name = aws_key_pair.terraform-chave.key_name

  user_data = <<-EOF
        #!/bin/bash
        sudo apt-get update
        sudo apt-get install \
            ca-certificates \
            curl \
            gnupg -y
        sudo mkdir -m 0755 -p /etc/apt/keyrings
        curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
        echo \
        "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
        "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
        sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
        sudo apt-get update
        sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
    EOF

}

# resource "aws_instance" "gerenciamento" {
#   instance_type = var.tipoinstancia
#   ami = var.ami
#   subnet_id = var.subrede_pub
#   vpc_security_group_ids = [ "${aws_security_group.ssh_publico.id}" ]
#   tags = {
#     "Name" = "gerenciamento-${var.username}-${count.index}"
#   }
#   key_name = aws_key_pair.terraform-chave.key_name
# }