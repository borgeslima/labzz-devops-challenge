#####################################################################
# EKS Module Design By Gabriel Lima on Organization Quarks Labs <3
# Link: https://github.com/quarks-labs/aws-s3-bucket-module
#####################################################################

module "s3" {
  source   = "git::git@github.com:quarks-labs/aws-s3-bucket-module.git"
  for_each = try({ for idx, bucket in var.buckets : idx => bucket }, {})
  bucket   = each.value.bucket
  tags = merge(var.tags, {
    ref : "https://github.com/quarks-labs/aws-s3-bucket-module"
  })
}
