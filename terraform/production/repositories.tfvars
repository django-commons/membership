# Organization repositories
repositories = {

  ".github" = {
    description = "A Special Repository."

    topics                 = []
    push_allowances        = []
    is_django_commons_repo = true
  }

  "controls" = {
    description            = "The controls for managing Django Commons projects"
    allow_merge_commit     = true
    allow_rebase_merge     = true
    allow_squash_merge     = true
    topics                 = []
    push_allowances        = []
    is_django_commons_repo = true
  }

  "membership" = {
    description            = "Membership repository for the django-commons organization."
    visibility             = "public"
    allow_merge_commit     = true
    allow_rebase_merge     = true
    allow_squash_merge     = true
    topics                 = []
    push_allowances        = []
    is_django_commons_repo = true
  }

  "best-practices" = {
    description = "A sample project with best practices for Django Commons projects."
    topics      = ["template", "django", "python"]
    # People with GitHub admin repo permissions
    admins = [
      "cunla",
      "ryancheley",
      "Stormheg",
      "tim-schilling",
      "williln",
    ]
    # People with GitHub maintain repo permissions
    committers = [
      "priyapahwa",
    ]
    # People with GitHub triage repo permissions
    members = [
    ]
  }

  "django-tasks-scheduler" = {
    description        = "Schedule async tasks using redis protocol. Redis/ValKey/Dragonfly or any broker using the redis protocol can be used."
    homepage_url       = "https://django-tasks-scheduler.readthedocs.io/"
    allow_merge_commit = true

    admins = [
      "cunla",
    ]
    committers = []
    members = [
      "devatbosch",
    ]
  }

  "django-cookie-consent" = {
    description         = "Reusable application for managing various cookies and visitors consent for their use in Django project."
    homepage_url        = "https://django-cookie-consent.readthedocs.org/en/latest/"
    allow_merge_commit  = true
    allow_rebase_merge  = false
    allow_squash_merge  = true
    allow_update_branch = true
    has_discussions     = false
    has_wiki            = false

    admins = [
      "sergei-maertens",
    ]
    committers = [
      "MrCordeiro",
    ]
    members = []
  }

  "django-debug-toolbar" = {
    description        = "A configurable set of panels that display various debug information about the current request/response."
    homepage_url       = "https://django-debug-toolbar.readthedocs.io"
    allow_auto_merge   = true
    allow_merge_commit = true
    allow_rebase_merge = true
    allow_squash_merge = true
    has_discussions    = true
    has_wiki           = true
    admins = [
      "matthiask",
      "tim-schilling",
    ]
    committers = [
      "elineda",
      "salty-ivy",
    ]
    members = [
      "andoriyaprashant",
      "blingblin-g",
      "devatbosch",
      "dr-rompecabezas",
      "VeldaKiara",
    ]
  }

  "django-fsm-2" = {
    description          = "Django friendly finite state machine support"
    homepage_url         = "https://github.com/django-commons/django-fsm-2"
    allow_merge_commit   = false
    allow_rebase_merge   = true
    has_projects         = false
    merge_commit_title   = "PR_TITLE"
    merge_commit_message = "BLANK"

    admins = [
      "Natim",
      "pfouque",
    ]
    committers = []
    members = [
      "giovannicimolin"
    ]
  }

  "django-simple-history" = {
    description         = "Store model history and view/revert changes from admin site."
    homepage_url        = "https://django-simple-history.readthedocs.org"
    allow_merge_commit  = true
    allow_rebase_merge  = false
    allow_squash_merge  = true
    allow_update_branch = true
    has_discussions     = true
    has_wiki            = true
    push_allowances     = []

    admins = [
      "ddabble",
      "tim-schilling",
    ]
    committers = []
    members    = []
  }

  "django-typer" = {
    description        = "Use Typer (type hints) to define the interface for your Django management commands."
    homepage_url       = "https://django-typer.rtfd.io"
    allow_auto_merge   = false
    allow_merge_commit = true
    allow_rebase_merge = true
    allow_squash_merge = true
    has_wiki           = true
    push_allowances    = []

    admins = [
      "bckohan",
      "oliverandrich",
    ]
    committers = []
    members    = []
  }
  "drf-excel" = {
    description         = "An XLSX spreadsheet renderer for Django REST Framework."
    allow_merge_commit  = true
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true
    has_discussions     = false
    admins = [
      "FlipperPA",
      "browniebroke",
    ]
    committers = [
      "rptmat57",
    ]
    members = [
      "justbackend",
    ]
  }
  "django-tailwind-cli" = {
    description            = "Django and Tailwind integration based on the prebuilt Tailwind CSS CLI."
    homepage_url           = "https://django-tailwind-cli.rtfd.io/"
    allow_auto_merge       = false
    allow_merge_commit     = false
    allow_rebase_merge     = false
    allow_squash_merge     = true
    allow_update_branch    = true
    delete_branch_on_merge = true
    has_discussions        = true
    has_downloads          = true
    has_wiki               = false
    is_template            = false
    push_allowances        = []
    topics = [
      "django",
      "django-application",
      "python",
      "tailwind",
      "tailwind-css",
      "tailwindcss",
    ]
    visibility                      = "public"
    required_status_checks_contexts = []
    admins = [
      "oliverandrich",
    ]
    committers = []
    members    = []
  }
  "django-click" = {
    description         = "Write Django management command using the click CLI library"
    allow_merge_commit  = true
    allow_rebase_merge  = true
    allow_squash_merge  = false
    allow_update_branch = true
    has_discussions     = false
    has_wiki            = false
    admins = [
      "GaretJax",
      "FlipperPA",
    ]
    committers = [
    ]
    members = [

    ]
  }
  "django-enum" = {
    description         = "Full and natural support for enumerations as Django model fields."
    homepage_url        = "https://django-enum.rtfd.io"
    allow_merge_commit  = true
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true
    has_discussions     = true
    has_wiki            = false
    admins = [
      "bckohan",
    ]
    committers = [
    ]
    members = [

    ]
  }
  "django-prometheus" = {
    description         = "Export Django monitoring metrics for Prometheus.io "
    allow_merge_commit  = true
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true

    has_discussions = true
    has_wiki        = false
    admins = [
      "asherf",
    ]
    committers = [
    ]
    members = [
    ]
  }
}

