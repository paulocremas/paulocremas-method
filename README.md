# How I work

This repo is the real, working version of two things:

- **`CONSTITUTION.md`** — the principles I hold myself to on every project: security, cost, reliability, engineering standards, and how tradeoffs get disclosed instead of hidden. Derived bottom-up from real practice, not copied from a framework.
- **`lead-agent.md`** — the actual Claude Code subagent configuration I consult for architecture decisions and standards review. Not a mockup: this file is symlinked into my live setup and is the real thing running when I use it.

Nothing here ships without my review — that's the standing rule the Constitution itself states and the agent config enforces by design (no ability to act unsupervised, no ability to delegate to other agents on its own).

This snapshot of `CONSTITUTION.md` is updated deliberately, not synced automatically — it amends on real events, never on a schedule.
