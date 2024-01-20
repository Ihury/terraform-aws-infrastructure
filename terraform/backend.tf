terraform {
    backend "s3" {
        bucket = "humangov-terraform-state-xikcx"      
        key = "terraform.tfstate"          
        region = "us-east-1"
        encrypt = true        
        dynamodb_table = "humangov-terraform-state-lock-table"
    }
}