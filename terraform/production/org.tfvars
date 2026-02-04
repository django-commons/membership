# Organization admins
admins = [
  "cunla",
  "ryancheley",
  "Stormheg",
  "tim-schilling",
  "williln",
]

super_admins = [
  "cunla",
  "ryancheley",
  "Stormheg",
  "tim-schilling",
  "williln",
]

# Design members
designers = [
  "akshayvinchurkar",
  "federicobond",
  "jmgutu",
  "johnatanmoran",
  "mzemlickis",
  "okotdaniel",
  "p-r-a-v-i-n",
  "Shrikantgiri25",
  "vinlawz",
  "Violette-Allotey",
  "viscofuse",
  "Zakui",
]

# Organization members
members = [
  "2ykwang",
  "adamghill",
  "adRn-s",
  "akshayvinchurkar",
  "amirreza8002",
  "andoriyaprashant",
  "asherf",
  "ayimdomnic",
  "bahoo",
  "bckohan",
  "blingblin-g",
  "browniebroke",
  "carltongibson",
  "cgl",
  "Chiemezuo",
  "clintonb",
  "ddabble",
  "deronnax",
  "devatbosch",
  "DhavalGojiya",
  "dmpayton",
  "dr-rompecabezas",
  "elineda",
  "Faakhir30",
  "federicobond",
  "FlipperPA",
  "fsbraun",
  "g-nie",
  "GaretJax",
  "gav-fyi",
  "giovannicimolin",
  "input",
  "Insaida",
  "jacklinke",
  "jaehyuckSa",
  "JaeHyuckSa",
  "jburns6789",
  "jcjudkins",
  "jezdez",
  "jmgutu",
  "jnovinger",
  "JohananOppongAmoateng",
  "johnatanmoran",
  "johnfraney",
  "Josephchinedu",
  "joshuadavidthomas",
  "justbackend",
  "kevin-brown",
  "knyghty",
  "korfuri",
  "kytta",
  "leogregianin",
  "manelclos",
  "matthiask",
  "mihrab34",
  "mkalioby",
  "mnislam01",
  "Mogost",
  "MrCordeiro",
  "mzemlickis",
  "nanorepublica",
  "Natim",
  "niltonpimentel02",
  "okotdaniel",
  "oliverandrich",
  "ontowhee",
  "p-r-a-v-i-n",
  "pauloxnet",
  "peterthomassen",
  "pfouque",
  "priyapahwa",
  "RealOrangeOne",
  "rptmat57",
  "SaeedRz96",
  "salty-ivy",
  "sergei-maertens",
  "Shrikantgiri25",
  "SinkuKumar",
  "sobolevn",
  "spapas",
  "testSchilling",
  "thibaudcolas",
  "ticosax",
  "TildaDares",
  "TimothyMalahy",
  "ulgens",
  "unmonoqueteclea",
  "vacarme",
  "VeldaKiara",
  "vinlawz",
  "Violette-Allotey",
  "viscofuse",
  "Zakui",
]
organization_teams = {
  # This team should be enabled as moderators which can't be configured
  # via the GitHub Terraform integration.
  # https://github.com/organizations/django-commons/settings/moderators
  "Admins" = {
    description = "Django Commons administrators. This team is responsible for the overall management of the organization."
    # Use maintainers for organizational teams
    maintainers = [
      "cunla",
      "ryancheley",
      "Stormheg",
      "tim-schilling",
      "williln",
    ]
  }
  "super-admins" = {
    description = "Django Commons super administrators. This team is responsible for performing privileged operations."
    # Use maintainers for organizational teams
    maintainers = [
      "cunla",
      "ryancheley",
      "Stormheg",
      "tim-schilling",
      "williln",
    ]
  }
}
