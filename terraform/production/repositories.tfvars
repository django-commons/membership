# Organization repositories
repositories = {

  ".github" = {
    description              = "A Special Repository."
    enable_branch_protection = false

    topics = []
    push_allowances = []
    is_django_commons_repo = true
  }

  "controls" = {
    description              = "The controls for managing Django Commons projects"
    enable_branch_protection = false
    allow_merge_commit       = true
    allow_rebase_merge       = true
    allow_squash_merge       = true
    topics = []
    push_allowances = []
    is_django_commons_repo   = true
  }

  "membership" = {
    description            = "Membership repository for the django-commons organization."
    visibility             = "public"
    allow_merge_commit     = true
    allow_rebase_merge     = true
    allow_squash_merge     = true
    topics = []
    push_allowances = []
    is_django_commons_repo = true
  }

  "django-commons-playground" = {
    description = "A sample project to test things out"
    topics = []
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
    description        = "Schedule async tasks using redis pub/sub."
    homepage_url       = "https://django-tasks-scheduler.readthedocs.io/"
    allow_merge_commit = true

    admins = [
      "cunla",
    ]
    committers = []
    members = []
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
    members = []
  }
  "django-typer" = {
    description        = "Use Typer (type hints) to define the interface for your Django management commands."
    homepage_url       = "django-typer.rtfd.io"
    allow_auto_merge   = false
    allow_merge_commit = false
    allow_rebase_merge = false
    allow_squash_merge = true
    push_allowances = []

    admins = [
      "bckohan",
      "oliverandrich",
    ]
    committers = []
    members = []
  }

}
