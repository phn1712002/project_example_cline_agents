# Rule: Language Policy

This rule governs which language is used for written artifacts and for
communication with the user.

---

## 1. Written artifacts in the repository

* **English is mandatory** for every rule, workflow, skill, task definition, or
  any other instruction/config artifact inside `.cline/`, and for
  `.agents/AGENTS.md`.
* This covers, but is not limited to:
  * `.cline/rules/`
  * `.cline/workflows/`
  * `.cline/skills/` (including `SKILL.md` and `references/`)
  * `.cline/tasks/`
  * `.cline/hooks/`
  * `.cline/agents/`
  * `.cline/plugins/`
  * `.cline/cron/`
  * `.agents/AGENTS.md`
  * `.mcp/` configuration files and MCP documentation
* **Vietnamese is allowed only when the user explicitly asks** for that specific
  file to be written in Vietnamese ("write in Vietnamese"). The explicit
  request applies to the named artifact only; default back to English
  afterwards.
* Do not mix Vietnamese prose into English rule files. Vietnamese may appear
  only as a quoted term, an example, or a literal user-provided string.

---

## 2. Communication with the user

* **Always reply in Vietnamese**, concise, clear, and professional.
* Switch to another language only when the user explicitly asks for the reply
  language to change.
* Code, identifiers, commit messages, and technical comments follow the
  conventions of the codebase and the relevant task rules (see
  `.cline/skills/git-commit-message/SKILL.md` for commit messages).

---

## 3. Checklist before hand-over

- [ ] Every new or edited artifact inside `.cline/` is written in English
      (unless the user explicitly requested Vietnamese).
- [ ] `.agents/AGENTS.md` stays in English.
- [ ] The final answer to the user is in Vietnamese.
