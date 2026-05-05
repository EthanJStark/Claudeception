# Claude Search Optimization (CSO)

Load this reference when writing or reviewing a skill's `description` field.
CSO is the single highest-leverage thing about any skill: a skill Claude never
loads is a skill that doesn't exist. Everything else in the skill body
(solution, verification, examples) only pays off if the description surfaces
the skill at the right moment.

## Why CSO matters

Claude Code loads skill names and descriptions at startup (~100 tokens each)
and decides which skill bodies to pull in based on semantic-matching those
descriptions against the current conversation. A poor description is
functionally equivalent to deleting the skill — Claude never sees the body,
never runs the steps, never benefits from the knowledge you just extracted.

Testing has also shown a second failure mode: when a description summarizes
**what** the skill does, Claude can take that summary as the answer and skip
reading the body entirely. The skill becomes documentation Claude bounces off
of, instead of a procedure Claude runs.

## The kernel rule

> Description = WHEN to use, NOT WHAT it does

Everything below is a corollary.

## Violation examples

| Bad (summarizes workflow)                  | Good (triggers only)                                    |
|--------------------------------------------|---------------------------------------------------------|
| "Validates tokens and handles auth errors" | "Use when auth fails with 401/403 or token expired"     |
| "Creates skills from session learnings"    | "Use when task required non-obvious investigation"      |
| "Runs tests and reports coverage"          | "Use when tests fail unexpectedly or coverage drops"    |

The bad versions describe the skill's internal workflow. The good versions
describe the symptoms or context that should trigger a load. The first kind
competes with the skill body for Claude's attention; the second kind hands
Claude a decision (load or skip) without pretending to answer the question.

## How to write a good description

A compliant description combines three ingredients:

1. **Specific symptoms** — exact error messages, failure modes, unexpected
   behaviors. `"P2024: Timed out fetching a new connection"` is searchable;
   `"database problems"` is not.
2. **Context markers** — framework, tool, file-type, or environment names
   that disambiguate. `"Next.js getServerSideProps"` narrows the match space;
   `"frontend code"` does not.
3. **Action phrases** — `"Use when:"`, `"Helps with:"`, `"Solves:"` orient
   the description around trigger conditions instead of sliding into
   workflow summary.

### Worked example

```
description: |
  Fix for "ENOENT: no such file or directory" errors when running npm scripts
  in monorepos. Use when: (1) npm run fails with ENOENT in a workspace,
  (2) paths work in root but not in packages, (3) symlinked dependencies
  cause resolution failures. Covers node_modules resolution in Lerna,
  Turborepo, and npm workspaces.
```

Note what it does: lists the error message verbatim, names the three
environments, enumerates three numbered trigger conditions, and never says
what the skill *does* about the problem.

## Keyword coverage

The description is Claude's search index. Include the words Claude would
search for, with synonyms:

- **Error messages:** `ENOENT`, `401 Unauthorized`, `P2024`, `timeout`
- **Symptoms:** `flaky`, `hangs`, `silent failure`, `race condition`
- **Tools / frameworks:** `Next.js`, `Prisma`, `Jest`, `Vitest`, `Fastify`
- **Synonyms:** `timeout/hang/freeze`, `auth/authentication/login`,
  `undefined/null/missing`

If users say the same thing five different ways, the description should
cover at least the two or three most common framings.

## Token efficiency

- Keep the description under 1,536 characters (the combined `description` +
  `when_to_use` spec cap). Budget is shared, so lean is better — aim for
  ~500 characters to leave room for a `when_to_use` field if needed.
- Put the highest-signal content first — error messages and framework names
  before prose.
- Move heavy reference material to separate files (this repo's
  `references/*.md` pattern). Do not inline how-to content into the
  description or the skill body when the same content can be loaded on
  demand from a reference file.

## Description templates

Minimal viable description (general skill):

```
description: |
  Use when: (1) <specific trigger>, (2) <symptom or error message>,
  (3) <context signal>. Keywords: <error strings>, <tool/framework names>.
```

Error-focused skill:

```
description: |
  Fix for "<exact error text>" in <framework/tool>. Use when: (1) <symptom>,
  (2) <environment/context>, (3) <observable behavior>. Covers
  <scope/variants>.
```

Discipline skill (process, not fix):

```
description: |
  Use when: (1) <situation that should trigger the process>, (2) <a second
  triggering context>, (3) <a third>. NEVER: <anti-trigger — when NOT to
  use>. Keywords: <domain terms>.
```
