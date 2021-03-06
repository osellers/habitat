+++
title = "Application Lifecycle Hooks"
description = "Application Lifecycle Hooks"

[menu]
  [menu.habitat]
    title = "Application Lifecycle Hooks"
    identifier = "habitat/plans/lifecycle-hooks"
    parent = "habitat/plans"
    weight = 20

+++

Each plan can specify application lifecycle event handlers, or hooks, to perform certain actions during a service's runtime. Each hook is a script with a shebang defined at the top to specify the interpreter to be used.

> **Important:** You cannot block the thread in a hook unless it is in the run hook. Never call `hab` or `sleep` in a hook that is not the run hook.

To see a full list of available hooks and how to use them check out our [hooks documentation](/docs/reference#reference-hooks).
