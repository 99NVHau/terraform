/*
This is the 'main' Terraform file. It calls all of our modules in order to
bring up the whole infrastructure
*/

module "VirtualMachine" {
  source = "./VM"
}

module "SQL_Server" {
  source = "./SQLServer"
}

module "sql_db" {
  source = "./SQLDB"
  depends_on = [module.SQL_Server]
}
module "AppServicePlan" {
  source = "./AppServicePlan"
}
module "AppService" {
    source = "./AppService"
    depends_on = [
      module.AppServicePlan
    ]  
}
# module "dev" {
#   source = "environments/dev"
# }

# module "staging" {
#   source = "environments/staging"
# }

# module "production" {
#   source = "environments/production"
# }
