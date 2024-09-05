locals {
  name = lower("${var.name}-${random_string.sufix.result}")
}
