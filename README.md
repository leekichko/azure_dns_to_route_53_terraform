# azure_dns_to_route_53_terraform
Migrating from Azure DNS to Route 53 -> Generates Terraform 

WIP: Hasn't been tested. But should be easy to change.  Might save someone a little time. Just threw this together.

Useful for people who may want to do either of these things.
- Migrate from AzureDNS to Route53
- Migrate from Azure to Route53 and want to maintain routes with Terraform

Yes, terraform has a JSON configuration syntax.  It's a little verbose.  I think the structure is right?  

Reference links

https://www.terraform.io/docs/configuration/syntax-json.html

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone

https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_record


Example Usage
./generate_terraform_file.rb ../template.json ../records.tf.json


