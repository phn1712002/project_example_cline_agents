# Workflow: Git Commit

An **on-demand** procedure for creating or amending a commit.
Rule source: skill `.cline/skills/git-commit-message/SKILL.md`
(plus `references/submodule-sync.md` when the commit touches a submodule).

> This workflow does NOT run automatically. Activate it when the user asks to
> commit, fix a commit message, or amend a commit.

---

## Step 0 — Load the rules

1. Activate the `git-commit-message` skill.
2. Read `SKILL.md` (§1–§8).

---

## Step 1 — Gather context

Run the following (keep parent repo and submodule staging separate):

```powershell
git status --short
git --no-pager diff --cached --stat
git --no-pager diff --cached            # skip when the diff is huge (>500 lines)
git --no-pager log --oneline -10        # match the repo's existing commit style
```

- If `diff --cached` is empty but files are unstaged, ask the user whether to
  `git add` first; never stage changes outside the requested scope on your own.
- If the diff is large: read `--stat` plus the full diff of the key files
  (main source/config) and skip generated files.

**Classify secondary change types:**

- A path with mode `160000` in `git diff --cached` (or `Subproject commit` in
  `git diff --cached --submodule`) → set **SUBMODULE = true** and read
  `references/submodule-sync.md`.
- Binary files (`Binary files ... differ`) → apply §6 of `SKILL.md`.

---

## Step 2 — Determine type and scope

| Change | type |
|---|---|
| New feature, new behavior | `feat` |
| Bug fix | `fix` |
| Documentation or comments only | `docs` |
| Formatting, whitespace, lint | `style` |
| Restructuring without behavior change | `refactor` |
| Adding or updating tests | `test` |
| Build, CI, deps, config, submodule pointer | `chore` |

- `scope` = the module/directory most affected (`auth`, `rules`, `skills`,
  `workflows`, `submodules`, `repo`, ...).
- Mixed change types → pick the type that reflects the **primary purpose** of
  the commit; split the commit when the purposes are too different.

---

## Step 3 — Draft the title

1. Shape: `type(scope): description`, imperative mood.
2. Measure the length: target < 50, hard limit ≤ 72 characters.
3. No trailing period; no markdown.
4. When the change is time-bound (release, meeting, deadline), put the date in
   the title (for example `docs(meeting): record 2026-11-27 release notes`).

**Passing example:** `refactor(rules): retire git commit rule in favor of skill`
(58 characters → OK)

---

## Step 4 — Draft the body

1. One blank line immediately after the title.
2. One bullet `-` per point; wrap every line at ≤ 72 characters.
3. Content: What + Why + Impact. Never repeat the title.
4. Do not use `**`, `*`, `` ` ``, or `_`.
5. Repetitive changes across many items → summarize at a high level instead of
   listing each one.
6. Binary or dependency changes → name the specific file/package (§6).
7. When the title is already exhaustive (style, cleanup, simple deletion) →
   **omit the body entirely**.

---

## Step 5 — SUBMODULE branch (when Step 1 set the flag)

Run only when the submodule pointer changed. Read
`references/submodule-sync.md` and execute:

```powershell
# Old and new SHA (full 40 characters)
git ls-tree HEAD <submodule>                     # old SHA
git ls-tree :<submodule>                         # new SHA in the index

# Count commits in the range to decide bookend mode
git -C <submodule> rev-list --count <old>..<new>

# Commit list (older to newer)
git -C <submodule> --no-pager log --oneline --reverse <old>..<new>

# Tip commit metadata
git -C <submodule> --no-pager show --no-patch --stat <new>
git -C <submodule> --no-pager log -1 --format="parent:%P%nmsg:%s%nauthor:%an <%ae>%nat:%aI%ncommitter:%cn <%ce>%nct:%cI" <new>

# Registration URL
git config -f .gitmodules --get-regexp '^submodule\..*\.url$'
```

- N > 500 → use the **bookend variant** (`(N commits, bookend listing)`).
- N ≤ 500 → list them all, ordered **older to newer**.
- The body must preserve the submodule's original message verbatim, never
  paraphrased.

---

## Step 6 — AMEND branch (when the user asks to amend)

1. Read the original commit diff:
   `git --no-pager show --stat HEAD` and `git --no-pager show HEAD`.
2. Read the current staged changes: `git --no-pager diff --cached`.
3. Determine the **union** of both — what the commit contains after amending.
4. Write a message describing the **final state**, never the delta.

---

## Step 7 — Self-check

Check every item and record the results:

- [ ] Title follows `type(scope): description`, imperative mood.
- [ ] `Title.Length -le 72`, does not end with `.`.
- [ ] A blank line separates the title from the body.
- [ ] Every body line is ≤ 72 characters.
- [ ] No `**`, `*`, `` ` ``, or `_` appears.
- [ ] Bullets start with `- `.
- [ ] The body does not repeat the title.
- [ ] SUBMODULE = true → `references/submodule-sync.md` followed (full SHAs,
      older-to-newer order, metadata, registration URL).
- [ ] AMEND → the message describes the final state.

**Machine validation is mandatory** (do not rely on eyeballing). Assign the
message to a variable, then run:

```powershell
$msg = @'
type(scope): description

- First bullet.
'@

$lines = $msg -split "`r?`n"
'--- title ---'
$lines[0]
"title length : $($lines[0].Length)   (must be <= 72)"
"ends with dot: $($lines[0].EndsWith('.'))   (must be False)"
"conventional : $($lines[0] -match '^(feat|fix|docs|style|refactor|test|chore)(\([a-z0-9._/-]+\))?: .+')"
"blank line 2 : $([string]::IsNullOrWhiteSpace($lines[1]))   (must be True)"

'--- over-72 lines ---'
$lines | Where-Object { $_.Length -gt 72 } | ForEach-Object { '{0,3} {1}' -f $_.Length, $_ }

'--- markdown chars ---'
$lines | Where-Object { $_ -match '\*\*|`|(^|\s)\*\s|(^|\s)_[^_]+_(\s|$)' }

'--- non-bullet body lines (excluding title/blank) ---'
$lines | Select-Object -Skip 2 | Where-Object {
    -not [string]::IsNullOrWhiteSpace($_) -and -not $_.StartsWith('- ') -and -not $_.StartsWith('  ')
}
```

If anything appears under `over-72 lines`, `markdown chars`, or
`non-bullet body lines` → **fix the message and re-run**. Never commit while an
anomaly is still reported.

---

## Step 8 — Execute the commit

Use stdin to avoid PowerShell quoting problems:

```powershell
@'
type(scope): description

- First bullet.
- Second bullet.
'@ | git commit -F -
```

- Amend: add `--amend` → `@'...'@ | git commit --amend -F -`.
- Do not add `--no-verify` or `--no-gpg-sign` unless the user asks for it.
- **Never push** in this workflow.

---

## Step 9 — Hand over

1. Show the message that was used.
2. Confirm the result:
   ```powershell
   git --no-pager log -1 --format="%H%n%B"
   git status --short
   ```
3. Report: commit hash, title, body, and the self-check items that passed.
