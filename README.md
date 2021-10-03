# Get Started - Terraform

## Install
* [https://www.terraform.io/downloads.html](https://www.terraform.io/downloads.html)
```sh
mv ~/Downloads/terraform /usr/local/bin/

terraform -help
terraform -install-autocomplete
```

## Steps
```sh
touch main.tf variables.tf outputs.tf secret.tfvars

terraform init
terraform get
terraform workspace new dev

terraform validate
terraform plan [-destroy] -var-file="secret.tfvars" -out plan-v1.out
terraform apply plan-v1.out

terraform output
terraform show
terraform workspace select hml

terraform output -json | grep '\-\{5\}' | xargs echo -e | sed 's/^[, ]*//'
```

## References
* [https://www.terraform.io/docs/language](https://www.terraform.io/docs/language)
* [https://registry.terraform.io/browse/providers](https://registry.terraform.io/browse/providers)
* [https://registry.terraform.io/providers/hashicorp/tls/latest](https://registry.terraform.io/providers/hashicorp/tls/latest)
* [https://acloudguru.com/blog/engineering/the-ultimate-terraform-cheatsheet](https://acloudguru.com/blog/engineering/the-ultimate-terraform-cheatsheet)
