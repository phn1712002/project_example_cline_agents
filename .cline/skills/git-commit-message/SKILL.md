---
name: git-commit-message
description: Write or amend Git commit messages following Conventional Commits. Trigger this skill when the user asks to create a commit, commit staged changes, write or fix a commit message, amend a commit, review a proposed commit message, sync a submodule pointer in a parent repository, or apply Conventional Commits rules. Covers commit message drafting, commit validation, and commit message formatting.
license: Project internal
---

# Git Commit Message Skill

This skill defines how to write **commit messages** that follow Conventional
Commits for this project. Everything below is **mandatory** whenever a commit is
created or amended.

Scope:
- Regular commits (source code, documentation, configuration, tests, ...).
- Amending an existing commit (§7).
- Commits that advance a submodule pointer in the parent repository → **also
  read** `references/submodule-sync.md` (long content, loaded only when needed).

---

## 1. Format Specification

- **Standard**: follow the **Conventional Commits** specification.
- **Format**: `type(scope): description`
- **Common Types**: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`.
- **Plain Text Only**: the final commit message must be plain text.
- **No Markdown**: do not use bold (`**`), italics (`*`), or code blocks (`` ` ``).
- **Allowed Symbols**: standard punctuation and symbols are allowed when they
  add clarity (`-`, `:`, `()`, `[]`).

---

## 2. Title Line (Header)

The first line is the most important part of the commit message.

- **Content**: a strong, concise summary of the *entire* change.
- **Context**: include critical contextual information (meeting dates, release
  dates, time-sensitive details) when the change is time-bound.
- **Length**:
  - **Ideal**: < 50 characters.
  - **Hard Limit**: 72 characters.
- **Case**: use the **Imperative Mood** ("add feature", not "added feature" or
  "adds feature").
- **Punctuation**: do not end the title line with a period.
- **Reference Style**: when referring to documentation, use the **Section
  Title** instead of the section number (for example "Refine Migration,
  Verification & Secrets protocol", not "Update Section 9").

---

## 3. Body (Description)

The body provides the detailed context.

- **Separation**: there must be **one blank line** between the title and the body.
- **Structure**: use **bullet points** (`-`) for all details; do not write long
  paragraphs.
- **Wrapping**: wrap every line at **72 characters**.
- **Content**:
  - Focus on **What** changed and **Why**.
  - Summarize the impact of the change.
- **No Redundancy**: do not repeat information already stated in the title; add
  supplementary details only.
- **Meaningful Summaries**: avoid exhaustive lists for repetitive changes;
  summarize at a higher level instead (for example "Add 30+ project domain terms
  to workspace dictionary").
- **Self-Documenting Titles**: for simple style cleanups or straightforward
  deletions, the body MAY be omitted entirely when the title is exhaustive. Do
  not add filler content just to satisfy a structure requirement.

---

## 4. Example

**Correct Format:**

```text
feat(auth): implement JWT token refresh strategy

Update the authentication flow to handle expired tokens automatically
without forcing a user logout.

- Add 'RefreshToken' service to handle token rotation.

- Update 'AuthInterceptor' to catch 401 errors.

- Add unit tests for token expiration scenarios.

- Update API documentation with new endpoint details.
```

**Incorrect Format:**

```text
Added new auth features

I added a new way to handle tokens so that users don't get logged out.
It uses a new service and I also updated the interceptor.
**Changes:**

* `RefreshToken` service

* Tests
```

---

## 5. Submodule Sync Commits

When the parent repository changes a **submodule pointer**, the commit must
follow a dedicated rule set (title in the form `chore(submodules): sync ...`,
body with the full metadata record, commit list ordered older to newer,
registration URL from `.gitmodules`).

👉 **Read `references/submodule-sync.md`** before writing this commit. Do not
re-derive the rules yourself, because that file holds the exact mandatory
format, including the bookend variant for ranges of more than 500 commits.

---

## 6. Summarizing Opaque or Binary Changes

When changes involve files that Git identifies as binary (encoded text, large
assets, database dumps, ...), you must "dig down" to understand the real content.

- **Content Analysis**: use tools such as `cat -v`, `file`, or an appropriate
  decoder to inspect the actual change.
- **Explicit Asset Mentions**: name the specific file in the body when it is
  critical to the commit's purpose (for example "Includes db_13_12_25.dump as
  the baseline snapshot").
- **Encoding Transparency**: if a file is converted or its encoding changes
  (for example UTF-16 to UTF-8), state this explicitly in the body.
- **Dependency Details**: for dependency files (`requirements.txt`,
  `local.txt`, ...), even when Git sees them as binary, summarize the key
  package changes instead of just saying "updates dependencies".



---

## 7. Amending Established Commits

When amending a commit (`git commit --amend`), the message must describe the
**final combined state of the commit after the amend lands** — not the delta the
amend introduces, and not the original pre-amend state.

**Procedure:**

1. Read the original commit's full diff and the new staged changes.
2. Identify the union of both: what does the commit contain in total now?
3. Write a single coherent message (title + body) for that union.

**Correct (final state):**

```text
docs(rules): cross-reference stash-apply failure fallback with resolvable URLs

- Link to selective file extraction recovery path via GitHub URL that
  resolves in standalone clone
- Link to redaction decision framework used here
```

**Incorrect (delta-only — rejected):**

```text
docs(rules): replace prose reference with SHA-pinned URLs
```

The incorrect message above describes only what the amend changed, not what the
commit **is**.

---

## 8. Self-Check Before Committing

Run this checklist (see also `.cline/workflows/git-commit.md`):

- [ ] Title follows `type(scope): description`, imperative mood, ≤ 72 characters,
      no trailing period.
- [ ] A blank line separates the title from the body (when a body exists).
- [ ] Body uses `-` bullets and wraps at 72 characters.
- [ ] No `**`, `*`, `` ` ``, or `_` (markdown) appears in the message.
- [ ] Body does not repeat the title.
- [ ] Submodule changes → `references/submodule-sync.md` was read.
- [ ] Amend → the message describes the final state, not the delta.
