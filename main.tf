provider "aws" {
  region = "ap-south-1"
  access_key = "AKIA32NYOY3VSSQ4WAZQ"
  secret_key = "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"
}

resource "aws_key_pair" "key-tf" {
  key_name   = "key-tf"
  public_key = file("${path.module}/id_rsa.pub")

}
resource "aws_instance" "test" {
  ami           = "ami-0d81306eddc614a45"
  instance_type = "t2.micro"
  key_name  = "${aws_key_pair.key-tf.key_name}"


  tags = {
    Name = "pramod-tf"
  }
}
