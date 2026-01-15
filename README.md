# sentistock-infra
Sentistock 인프라

```
📦infra
 ┣ 📂envs
 ┃ ┣ 📂dev
 ┃ ┃ ┣ 📜backend.tf
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┣ 📂prod
 ┃ ┃ ┣ 📜.terraform.lock.hcl
 ┃ ┃ ┣ 📜backend.tf
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┣ 📜plan.txt
 ┃ ┃ ┣ 📜provider.tf
 ┃ ┃ ┣ 📜terraform.tfstate
 ┃ ┃ ┣ 📜terraform.tfstate.backup
 ┃ ┃ ┣ 📜terraform.tfvars
 ┃ ┃ ┣ 📜tfplan
 ┃ ┃ ┗ 📜variables.tf
 ┣ 📂globals
 ┃ ┣ 📜backend.tf
 ┃ ┣ 📜locals.tf
 ┃ ┗ 📜provider.tf
 ┣ 📂modules
 ┃ ┣ 📂eks
 ┃ ┃ ┣ 📜alb_controller_policy.json
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┣ 📂frontend_static
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┣ 📂rds
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┣ 📂route53
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┃ ┗ 📂vpc
 ┃ ┃ ┣ 📜main.tf
 ┃ ┃ ┣ 📜outputs.tf
 ┃ ┃ ┗ 📜variables.tf
 ┣ 📂scripts
 ┃ ┣ 📜apply-dev.sh
 ┃ ┣ 📜init-dev.sh
 ┃ ┗ 📜plan-dev.sh
 ┣ 📜.gitignore
 ┣ 📜README.md
 ┗ 📜versions.tf
```
