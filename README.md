# How I work

This repo is the real, working version of six things:

- **`CONSTITUTION.md`** — the principles I hold myself to on every project: security, cost, reliability, engineering standards, and how tradeoffs get disclosed instead of hidden. Derived bottom-up from real practice, not copied from a framework. This is the canonical copy — my own machine symlinks to this exact file rather than keeping a second private one, so what you're reading is what's actually in effect.
- **`lead-agent.md`** — the actual Claude Code subagent configuration I consult for architecture decisions and standards review. Not a mockup: this file is symlinked into my live setup and is the real thing running when I use it.
- **`REFERENCES.md`** — every real, external source the Constitution's pillars map to (Zero Trust, Defense in Depth, Choose Boring Technology, and the rest), so any claim it makes is checkable, not just asserted.
- **`hooks/block-risky-ops.sh`** — the PreToolUse hook that enforces `lead-agent.md`'s "never touches production or credentials" boundary technically, not just by prompt discipline. Every company gets its own copy in its own repo, per the tenant-isolation reasoning `templates/manager-agent.template.md` documents.
- **`templates/`** — reusable, company/project-agnostic patterns (`manager-agent.template.md`, `subagent.template.md`) for instantiating the next tier down once a real company or project concretely needs one. Not live agents themselves.
- **`WORKING-NOTES.md`** — the reasoning trail behind `CONSTITUTION.md`: how the pillars were derived, what was researched, what was adopted, what was deliberately rejected. Deliberately messier than the Constitution itself — this is where a decision lives before it's settled enough to become a standing principle.

Nothing here ships without my review — that's the standing rule the Constitution itself states and the agent config enforces by design (no ability to act unsupervised, no ability to delegate to other agents on its own).

`CONSTITUTION.md` is amended directly here, on real events only, never on a schedule — this repo's own commit history is the amendment log.
