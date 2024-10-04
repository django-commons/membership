# Organization admins
admins = [
  "cunla",
  "ryancheley",
  "Stormheg",
  "tim-schilling",
  "williln",
]
# Organization members
members = [
  "bckohan",
  "browniebroke",
  "codein",
  "ddabble",
  "FlipperPA",
  "g-nie",
  "gav-fyi",
  "jacklinke",
  "jcjudkins",
  "joshuadavidthomas",
  "maerteijn",
  "matthiask",
  "Mogost",
  "nanorepublica",
  "Natim",
  "pfouque",
  "priyapahwa",
  "rptmat57",
  "salty-ivy",
  "testSchilling",
]

organization_teams = {
  "Admins" = {
    description = "django-commons administrators"
    # Use maintainers for organizational teams
    maintainers = [
      "cunla",
      "ryancheley",
      "Stormheg",
      "tim-schilling",
      "williln",
    ]
  }
  "security-team" = {
    description = "django-commons security team"
    # Use maintainers for organizational teams
    maintainers = [
      "matthiask",
      "tim-schilling",
    ]
    permission = "push"
  }
}

################ GitHub Organization Secrets, not used at the moment #############

organization_secrets = {
  #     "GPG_PASSPHRASE" = {
  #       description = "GPG Passphrase used to encrypt plan.out files"
  #       visibility  = "all"
  #     }
}
