# Quality and Lifecycle

Load this reference before finalizing a skill and whenever deciding
whether an existing skill should be updated, deprecated, or archived.
The core skill's "Skill Quality Criteria" section covers the binary
go/no-go; this file covers the finer-grained checks, the anti-patterns
that tend to slip past those checks, and the long-term lifecycle.

## Self-reflection prompts

During or right after the work that prompted extraction, ask:

- "What did I just learn that wasn't obvious before starting?"
- "If I faced this exact problem again, what would I wish I knew?"
- "What error message or symptom led me here, and what was the actual
  cause?"
- "Is this pattern specific to this project, or would it help in similar
  projects?"
- "What would I tell a colleague who hits this same issue?"

If the answers are thin, the extraction probably isn't worth it yet.
Come back when you have something specific to say.

## Memory consolidation

Before writing, consider:

1. **Combining related knowledge** — if multiple related discoveries were
   made in the same session, decide whether they belong in one
   comprehensive skill or several focused ones. Default to focused; split
   when the triggers genuinely differ.
2. **Updating existing skills** — check whether an existing skill should
   be extended (variant subsection, new trigger) rather than replaced
   with a near-duplicate.
3. **Cross-referencing** — note related skills in the `Notes` section so
   future lookups don't miss the sibling.

## Quality gates

Before finalizing, verify:

- [ ] Description contains specific trigger conditions, not workflow
      summary.
- [ ] Solution has been verified to work (not just theorized).
- [ ] Content is specific enough to be actionable.
- [ ] Content is general enough to be reusable beyond the current case.
- [ ] No sensitive information (credentials, internal URLs, secrets).
- [ ] Skill doesn't duplicate existing documentation or another skill.
- [ ] Web research was conducted when appropriate (technology-specific
      topics).
- [ ] `## References` section included if web sources were consulted.
- [ ] Current best practices (post-2025) incorporated when relevant.

A skill that fails any of these should either be fixed before shipping
or shelved. Shipping a skill that fails a gate costs more over the
long run than not shipping it at all — it dilutes semantic matching
for the skills that *do* pass.

## Common mistakes

### Mistake 1: Over-extraction

**Problem:** Extracting every solution, creating maintenance burden.
**Fix:** Apply quality gates strictly — reusable AND non-trivial AND
verified. If any leg is weak, don't extract.

### Mistake 2: Vague descriptions

**Problem:** `"Helps with React problems"` won't surface when needed.
**Fix:** Include specific triggers, error messages, symptoms. See
`references/cso.md` for the full description-writing discipline.

### Mistake 3: Workflow summaries in description

**Problem:** Claude follows the description instead of reading the
skill body — the description answers the question and the body is
skipped.
**Fix:** Description contains **only** trigger conditions, never
workflow.

### Mistake 4: Unsupported frontmatter fields

**Problem:** Adding `author` / `version` / `date` fields that the skill
runtime ignores. They look helpful but they are silent dead weight and
create the false impression that the schema is richer than it is.
**Fix:** Use only `name`, `description`, and other supported spec
fields (`allowed-tools`, etc.).

### Rationalization table

When you catch yourself about to extract something marginal, match the
excuse against the reality:

| Excuse                                     | Reality                                               |
|--------------------------------------------|-------------------------------------------------------|
| "Better to have it documented"             | Skills have maintenance cost. Be selective.           |
| "This might be useful someday"             | Extract when needed, not speculatively.               |
| "I'll be thorough and add all fields"      | Extra fields are ignored. Follow the spec exactly.    |
| "Description should explain what it does"  | Description is for discovery, not documentation.      |
| "Official docs are too long to read"       | Skills complement docs, don't replace them.           |

## Skill lifecycle

Skills are not write-once. They evolve through four stages:

1. **Creation** — initial extraction with documented verification.
2. **Refinement** — updates as additional use cases or edge cases
   surface. New trigger conditions get added to the description;
   new variants get subsections.
3. **Deprecation** — when the underlying tool, framework, or pattern
   changes materially, mark the skill deprecated in the `Notes`
   section and link to whatever replaces it. A deprecated-with-pointer
   skill is more useful than silent rot.
4. **Archival** — when a skill is no longer relevant at all, remove or
   archive it. Skills that describe problems nobody hits any more still
   compete for semantic-match attention and make the skill library
   noisier than it needs to be.

Lifecycle stages belong in the `Notes` section or an external
changelog, not in unsupported frontmatter fields.
