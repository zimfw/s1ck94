s1ck94
======

A customizable version of the (first deprecated, now extinct) minimal prompt
from S1cK94.

What does it show?
------------------

Let's breakdown the left prompt (from left to right):

  * User privilege:
    * "on" color if root.
    * reset if not.
  * Background jobs:
    * "on" color if 1 or more jobs in background.
    * reset if 0 jobs.
  * Keymap indicator:
    * "on" color if in main or vi insert mode.
    * reset if in vi command mode.
  * Exit status:
    * "on" color if last command returned 0.
    * "err" color if not.

On the right prompt:

  * The short pwd.
  * Git branch name, or commit short hash when in
    ['detached HEAD' state](http://gitfaq.org/articles/what-is-a-detached-head.html),
    only when you are in a git repo. Its color shows different statues:
    * "err" color if dirty or diverged from remote.
    * yellow if behind.
    * reset if ahead.
    * "on" color if none of the above.

Usage
-----

This prompt can be customized with:

    prompt s1ck94 [prompt_char] [on_color] [err_color]

The respective default values for each parameter are `❯`, `green`, and `red`.

If you enabled Zim's [`prompt`](https://github.com/zimfw/prompt) module, you can
set this as your default theme with the following zstyle:

    zstyle ':zim:prompt' theme 's1ck94'

Additional customization parameters can be passed too. For example:

    zstyle ':zim:prompt' theme 's1ck94' ']'

Requirements
------------

Requires Zim's [`git-info`](https://github.com/zimfw/git-info) module to show
git information.
