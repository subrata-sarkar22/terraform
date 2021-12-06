terraform {
    backend "s3" {
        key = "terraform/tfstate.tfstate"
        bucket = "test-bucket-subrata-10252021"
        region = "us-west-1"
        access_key = ""
        secret_key = ""
    }
}