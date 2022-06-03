### HOW-TO:
1. Install all necessary tools

   - [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
   - [Terraform](https://www.terraform.io/downloads)

2. [Configure](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html) aws cli

3. Define variables using template of tfvars.

```shell
cp auto.tfvars.template default.auto.tfvars
```

```
vpc_id     = "vpc-id"
subnet_ids = ["subnet-id"]
ssh_key    = "name-of-keypair"
```
4. Init terraform and apply the code
```shell
terraform init
terraform apply
```
5. Wait for the load balancer and all the instances up and running. 
After that wait up to 5 minutes for instances to be registred in the target group and test iot with curl:

```shell
curl $(terraform output lb_url)
```

6. Clean it up
```shell
terraform destroy
```

### Desision.
Terraform: Was used terraform as the most convenient and flexible tool for infrastructure code development.

Local state: No reason in creating buckets and remote states for such a small project. No parallel execution is expected, so locks aren't configured. Workspaces weren't used also. 

Modular: Initially, it was planned to use both modules in the top layer, but when user data changed, a double apply was required. Had to make the load-balancer module nested.