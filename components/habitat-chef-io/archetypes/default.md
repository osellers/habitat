+++
title = "{{ replace .Name "-" " " | title }}"
draft = true
date = ["date", "publishDate", "lastmod"]
lastmod = [":git", "lastmod", "date", "publishDate"]
publishDate = ["publishDate", "date"]

[menu]
  [menu.habitat]
    title = "{{ replace .Name "-" " " | title }}"
    identifier = "habitat/{{ .Name }}.md {{ replace .Name "-" " " | title }}"
    parent = "habitat/overview"
    weight = 10

+++

[\[edit on GitHub\]](https://github.com/habitat/habitat.sh/blob/master/components/habitat-chef-io/content/docs/{{ .Name }}.md)
