provider "aws" {
  region  = "ap-south-1"
  profile = "tf-user"
}
resource "aws_instance" "vm1" {
  ami           = "ami-048f4445314bcaa09"
  instance_type = "t3.micro"
  key_name      = "oncdec-b36"

  tags = {
    Name = "terraform-server"
  }

}
