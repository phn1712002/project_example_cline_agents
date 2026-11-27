# AGENTS.md - General Working Rules

This document lives in `.agents/AGENTS.md` and provides general direction when
working with the repository. All project configuration is managed centrally in
`.cline/`, while MCP is managed centrally in `.mcp/`.

---

## 1. Environment & Tool Version Management with `mise`

* **`mise` is mandatory**: every runtime and CLI tool such as **Node.js**,
  **npm** (or another package manager when declared), **Python**, etc. must use
  the version pinned in `mise.toml`.
* **Do not use a non-standard global version** when the tool is managed by
  `mise`; prefer running commands through the `mise` environment (for example
  `mise exec -- ...` or after activating the project environment).
* **When adding or changing a tool version**:
  * Update `mise.toml` instead of installing tools manually outside the project.
  * State the version change clearly so the user can confirm and sync.
* **Environment & certificates**:
  * Respect the environment activation script (`cline-activate.ps1`) and the
    certificate file `.cline/cli-node-extra-ca-certs.pem`.
  * Never delete, overwrite, or expose sensitive information/local
    certificates.

---

## 2. Centralized Configuration in `.cline/`, MCP in `.mcp/`, and the Role of `.agents/`

* **`.cline/` manages all project configuration resources**:
  * `.cline/rules/`: Project rules.
  * `.cline/workflows/`: Project workflows.
  * `.cline/skills/`: Project skills.
  * `.cline/hooks/`: Lifecycle hooks.
  * `.cline/agents/`: Project agent definitions.
  * `.cline/plugins/`: Project plugins.
  * Always read and follow `.cline/rules/` together with the related
    configuration in `.cline/` before planning or changing code. When adding or
    editing the items above, place them directly in the corresponding folder
    inside `.cline/`.
* **`.mcp/` centrally manages all MCP resources**:
  * MCP configuration files and any MCP repository that must be `git clone`d
    must be placed inside `.mcp/` (for example `.mcp/<mcp-name>/`) so they are
    managed centrally.
  * Do not `git clone` MCP source code loose in the repository root or outside
    the project when it belongs to this repository's MCP scope.
  * Keep the MCP configuration valid; never hardcode secrets/tokens/API keys in
    configuration files or source code.
* **Role of `.agents/`**:
  * The `.agents/` folder only contains this guidance file (`AGENTS.md`); do not
    put skills, private configuration, or MCP inside `.agents/`.
* **Respect Git**:
  * Do not perform dangerous Git history edits or commit temporary/sensitive
    files/ignored subfolders listed in `.gitignore`.

---

## 3. General Rules When Executing Tasks

* **Stay in scope**: only change the parts related to the request; do not make
  scattered edits outside the scope unless asked.
* **Verify before hand-over**: run the project-appropriate lint, tests, build,
  or syntax checks using the `mise` environment and report the results clearly.
* **Language**:
  * **English by default for written rules/config**: every rule, workflow,
    skill, or task-definition file inside `.cline/` (including this `AGENTS.md`
    and other `.cline/` artifacts such as tasks, hooks, plugins, cron, etc.)
    must be written in **English**. Only write them in Vietnamese when the user
    explicitly says to write in Vietnamese.
  * **Vietnamese for communication**: always reply/communicate with the user in
    **Vietnamese**, concise and clear (unless the user explicitly requests
    another language for the reply).
  * **Code language**: source code, identifiers, and technical comments follow
    the language required by the task or the conventions of the codebase.
