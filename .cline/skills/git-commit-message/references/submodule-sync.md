---
title: Submodule Sync Commit Format
description: Mandatory message format for commits that advance a submodule
    pointer inside a parent repository, including the huge-range bookend
    variant used when the advance spans more than 500 commits.
parent_skill: git-commit-message
---

# Submodule Sync Commits (Parent Repository)

Applies when a commit in the parent repository changes a **submodule pointer**.
In addition to the general rules in `SKILL.md` (§1–§3, §6, §7), this commit type
MUST follow every requirement below.

## 5. Submodule Sync Commits

- **Title**: `chore(submodules): sync <submodule-name> with <descriptive-action>`
  - First line format: `chore(submodules): sync <submodule-name> with <action>`
  - Include a descriptive action that summarizes the changes
- **Short Summary**: `Updates <submodule-name> from <old-sha-short> to <new-sha-short> (<head-commit-title>)`
- **Full Metadata Body (MANDATORY)**: The body MUST contain the complete,
  structured industrial record of the submodule advance.
- **Changes Section Header**: `Changes (<submodule-name>) [<old-sha>..<new-sha>]:`
  - **Mandatory**: Use the full 40-character SHAs for both the previous pointer
    and the new pointer.
  - **Format**: Bullet points (`-`) listing commits in chronological order (older to newer)
- **Chronological Order**: The commit list MUST be ordered from **older to newer**.
- **Metadata Section Header**: `Metadata (<submodule-name>):`
- **Mandatory Fields**:
  - `Submodule: <name> -> <new-sha>`
  - `Submodule commit parent: <sha>`
    (merge: <parent1> <parent2> ← only if merge commit)
  - `Submodule commit msg: <title-line>`
  - `<body-paragraphs-if-multiline>`
  - `Submodule commit changes`: List paths and line counts (for the tip commit).
  - `Submodule commit author`: <name> <email>
  - `Submodule commit author time`: <timestamp>
  - `Submodule commit committer`: <name> <email>
  - `Submodule commit committer time`: <timestamp>
- **Registration URL**: Every sync commit MUST include the registration URL from
  `.gitmodules` at the end of the metadata block:
  `Register <submodule-name> submodule pointing to <registration-url>`
- **Content Summary**:
  - Body must list key changes introduced by the submodule update, based on
    the submodule's commit messages.
  - Do not include only the commit SHA; always summarize the actual changes.
  - Do not repeat information from the title in the body.
- **No Paraphrasing**: The submodule's original commit message body must be
  preserved without summarization or omission.
- **Format Consistency**: Use bullet points for all details, wrap lines at 72
  characters, follow all other formatting rules, and maintain standard
  imperative mood for the title.

### 5.1 Huge-Range Bookend Variant (>500 commits)

When the submodule advance spans **more than 500 commits**, a flat
chronological listing becomes impractical (Git practical limits, reviewer
fatigue, log noise). In that case the agent MUST switch to the **bookend
variant**:

- **Changes Section Header**: still `Changes (<submodule-name>) [<old-sha>..<new-sha>] (N commits, bookend listing):` where `N` is the exact `git rev-list --count <old>..<new>` figure.
- **First-K bullets**: list the **oldest 10 commits** in chronological order.
- **Ellipsis line**: a single bullet `- ... (<N - 20> intermediate commits omitted; full list: \`git -C <submodule> log --oneline <old>..<new>\`)`.
- **Last-K bullets**: list the **newest 10 commits** in chronological order, ending with the tip commit.
- **Tip metadata block**: identical to the standard variant (parent, message, changes, author, committer, registration URL) — NEVER omitted.
- **Threshold**: 500 commits. Below the threshold, use the standard flat list. The threshold MUST be stated explicitly in the body via the `(N commits, bookend listing)` annotation so reviewers know why the list is abridged.

---

## Quick checklist

- [ ] Title: `chore(submodules): sync <name> with <action>`
- [ ] `git rev-list --count <old>..<new>` was run to decide on bookend mode
- [ ] Full 40-char SHA for both the old and the new pointer in the header
- [ ] Commit list ordered **older to newer**
- [ ] Metadata block includes parent, msg, changes, author, committer
- [ ] Registration URL taken from `.gitmodules` at the end of metadata
- [ ] Submodule's original message body **preserved verbatim**, never paraphrased
