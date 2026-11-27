## 1. Environment & Tool Version Management with `mise`

- **`mise` is mandatory**: every runtime, CLI tool, and npm-based MCP package
  (such as **Node.js**, **npm**, `npm:cline`, or `npm:<mcp-package>`) must be
  declared and pinned in `mise.toml`.
- **Do not use a non-standard global version** when the tool is managed by
  `mise`; always run commands and MCP servers through the `mise` environment
  (for example `mise exec -- ...`).
- **When adding or changing a tool or MCP package version**:
  - Declare or update it in `mise.toml` (including required options such as
    `version` or `trust_policy_excludes`) instead of installing tools manually
    outside the project.
  - State the version change clearly so the user can confirm and sync.
- **Environment & certificates**:
  - Respect the environment activation script (`cline-activate.ps1`) and the
    certificate file `.cline/cli-node-extra-ca-certs.pem`.
- Never delete, overwrite, or expose sensitive information/local
    certificates.

---

## 2. Centralized Configuration in `.cline/`, MCP in `.mcp/`, and the Role of `.agents/`

- **`.cline/` manages all project configuration resources**:
  - `.cline/rules/`: Project rules.
  - `.cline/workflows/`: Project workflows.
  - `.cline/skills/`: Project skills.
  - `.cline/hooks/`: Lifecycle hooks.
  - `.cline/agents/`: Project agent definitions.
  - `.cline/plugins/`: Project plugins.
  - Always read and follow `.cline/rules/` together with the related
    configuration in `.cline/` before planning or changing code. When adding or
    editing the items above, place them directly in the corresponding folder
    inside `.cline/`.
- **`.mcp/` centrally manages all MCP resources**:
  - MCP configuration files and any MCP repository that must be `git clone`d
    must be placed inside `.mcp/` (for example `.mcp/<mcp-name>/`) so they are
    managed centrally.
  - **Package-based MCP servers**: declare the package in `mise.toml` (for
    example `"npm:@wonderwhy-er/desktop-commander" = ...`) and invoke it in the
    MCP configuration via `mise` (`"command": "mise"`, `"args": ["exec", "--", ...]`).
  - Do not `git clone` MCP source code loose in the repository root or outside
    the project when it belongs to this repository's MCP scope.
  - Keep the MCP configuration valid; never hardcode secrets/tokens/API keys in
    configuration files or source code.
- **Role of `.agents/`**:
  - The `.agents/` folder only contains this guidance file (`AGENTS.md`); do not
    put skills, private configuration, or MCP inside `.agents/`.
- **Respect Git**:
  - Do not perform dangerous Git history edits or commit temporary/sensitive
    files/ignored subfolders listed in `.gitignore`.