#!/usr/bin/env python3

import sys
import os
import argparse
import re

from dataclasses import dataclass
from subprocess import check_output

RE_MERGE = re.compile("Merge branch '(.+)' into .+$")
RE_PR = re.compile("Merge pull request .+ from (.+)$")

@dataclass
class Merge:
    cid: str
    date: str
    branch: str

    @property
    def filename(self):
        branch = self.branch.replace("/", "-")
        return f"pr-texts/{self.date}-{branch}.md"


def extract_branch(msg):
    if (m := RE_MERGE.match(msg)):
        return m.group(1)
    elif (m := RE_PR.match(msg)):
        return m.group(1)
    else:
        raise ValueError(f"Could not parse msg: {msg}")


class Git:
    def __init__(self, git_dir):
        self.git_dir = git_dir

    def run(self, args):
        return check_output([
            "git",
            "-C", self.git_dir,
            *args,
        ], encoding="utf8")

    def log_to_pr_names(self, commits):
        output = self.run([
            "log",
            "--merges",
            "--date-order",
            "--format=format:%H|%ci|%s",
            commits
        ])

        res = []
        for line in output.splitlines():
            cid, datetime, msg = line.split("|", 2)
            date = datetime.split()[0]
            branch = extract_branch(msg)
            branch = branch.replace("chrivers/chrivers/", "chrivers/")
            res.append(Merge(cid, date, branch))
        return res

    def log_msg(self, commit):
        return self.run([
            "show",
            "--no-patch",
            "--format=format:%b",
            commit
        ]).strip()




def load_pr_texts(names):
    res = []
    for merge in names:
        try:
            with open(merge.filename) as f:
                data = f.read().strip()
                if data:
                    res.append(data)
        except:
            print(f"ERROR: could not open {merge.filename} for commit {merge.cid}", file=sys.stderr)
            raise
    return res


TEMPLATE = """### {merge.date}: `{merge.branch}`

{body}
"""


def fill_missing_texts(git, names):
    for merge in names:
        if not os.path.exists(merge.filename):
            text = TEMPLATE.format(merge=merge, body=git.log_msg(merge.cid))
            with open(merge.filename, "w") as f:
                f.write(text)
            print(f"Generated {merge.filename}", file=sys.stderr)


def changes(texts, limit=None):
    delim = "\n\n****************************************\n\n"
    if limit:
        return delim.join(texts[:limit])
    else:
        return delim.join(texts)


def main(args):
    from jinja2 import Environment, FileSystemLoader, select_autoescape
    env = Environment(
        loader=FileSystemLoader("templates/"),
        autoescape=select_autoescape(),
    )

    git = Git(args.git_dir)

    names = git.log_to_pr_names(args.commits)

    fill_missing_texts(git, names)

    try:
        pr_texts = load_pr_texts(names)
    except:
        return 1

    template = env.get_template(args.template.removeprefix("templates/"))

    context = {
        "changes": lambda *args: changes(pr_texts, *args),
        "has_changes": len(pr_texts) > 0,
    }

    print(template.render(**context), end="")

    return 0


if __name__ == "__main__":
    args = argparse.ArgumentParser()
    args.add_argument("git_dir", metavar="<git-dir>")
    args.add_argument("template", metavar="<template.jinja>")
    args.add_argument("commits", metavar="<git-commit-range>")
    sys.exit(main(args.parse_args()))
