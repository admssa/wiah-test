### HOW-TO:
1. Install all necessary tools

   - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
   - [Terraform](https://www.terraform.io/downloads)

2. [Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) aws cli

3. Create workspaces
```shell
terraform workspace new dev
terraform workspace new prod
```

4. Select dev workspace
```shell
terraform workspace select dev
```

5. Init terraform and apply code for selected workspace 

```shell
terraform init
terraform apply -var-file=values/dev.tfvars
```

6. Switch workspace to prod and apply prod code

```shell
terraform workspace select prpd
terraform apply -var-file=values/prod.tfvars
```

7. Clean it up 
```shell
terraform workspace select dev
terraform destroy -var-file=values/dev.tfvars
terraform workspace select prod
terraform destroy -var-file=values/prod.tfvars
```

### Desision making.

This is an example of using terraform workspaces for different environments. 
Terraform doesn't recommend using this for big environments, 
as it may cause security issues with access to terraform remote states 
without having a strong separation. But this can be used when DRY approach 
has higher priority. 