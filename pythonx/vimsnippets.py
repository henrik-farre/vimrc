"""Helper methods used in UltiSnips snippets."""

import os, re

def complete(tab, opts):
    """
    get options that start with tab

    :param tab: query string
    :param opts: list that needs to be completed

    :return: a string that start with tab
    """
    msg = "({0})"
    if tab:
        opts = [m[len(tab):] for m in opts if m.startswith(tab)]
    if len(opts) == 1:
        return opts[0]

    if not len(opts):
        msg = "{0}"
    return msg.format("|".join(opts))

def namespace(path):
    """
    Searches backwards till the last uppercase letter
    """
    abspath = os.path.abspath(path)
    m = re.search(r'[A-Z].+(?=/)', abspath)
    if m:
        return m.group().replace('/', '\\')
