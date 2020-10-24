terraform {
  source = "../../../modules//foundation"
}

include {
  path = find_in_parent_folders()  
}
