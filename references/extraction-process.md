# Extraction Process

Load this reference when you have decided a piece of knowledge is worth
extracting and need the mechanical steps, or when `/claudeception` is
invoked for a retrospective. The core `SKILL.md` decides **whether** to
extract; this file covers **how**.

## Step 0: When to engage

Invoke the Claudeception skill immediately after completing a task when
**any** of these apply:

1. **Non-obvious debugging** — solution required meaningful investigation
   and wasn't found in documentation.
2. **Error resolution** — fixed an error where the message was misleading
   or the root cause wasn't obvious.
3. **Workaround discovery** — found a workaround for a tool/framework
   limitation that required experimentation.
4. **Configuration insight** — discovered project-specific setup that
   differs from standard patterns.
5. **Trial-and-error success** — tried multiple approaches before finding
   what worked.

Also invoke explicitly when:

- The user runs `/claudeception`.
- The user says "save this as a skill" or similar.
- The user asks "what did we learn?"

After any significant task, self-check: *"Did I just spend meaningful time
investigating something? Would future-me benefit from this being
documented? Was the solution non-obvious from docs alone?"* If yes to any,
engage.

## Retrospective mode

When `/claudeception` is invoked at the end of a session:

1. **Review the session** — analyze the conversation for extractable
   knowledge.
2. **Identify candidates** — list potential skills with brief
   justifications.
3. **Prioritize** — focus on the highest-value, most reusable knowledge.
4. **Extract** — create skills for the top candidates (typically 1-3 per
   session).
5. **Summarize** — report what was created and why.

## Step 1: Check for existing skills

Find related skills before creating a new one. Decide: update or create?

```sh
# Skill directories (project-first, then user-level)
SKILL_DIRS=(
  ".claude/skills"
  "$HOME/.claude/skills"
  "$HOME/.codex/skills"
)

rg --files -g 'SKILL.md' "${SKILL_DIRS[@]}" 2>/dev/null   # list all
rg -i "keyword1|keyword2" "${SKILL_DIRS[@]}" 2>/dev/null  # by keywords
rg -F "exact error message" "${SKILL_DIRS[@]}" 2>/dev/null
```

| Found                                            | Action                                                   |
|--------------------------------------------------|----------------------------------------------------------|
| Nothing related                                  | Create new                                               |
| Same trigger and same fix                        | Update existing                                          |
| Same trigger, different root cause               | Create new, add `See also:` links both ways              |
| Partial overlap (same domain, different trigger) | Update existing with a "Variant" subsection              |
| Same domain, different problem                   | Create new, add `See also: [skill-name]` in Notes        |
| Stale or wrong                                   | Mark deprecated in Notes, add replacement link           |

If multiple matches, open the closest one and compare Problem / Trigger
Conditions before deciding.

## Step 2: Identify the knowledge

Analyze what was learned:

- What was the problem or task?
- What was non-obvious about the solution?
- What would someone need to know to solve this faster next time?
- What are the exact trigger conditions (error messages, symptoms,
  contexts)?

## Step 3: Research (when appropriate)

Search official docs and current best practices before extracting
technology-specific skills. Skip for project-specific patterns,
well-understood generics, and time-sensitive extractions. Cite any web
sources in a `## References` section. If search doesn't surface
authoritative content, note that explicitly — absence of good docs is
itself a reason the skill has value.

## Step 4: Structure the skill

Before writing the body, write the `description`. The description decides
whether Claude ever loads the body — treat it as the most important line
in the file and see `references/cso.md` for the rules and examples.

Then fill in the body using this template:

```markdown
---
name: [descriptive-kebab-case-name]
description: |
  Use when: (1) [specific trigger condition], (2) [symptom or error message],
  (3) [context that signals this skill applies]. Include keywords users would
  naturally say. NEVER summarize what the skill does — only when to use it.
---

# [Skill Name]

## Overview
What is this? Core principle in 1-2 sentences.

## When to Use
[Bullet list with symptoms and use cases]

## When NOT to Use
[Explicit anti-patterns — when this skill does NOT apply]

## Solution
[Step-by-step solution or knowledge to apply]

## Quick Reference
[Table or bullets for scanning common operations]

## Common Mistakes
[What goes wrong + fixes, rationalization table if discipline skill]

## Verification
[How to verify the solution worked]

## Notes
[Any caveats, edge cases, or related considerations]

## References
[Optional: links to official documentation or resources consulted]
```

## Step 5: Save the skill

- **Project-specific skills:** `.claude/skills/[skill-name]/SKILL.md`
- **User-wide skills:** `~/.claude/skills/[skill-name]/SKILL.md`

Include supporting scripts in a `scripts/` subdirectory if the skill
benefits from executable helpers.

## Worked example

For a complete example of the extraction output — description, trigger
conditions, solution steps, verification, and notes — see
`examples/nextjs-server-side-error-debugging/SKILL.md`. The thought
process (trigger → search → structure → save) is Steps 1-5 above; the
example shows what the final artifact looks like after those steps run.
