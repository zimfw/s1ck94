s1ck94
======

A fork of the (first deprecated, now extinct) minimal prompt by S1cK94.

What does it show?
------------------

Let's breakdown the left prompt (from left to right):

  * User privilege:
    * On color if root.
    * Off color if not.
  * Background jobs:
    * On color if 1 or more jobs in background.
    * Off color if 0 jobs.
  * Keymap indicator:
    * On color if in main or vi insert mode.
    * Off color if in vi command mode.
  * Exit status:
    * On color if last command returned 0.
    * Error color if not.

On the right prompt:

  * The short pwd.
  * Git branch name, or commit short hash when in
    ['detached HEAD' state](http://gitfaq.org/articles/what-is-a-detached-head.html),
    only when you are in a git repo. Their color show different statues:
    * Error color if dirty or diverged from remote.
    * Yellow if behind.
    * Off color if ahead.
    * On color if none of the above.

Settings
--------

This theme can be customized with the following environment variables. If the
variable is not defined, the respective default value is used.

| Variable    | Description      | Default value |
| ----------- | ---------------- | ------------- |
| PROMPT_CHAR | Prompt character | ❯             |
| ON_COLOR    | On color         | green         |
| OFF_COLOR   | Off color        | default       |
| ERR_COLOR   | Error color      | red           |

Requirements
------------

Requires Zim's [`git-info`](https://github.com/zimfw/git-info) module to show
git information.
