# How I work

This repo is the real, working version of two things:

- **`CONSTITUTION.md`** — the principles I hold myself to on every project: security, cost, reliability, engineering standards, and how tradeoffs get disclosed instead of hidden. Derived bottom-up from real practice, not copied from a framework. This is the canonical copy — my own machine symlinks to this exact file rather than keeping a second private one, so what you're reading is what's actually in effect.
- **`lead-agent.md`** — the actual Claude Code subagent configuration I consult for architecture decisions and standards review. Not a mockup: this file is symlinked into my live setup and is the real thing running when I use it.
- **`REFERENCES.md`** — every real, external source the Constitution's pillars map to (Zero Trust, Defense in Depth, Choose Boring Technology, and the rest), so any claim it makes is checkable, not just asserted.

Nothing here ships without my review — that's the standing rule the Constitution itself states and the agent config enforces by design (no ability to act unsupervised, no ability to delegate to other agents on its own).

`CONSTITUTION.md` is amended directly here, on real events only, never on a schedule — this repo's own commit history is the amendment log.
