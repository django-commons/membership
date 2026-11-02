# Organization repositories
repositories = {
  ".github" = {
    description            = "The repository for managing Django Commons' organizational profile."
    has_discussions        = false
    has_issues             = false
    topics                 = []
    push_allowances        = []
    is_django_commons_repo = true
  }

  "controls" = {
    description            = "The repository for managing the Django Commons organization. This is the place for issues to improve the organization."
    homepage_url           = "https://www.django-commons.org"
    allow_merge_commit     = true
    allow_rebase_merge     = true
    allow_squash_merge     = true
    topics                 = []
    push_allowances        = []
    is_django_commons_repo = true
  }

  "membership" = {
    description            = "The repository that members and projects use to manage the projects of Django Commons. This also contains the Django Commons website."
    homepage_url           = "https://www.django-commons.org"
    visibility             = "public"
    allow_merge_commit     = false
    has_projects           = true
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
      "tim-schilling",
    ]
    # People with GitHub maintain repo permissions
    committers = [
      "priyapahwa",
    ]
    # People with GitHub triage repo permissions
    members = [
    ]
  }

  "dj-database-url" = {
    description                 = "Use Database URLs in your Django Application."
    homepage_url                = "https://pypi.org/project/dj-database-url/"
  
    allow_merge_commit          = true # Allow merge commits on pull requests
    allow_rebase_merge          = true # Allow rebase and merge commits on pull requests
    allow_squash_merge          = true # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch         = true # Allow updating source branch on pull requests
    has_discussions             = false # Enable discussions in project's repository
    has_wiki                    = false # Enable wiki in project's repository
    admins = [
      "mattseymour",
      "palfrey",
    ]
    committers = [
    ]
    members = [
      "codingjoe",
    ]
  }

  "django-auditlog" = {
    description = "A Django app that keeps a log of changes made to an object."

    allow_merge_commit  = true  # Allow merge commits on pull requests
    allow_rebase_merge  = true  # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true  # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true  # Allow updating source branch on pull requests
    has_discussions     = true  # Enable discussions in project's repository
    has_wiki            = false # Enable wiki in project's repository
    has_projects        = true
    admins = [
      "2ykwang",
      "hramezani",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "django-axes" = {
    description = "Keep track of failed login attempts in Django-powered sites."

    allow_merge_commit  = true  # Allow merge commits on pull requests
    allow_rebase_merge  = true  # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true  # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true  # Allow updating source branch on pull requests
    has_discussions     = false # Enable discussions in project's repository
    has_wiki            = false # Enable wiki in project's repository
    admins = [
      "aleksihakli",
      "camilonova",
    ]
    committers = [
    ]
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
    committers = [
      "DhavalGojiya",
      "cclauss",
    ]
    members = [
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

  "django-constance" = {
    description  = "Dynamic Django settings."
    homepage_url = "https://django-constance.readthedocs.io"

    allow_merge_commit  = true  # Allow merge commits on pull requests
    allow_rebase_merge  = true  # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true  # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true  # Allow updating source branch on pull requests
    has_discussions     = false # Enable discussions in project's repository
    has_wiki            = false # Enable wiki in project's repository
    admins = [
      "camilonova",
      "jezdez",
      "Mogost",
      "Natim",
    ]
    committers = [
    ]
    members = [
    ]
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
      "federicobond",
      "salty-ivy",
      "VeldaKiara",
    ]
    members = [
      "andoriyaprashant",
      "blingblin-g",
      "Chiemezuo",
      "codingjoe",
      "devatbosch",
      "dr-rompecabezas",
      "jmgutu",
      "JohananOppongAmoateng",
      "mgstabrani",
      "selinarajk",
      "Wasif-Shahzad",
      "Zakui",
    ]
  }

  "django-eav2" = {
    description  = "Add custom fields to any Django model at runtime: validated, filterable with the ORM, and no schema changes."
    homepage_url = "https://django-eav2.readthedocs.io/"
    topics       = ["custom-fields", "eav", "python", "eav-model", "entity-attribute", "django-eav2", "django", ]

    allow_merge_commit  = true  # Allow merge commits on pull requests
    allow_rebase_merge  = true  # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true  # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true  # Allow updating source branch on pull requests
    has_discussions     = false # Enable discussions in project's repository
    has_wiki            = false # Enable wiki in project's repository
    admins = [
      "Dresdn",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "django-formtools" = {
    description  = "A set of high-level abstractions for Django forms"
    homepage_url = "https://django-formtools.readthedocs.io"

    # Different merge strategies can be enabled/disabled
    allow_merge_commit  = true # Allow merge commits on pull requests
    allow_rebase_merge  = true # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true # Allow updating source branch on pull requests

    has_discussions = false # Enable discussions in project's repository
    has_wiki        = false # Enable wiki in project's repository
    has_projects    = false # Enable projects in project's repository
    admins = [
      # Include people who can release new versions
      "claudep",
    ]
    committers = [
      # Include people who can commit to main / merge changes
      "pfouque"
    ]
    members = [
      # Include people who can assign/triage tickets
      "pfouque"
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

    pages = {
      build_type = "workflow"
    }

    admins = [
      "Natim",
      "pfouque",
      "ticosax",
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
    allow_merge_commit = false
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
    allow_merge_commit  = false
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true
    has_discussions     = false
    has_wiki            = false
    admins = [
      "GaretJax",
      "FlipperPA",
    ]
    committers = [
      "ulgens",
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

  "django-hosts" = {
    description  = "Dynamic and static host resolving for Django. Maps hostnames to URLconfs."
    homepage_url = "http://django-hosts.rtfd.org/"

    # Different merge strategies can be enabled/disabled
    allow_merge_commit  = true # Allow merge commits on pull requests
    allow_rebase_merge  = true # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true # Allow updating source branch on pull requests

    has_discussions = true  # Enable discussions in project's repository
    has_wiki        = false # Enable wiki in project's repository
    has_projects    = true  # Enable projects in project's repository
    admins = [
      "2ykwang",
      "JaeHyuckSa",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "django-prometheus" = {
    description         = "Export Django monitoring metrics for Prometheus.io"
    allow_auto_merge    = true
    allow_merge_commit  = true
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true

    has_discussions = false
    has_projects    = true
    has_wiki        = false
    admins = [
      "asherf",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "django-robots" = {
    description  = "A Django app for managing robots.txt files following the robots exclusion protocol"
    homepage_url = "https://django-robots.readthedocs.io"

    allow_merge_commit  = true  # Allow merge commits on pull requests
    allow_rebase_merge  = true  # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true  # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true  # Allow updating source branch on pull requests
    has_discussions     = false # Enable discussions in project's repository
    has_wiki            = false # Enable wiki in project's repository
    admins = [
      "mattseymour",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "django-smart-selects" = {
    description                 = "chained and grouped selects for django forms"
    homepage_url                = "https://django-smart-selects.readthedocs.io/"

    allow_merge_commit          = true # Allow merge commits on pull requests
    allow_rebase_merge          = true # Allow rebase and merge commits on pull requests
    allow_squash_merge          = true # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch         = true # Allow updating source branch on pull requests
    has_discussions             = false # Enable discussions in project's repository
    has_wiki                    = false # Enable wiki in project's repository
    admins = [
      "manelclos",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "django-valkey" = {
    description            = "a Valkey backend for django"
    homepage_url           = "https://django-valkey.readthedocs.io/en/latest/"
    allow_auto_merge       = true
    allow_merge_commit     = true
    allow_rebase_merge     = true
    allow_squash_merge     = true
    allow_update_branch    = true
    delete_branch_on_merge = false

    has_discussions = true
    has_wiki        = false
    admins = [
      "amirreza-sf80",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "django-widget-tweaks" = {
    description = "Tweak the form field rendering in templates, not in python-level form definitions. CSS classes and HTML attributes can be altered."

    allow_merge_commit  = true  # Allow merge commits on pull requests
    allow_rebase_merge  = true  # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true  # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = true  # Allow updating source branch on pull requests
    has_discussions     = false # Enable discussions in project's repository
    has_wiki            = false # Enable wiki in project's repository
    admins = [
      "aleksihakli",
      "camilonova",
    ]
    committers = [
    ]
    members = [
    ]
  }

  "axe-selenium-python" = {
    description         = "Automated web accessibility testing with Axe and Selenium"
    allow_merge_commit  = false
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true

    has_discussions = true
    has_wiki        = false
    admins = [
      "knyghty",
      "thibaudcolas"
    ]
    committers = [
    ]
    members = [
    ]
  }
  "django-unicorn" = {
    description         = "The magical reactive component framework for Django ✨"
    homepage_url        = "https://www.django-unicorn.com"
    allow_merge_commit  = true
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true
    has_projects        = false
    topics = [
      "javascript",
      "python",
      "django",
      "fullstack",
      "frontend-framework",
    ]
    admins = [
      "adamghill",
    ]
    committers = [
      "JohananOppongAmoateng",
    ]
    members = []
  }
  "django-unicorn.com" = {
    description         = "Website for django-unicorn"
    homepage_url        = "https://www.django-unicorn.com"
    allow_merge_commit  = true
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true
    has_discussions     = false
    has_wiki            = false
    topics = [
      "javascript",
      "python",
      "django",
      "fullstack",
      "django-unicorn",
    ]
    admins = [
      "adamghill",
    ]
    committers = []
    members    = []
  }

  "django-polymorphic" = {
    description         = "Improved Django model inheritance with automatic downcasting"
    homepage_url        = "https://django-polymorphic.readthedocs.io"
    allow_merge_commit  = false
    allow_rebase_merge  = true
    allow_squash_merge  = true
    allow_update_branch = true
    has_discussions     = true
    has_wiki            = false
    pages = {
      build_type = "workflow"
    }
    admins = [
      "bckohan",
    ]
    committers = []
    members = [
      "JohananOppongAmoateng",
    ]
  }

  "drf-haystack" = {
    description = "Haystack for Django REST Framework"
    # Different merge strategies can be enabled/disabled
    allow_auto_merge    = true
    allow_merge_commit  = false # Allow merge commits on pull requests
    allow_rebase_merge  = true  # Allow rebase and merge commits on pull requests
    allow_squash_merge  = true  # Allow squash and merge commits on pull requests - Recommended
    allow_update_branch = false # Allow updating source branch on pull requests
    has_projects        = false
    has_discussions     = true  # Enable discussions in project's repository
    has_wiki            = false # Enable wiki in project's repository
    admins = [
      "ulgens",
    ]
    committers = [
      "DhavalGojiya",
    ]
    members = [
    ]
  }

  "django-simple-menu" = {
    description = "Simple, yet powerful, code-based menus for Django applications"
    topics      = ["django", "menu"]

    allow_merge_commit     = false
    allow_rebase_merge     = false
    allow_squash_merge     = true
    allow_update_branch    = false
    has_discussions        = false
    has_projects           = false
    has_wiki               = false
    delete_branch_on_merge = false

    admins = [
      "borgstrom",
      "kytta",
      "mbeijen",
    ]
    committers = []
    members = [
      "pdessauw",
    ]
  }

  "django-rest-knox" = {
    description  = "Authentication Module for django rest auth"
    homepage_url = "http://django-commons.org/django-rest-knox/"

    allow_merge_commit     = true
    allow_rebase_merge     = true
    allow_squash_merge     = true
    allow_update_branch    = true
    has_discussions        = false
    has_projects           = true
    has_wiki               = true
    delete_branch_on_merge = false

   # Docs are published from the gh-pages branch
    pages = {
      build_type = "legacy"
      source = {
        branch = "gh-pages"
        path   = "/"
      }
    }

    admins = [
      "giovannicimolin",
    ]
    committers = []
    members    = []
  }
}
