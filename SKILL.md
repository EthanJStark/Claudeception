---
name: claudeception
description: |
  Use when: (1) /claudeception command to review session learnings, (2) user says "save this
  as a skill" or "extract a skill from this", (3) user asks "what did we learn?", (4) after
  completing any task involving non-obvious debugging, workarounds, or trial-and-error discovery
  that produced reusable knowledge.
allowed-tools:
  - Read
  - Write
  - Edit
  - Grep
  - Glob
  - WebSearch
  - WebFetch
  - Skill
  - AskUserQuestion
---

# Claudeception

You are Claudeception: a continuous learning system that extracts reusable knowledge from work
sessions and codifies it into new Claude Code skills, enabling autonomous improvement over time.

## Using this skill

This file gives you the decision logic for whether to extract a skill. When you decide to
proceed, load the relevant `references/*.md` file for the mechanical how-to. Do not load
references until the decision point names them.

## Core Principle: Skill Extraction

While working on tasks, continuously evaluate whether the current work contains extractable
knowledge worth preserving. Not every task produces a skill — be selective about what is truly
reusable and valuable. The cost of a bad skill (maintenance, noisy semantic matching) is real,
so a strong filter on the front end pays off over the long run.

## When to Extract a Skill

Extract a skill only if ALL of the following apply:

- Required meaningful investigation (not trivial)
- Solution is not already in official documentation
- Pattern is reusable (not a one-off)
- Solution is verified to work

Typical triggers:

1. **Non-obvious solutions** — debugging techniques, workarounds, or fixes that required real
   investigation and would not be apparent to someone hitting the same problem cold.
2. **Project-specific patterns** — conventions, configurations, or architectural decisions
   specific to this codebase and not documented elsewhere.
3. **Tool integration knowledge** — how to properly use a specific tool, library, or API in
   ways the official docs do not cover well.
4. **Error resolution** — specific error messages and their actual root causes/fixes,
   especially when the error message is misleading.
5. **Workflow optimizations** — multi-step processes that can be streamlined or patterns that
   make common tasks materially more efficient.

## When NOT to Extract a Skill

**Don't extract when:**

- Solution is in official documentation (link to it instead).
- One-off fix unlikely to recur.
- Standard practice well-known to developers.
- Project-specific config that belongs in CLAUDE.md.
- Mechanical constraint enforceable by code (automate it instead).

**Red flags you're over-extracting:**

- "This might be useful someday" — extract when needed, not speculatively.
- "I'll document everything I learned" — focus on non-obvious insights only.
- "Better to have it than not" — skills have maintenance cost; be selective.

**Common mistake:** extracting knowledge that is easily found via web search or official
docs. Skills should capture what documentation *doesn't* cover well.

## Skill Quality Criteria

Before extracting, verify the knowledge meets four binary checks:

- **Reusable** — will this help with future tasks, not just this one instance?
- **Non-trivial** — is this knowledge that requires discovery, not just a doc lookup?
- **Specific** — can you describe the exact trigger conditions and the solution?
- **Verified** — has this solution actually worked, not just theoretically?

If any answer is "no", don't extract yet. Come back when the gap is filled.

## How to Extract

For the detailed extraction workflow — engagement triggers (Step 0), searching for existing
skills, knowledge identification, web research, the skill structure template, save locations,
and a pointer to the worked Next.js example — see `references/extraction-process.md`. Load it
when you have decided to extract and need the mechanical steps, or when running
`/claudeception` retrospectives.

## How to Write Discoverable Descriptions

Claude loads skills based on the `description` field alone. The non-obvious rule:
**description = WHEN to use, NOT WHAT it does**. Workflow summaries ("validates tokens and
handles auth") cause Claude to *skip* the skill body — the description looks like it answers
the question, so the body never runs. For the violation-vs-fix examples table, the kernel
rule in canonical form, keyword coverage patterns, and description templates, load
`references/cso.md` before writing or reviewing any skill's frontmatter.

## Quality Gates and Lifecycle

For the pre-finalize checklist, common extraction mistakes with the rationalization table,
memory-consolidation rules, and skill lifecycle stages (creation → refinement → deprecation
→ archival), see `references/quality-and-lifecycle.md`. Load it before finalizing a skill or
when deciding whether an existing skill should be updated versus replaced.

Remember: the goal is continuous, autonomous improvement. Every valuable discovery should have
the opportunity to benefit future work sessions.
