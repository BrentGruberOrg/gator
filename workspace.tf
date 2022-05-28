terraform {
  cloud {
    organization = "BrentGruberOrg"

    workspaces {
      name = "gator"
    }
  }
}