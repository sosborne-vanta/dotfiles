# Personal Claude Preferences

## Code Comments

Default: no comment. Add one only when removing it would confuse a future reader who has the diff. If a name needs a comment to make sense, rename the thing instead.

### Don't restate names or types

```typescript
// BAD — name + type already say this
interface BuildArgs {
  /** Part values the LLM emitted, keyed by part id. */
  answerPartValues: readonly AnswerPartUpdate[];
  /** Output of buildMultiLangAgentContext. */
  multiLangContext: MultiLangAgentContext;
}

// GOOD
interface BuildArgs {
  answerPartValues: readonly AnswerPartUpdate[];
  multiLangContext: MultiLangAgentContext;
}
```

JSDoc on every field of an exported interface is almost always wrong. If a field is genuinely non-obvious, fix the name.

### Don't paraphrase the function body

```typescript
// BAD — restates what the next 30 lines do
/**
 * Reverse-maps enum values, translates free-text, validates against
 * the target schema, reverts failures. Returns the localized parts
 * and the pre-translation values for the audit log.
 */
async function buildTargetLanguageAnswerParts(args) { ... }

// GOOD — no doc; the name + return type already say it
async function buildTargetLanguageAnswerParts(args) { ... }
```

### Don't narrate the algorithm

```typescript
// BAD — the comment is a slower version of the code
// Walk each part, look up its translated enum, build a Map keyed
// by the local value pointing at the target-locale value.
for (const part of context.answerParts) { ... }

// GOOD — let the loop body speak for itself
for (const part of context.answerParts) { ... }
```

### Don't reference the current task or callers

```typescript
// BAD — rots the moment something changes
// Added for CTAUTO-1226. Used by executeAndLogSemanticMatch in the
// worker to bridge the multi-lang flow.
export function buildTargetLanguageAnswerParts() { ... }

// GOOD
export function buildTargetLanguageAnswerParts() { ... }
```

Ticket numbers, "added for", "used by", and change history all belong in the PR description and commit message, not in code.

### When a comment IS warranted

Only when the *why* is non-obvious and won't be discoverable from the diff, a nearby name, or the type signature:

- **Hidden constraint**: `// TS can't narrow length > 0 to a populated tuple`
- **Subtle invariant**: `// Distinct enum values that collide after scrubbing get suffixed " (n)" so the reverse map stays unambiguous`
- **Non-obvious failure mode**: `// Without answerParts, the AL update path falls through to legacy synthesis and clobbers the custom parts schema`
- **Surprising exclusion with rationale**: `// date/email excluded — ISO 8601 is locale-independent on the wire`

If your comment doesn't fit one of those, delete it.

Comments should be clean, concise, and durable — written as if the task that prompted them never existed. Do not add comments about local testing steps, session context, iteration history, or what changed in this pass.

## Pull Request Descriptions

Keep descriptions clear, concise, and easily scannable. Prefer bullet points over paragraphs. Do not wrap lines prematurely — let lines run to their natural length.
