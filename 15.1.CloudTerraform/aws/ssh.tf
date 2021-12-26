resource "aws_iam_user" "user" {
  name = "test-user"
  path = "/"
}

resource "aws_iam_user_ssh_key" "user" {
  username   = aws_iam_user.user.name
  encoding   = "SSH"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQC8D7SuxVVulV7mx9RtXt+rQu5NEu79Hx7AuHbF9908Ztym9vyO1RwQIWCrnFzt7D7Yow2wq3Zmig9M/hUg67JF/SqSriFGJim/KrEPAhGXCsqLhSHkL8gpWiJ/INjnRyHZrxvlFUHkHh9FDbQzeyMzfBZbX3DIhFelmn7b1zabSQWdVdG/CstBXHxO3EWMEVBW7rXWVkvizRcrKN7Slohg6JEXT2j+dPqyl21k0pr0dM7OFJdoZyTUoTVDTOIvwU9YJotKfCkMl7KyImCea8DkPW5lYfZl1Dsa6ygpuCd69uImG827G3gO1xhw4WM/H9iLFKxQSFPLv4K+Y1VK4Teo1tX99/VcKnPPllarSCAFA1lI37GoRmBrLOj6lTlMCWfg+sHGT0mM0H+S7Sjv+k9UeWLpWP3HPTe3IAhn7Q5x98p2wDAF19Z+BODHZpFArFvCo30Tv3XmjiX/2EQgSO6ZNnGtKPKAkUk441z32yBL4n1o/PZRC7dTpc8YV63mXrM= alekseipedan@192.168.1.14"
}