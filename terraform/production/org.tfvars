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
  "amirreza8002",
  "bckohan",
  "browniebroke",
  "cgl",
  "clintonb",
  "ddabble",
  "elineda",
  "FlipperPA",
  "g-nie",
  "gav-fyi",
  "ghost",
  "jacklinke",
  "jburns6789",
  "jcjudkins",
  "jezdez",
  "johnfraney",
  "joshuadavidthomas",
  "leogregianin",
  "matthiask",
  "mkalioby",
  "Mogost",
  "nanorepublica",
  "Natim",
  "oliverandrich",
  "ontowhee",
  "pauloxnet",
  "pfouque",
  "priyapahwa",
  "RealOrangeOne",
  "rptmat57",
  "salty-ivy",
  "sobolevn",
  "testSchilling",
  "ulgens",
  "unmonoqueteclea",
  "VeldaKiara",
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
