---
layout: post
title: "Thank you, Storm"
date: yyyy-mm-dd
categories: announcements
---

One of the things we say a lot at Django Commons is that sustainability has to
include the people, not just the packages. It's easy to say. It's harder to
mean it when someone who has carried real weight decides it's time to step
back. Storm Heg is stepping down from the admin team, and just like we did when
Lacey stepped away, we want to send him off the right way: with gratitude, and
without any suggestion that leaving is a failure.

Because it isn't. It's the plan working.

If Lacey was the conscience of the group, Storm was the one quietly making sure
the foundation underneath us wouldn't crack. A lot of what he did is the kind
of work you only notice when it *doesn't* happen: the domain that keeps
resolving, the package that only gets published by the workflow that's supposed
to publish it, the security notification that someone actually reads.

Storm took ownership of our DNS story end to end, standing up our
[deSEC.io](https://desec.io/) setup, sorting out the sponsorship, and moving our
domains over — including django-commons.org itself and django-unicorn. He didn't
stop at "it works for us," either; he spent time figuring out how to hand
project admins limited, safe control over their own DNS records, so the
infrastructure could scale past any one person. Past him, specifically.

On the packaging side, Storm was our steady hand on PyPI. He pushed us toward
Trusted Publishing, documented how to transfer projects (down to the npm
publishing workflows for the packages that need them), and thought hard about
how to rotate the PyPI team without dropping the ball on security. That
vigilance wasn't theoretical: when an API token was used to upload
django-debug-toolbar in a way that bypassed Trusted Publishing, Storm was the
one who caught it and flagged it. That's exactly the kind of "boring" attention
that keeps an ecosystem safe.

And when it came time to write down how Django Commons actually *works* — the
governance document, the values, the admin playbooks, the security team's remit
— Storm was in the middle of it, arguing for clarity and for processes that
would outlast the current crew. He wanted the next people to have it easier
than we did.

You'll also have seen him out in the community: at FOSDEM, on stage at
DjangoCon, and thoughtfully replying in discussions when a hard question needed
a careful answer instead of a fast one.

The through-line in all of it is that Storm built things to survive his own
departure. The DNS handoff, the publishing docs, the governance work, the PyPI
rotation — every one of those was really about making sure Django Commons
didn't depend on Storm being in the room. So when he tells us he's ready to step
back, the most fitting response is to prove him right: to keep the lights on
with the systems he left us.

So, thank you, Storm. For the DNS records and the deSEC account, for Trusted
Publishing and the alarm you raised when something looked off, for the
governance docs and the playbooks, and for building all of it to keep working
without you. Take the break. You earned it — and thanks to you, we've got this.

— The Django Commons admins
