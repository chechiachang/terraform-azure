terraform {
  source = "../../../modules//foundation"
}

include {
  path = find_in_parent_folders()  
}

inputs = {
  # terraform backend
  storage_container_name = "base"
  storage_account_name = "baseec31eee5" # env + (random hex)
}
