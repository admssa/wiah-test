provider "aws" {
  alias  = "global"
  region = "eu-west-1"
}

provider "aws" {
  region = var.region
  default_tags {
    tags = {
      Env = var.env
    }

  }
}

