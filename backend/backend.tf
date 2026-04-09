terraform {
    backend "s3" {
        bucket = "terraform-bucketb36"
        key = "terraform.tfstate"
        region = "ap-south-1"
        profile = "tf-user"
        dynamodb_table = "tf-backend-table"
    }
}
