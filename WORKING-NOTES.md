# Working notes

*The reasoning trail behind `CONSTITUTION.md` and the agent hierarchy that enforces it: how the pillars were derived, what was researched, what was adopted, what was deliberately rejected, and why the mechanism is shaped the way it is.*

`CONSTITUTION.md` states the principles. This file is the working layer beneath it — the Constitution's own Preamble points here ("that reasoning evolves in Paulo's own working notes and reaches this document only when it's settled enough to state as a standing principle"). It is deliberately messier than the Constitution: it holds research in progress, decisions with their history attached, and candidates considered and turned down.

**Scope, same boundary the Constitution states for itself**: nothing here names a client, a client's systems, or proprietary data. Where a real precedent is cited, it is described generically — the same genericization already applied throughout `CONSTITUTION.md`'s Precedent blocks. Personal career and positioning material is not método construction and lives outside this repo entirely.

**Why this file is public**: keeping the construction trail private created a real drift class — a decision recorded in a private note that the public documents never learned about. Two real bugs of exactly that kind were found and fixed on 2026-08-19. One canonical, publicly-updatable home for método construction removes the class by construction rather than by discipline.

---

## How these documents relate

**Document hierarchy** — so nothing gets duplicated without noticing:

**Mission / Values** (philosophy — canonical summary in `CONSTITUTION.md`'s Preamble, full reasoning in this file) → **Policy** (`CONSTITUTION.md`, plus the planned sibling `Usage Policy`) → **Standard** (`STANDARDS.md`, one per company) → **Procedure** (ADRs, postmortems, runbooks).

The agent hierarchy is *not* a document tier. It is the enforcement apparatus that sits outside this stack and applies it. This file is not a governance tier either — it is the workspace that produces the tiers above. Once a piece of content is fully drafted into its proper tier, its section here is trimmed to history-and-pointer rather than left as a second live copy.

**The plain-language version, confirmed 2026-08-17**: think of it as literally building a company. These working notes are how the company is being built — evolving, full of research and decisions in progress. `CONSTITUTION.md` is that company's actual constitution, the stable canonical statement. The public-facing materials are its public face. The real client work these practices were derived from is none of those three — it is the evidence base, referenced, never edited from here.

**Naming**: "Constitution" was locked 2026-08-16. It fits the federal/state-law analogy the hierarchy already used, is secular and professional, and has direct precedent in Anthropic's own "Claude's Constitution."

---

## Philosophy layer

**Philosophy vs. principles vs. mechanism — the three are not interchangeable (2026-08-17)**:

- **Philosophy** (the why, the belief) = agentic engineering, plus the founding belief that one person with the right machinery can do it all, and nothing ships unsupervised, plus the companion philosophies below. What is believed about how work should be done.
- **Principles** (the what, the operational values) = the Constitution proper: the 5 pillars plus Proportionality. This is the actual principles statement.
- **Mechanism** (the how, enforcement) = the agent hierarchy (Lead agent / Manager agent / Subagent, federal → state → municipal). Not a belief and not a value — an org chart. Deliberately excluded from any principles or philosophy statement; it belongs in the technical/implementation layer. Federal/state/municipal describes how authority cascades through *that hierarchy specifically*, not how the 5 pillars are organized — Security, Financial, and the rest apply at every level, not one each.

### The four companion philosophies

Real, established schools of thought that sit alongside agentic engineering at the philosophy layer. None are new pillars or new practices. `CONSTITUTION.md`'s Preamble carries the canonical one-paragraph summary; the reasoning is here.

- **Agentic engineering** — the current industry distinction between a senior engineer directing and reviewing AI agent output (governance, architecture, and security owned by the human) and unsupervised AI output shipped without review. Deliberately used as a reference term only, never as a self-applied title: the term is too new and unstable to be a safe identity claim.
- **"Choose Boring Technology"** (Dan McKinley) — a limited number of innovation tokens exist; spend them only where they truly matter, use proven and well-understood tools everywhere else. The 2026 relevance is direct: AI coding tools make this more important, not less, because there is no way to verify whether an AI-suggested unfamiliar technology is sound or hallucinated (deprecated APIs, unproven patterns). Complements agentic engineering — human judgment governs not just *whether* to trust AI output, but *what tools* get chosen in the first place.
- **Human-in-the-loop (HITL) / human-on-the-loop (HOTL) / "AI-in-the-loop"** — real AI-safety taxonomy. HITL means a human approves before a critical action executes. HOTL means a human monitors and can intervene, more scalable, used for ongoing supervision rather than every micro-action. The newest and most precise reframing, "AI-in-the-loop," puts the human as the primary decision-maker with AI operating inside *that* loop. Gives precise, academically-grounded vocabulary to replace the flat assertion "nothing ships unsupervised."
- **"You Build It, You Run It"** (Werner Vogels / Amazon, 2006) — whoever builds a system also operates it in production, no throwing code over the wall. Already proven rather than aspirational: every pipeline, dashboard, and demo repo here is built *and* operated end to end by one person. Real precedent for exactly the ownership model this method claims — a validated management philosophy with a 20-year track record, not an invention.

### What each philosophy actually changed (2026-08-18)

Philosophies carry applied weight here, not just belief. The concrete link for each:

- **Agentic engineering** → the entire agent hierarchy, plus the "everything human-reviewed" requirement in every pillar. Already the mechanism, not aspirational.
- **Choose Boring Technology** → a gap added to Pillar 4 (Engineering Excellence): when AI suggests an unfamiliar library, pattern, or API, treat it as needing *extra* verification before shipping, not baseline trust. A direct defense against the AI-hallucinated-dependency failure mode the research flagged.
- **HITL / HOTL / AI-in-the-loop** → refines "nothing runs unsupervised" into a tiered rule matching Proportionality's three Tiers (see Working model below).
- **You Build It, You Run It** → cited as evidence for an ownership model already proven, not adopted as something new.

### Five names for what the method already does or has committed to

Precise, credible vocabulary for practices that already existed under no particular name. Distinct from the philosophies above: these name individual practices, not whole schools of thought. Three are proven today; two are named rollout commitments and are not proven yet.

- **Zero Trust** ("never trust, always verify") — **proven**: names what Pillar 1 already demonstrates (a scoped service account per pipeline, deploy identity kept separate from runtime, least privilege).
- **Defense in Depth** (independent, overlapping controls, no single point of failure) — **proven**: names what Pillar 2 already demonstrates (a rate-limit incident fixed with retry-on-429 *and* schedule retiming, not just one of the two).
- **Toil reduction** (Google SRE: repetitive work with no lasting value; the real target is keeping it under 50% of time, with the rest going to work that reduces future toil) — **proven**: names what Pillar 4 already demonstrates (one-line repo status, redundant docs deleted on sight, bug-to-checklist habit), now with a citable benchmark.
- **Shift Left** (catch problems as early in the lifecycle as possible — security and dependency scans on every PR, checks before deploy rather than after) — **rollout commitment, not proven** (added 2026-08-18): names the target for Pillar 2 and Pillar 4's dependency-scanning and CI-gating commitments, tying them under one recognizable banner.
- **Chaos Engineering** (deliberately inject failure to verify resilience, scoped by blast radius — start with one instance, service, or low traffic percentage, expand only after confirming safety) — **rollout commitment, not proven** (added 2026-08-18): genuinely scales down to small teams per the research, not just enterprise theater, once it actually happens. Applied as a gap in Pillar 2's cheap-failure practice: proactive, blast-radius-scoped failure injection rather than only reactive fixes after a real incident.

---

## How the pillars were derived

Bottom-up, method locked 2026-08-17. Real, provable practices were extracted first and grouped upward into emergent categories; each category was then used to find adjacent gaps worth adopting. Never the reverse — no external framework's pillars were picked first and then hunted for proof to fit them.

Ten categories emerged. All ten are fully absorbed into `CONSTITUTION.md`. **This table is history only** — a lookup from the original category name to where its content lives now. It is not the live statement of any practice; check `CONSTITUTION.md` first.

| Original category | Lives in | Founding proof |
|---|---|---|
| 1. Exposure & access discipline | Pillar 1: Security | Real access-discipline practice on a live client project |
| 2. Design for cheap failure | Pillar 2: Reliability | A shared third-party rate-limit incident and its two-part fix |
| 3. Verify against ground truth, don't infer | Pillar 2: Reliability | An ops dashboard rebuilt after a status-inference bug |
| 4. Verify before shipping, revert without drama | Pillar 4: Engineering Excellence | A ported optimization verified byte-identical before shipping |
| 5. Cost bounded by construction | Pillar 5: Financial | A batch-inference API used instead of an open-ended agent loop |
| 6. Anti-accumulation | Pillar 4: Engineering Excellence | One-line repo status; redundant docs deleted on sight |
| 7. Tradeoffs written down, never silent | Pillar 3: Governance & Transparency | A conscious, disclosed token-reuse decision |
| 8. Controls proportionate to the system | Proportionality (cross-cutting) | Manual-only projects correctly exempted from controls that don't apply |
| 9. Database / data-layer standards | Pillar 4: Engineering Excellence | Found 2026-08-17, on a dedicated re-review of the evidence base |
| 10. Eliminate tribal knowledge | Pillar 3: Governance & Transparency | Found 2026-08-17, same re-review |

The five pillars that emerged loosely echo GCP's own Well-Architected pillars (Security, plus Cost, Reliability, and Operational Excellence, minus Performance Efficiency and Sustainability, which have no real proof behind them here) plus a Governance pillar that is distinctly this method's own. That convergence is a sign the bottom-up process landed somewhere legitimate — it is not the source, and is deliberately not leaned on as if it were.

---

## The agent hierarchy (mechanism)

Public since 2026-08-18. This is the enforcement apparatus for `CONSTITUTION.md`, and it stays out of the Constitution itself by design (see philosophy/principles/mechanism above).

### Three tiers

**Lead agent** (federal) > **Manager agent, per organization/client** (state) > **Subagent, per project** (municipal). Terminology locked 2026-08-17.

The top tier was first locked as "Orchestrator" — the established term for a top-level agent that decomposes goals, delegates, monitors, and synthesizes without doing the work itself. It was renamed **Lead agent** the same day, after 2026 industry sources (IBM, Glide, and others) were found using "Orchestrator" for the evolved *senior-engineer human role* itself: the person who translates business intent into agent-bounded context and decides what an agent can access. Using the same word for both a human role and an agent tier is a real naming collision worth avoiding. "Lead agent" is no less established — it is Anthropic's own term for the equivalent role in their published multi-agent research system.

"Subagent" is the established term for the leaf-level agent that does the actual work, and is the term Claude Code itself uses for this role.

The middle tier has no single unique proper noun in the literature. "Supervisor of supervisors" is the formal name for the overall nested pattern, but the node itself is just a manager or supervisor agent scoped by a qualifier (here: per organization or tenant), not a distinct standalone word. Worth knowing that nuance rather than presenting a falsely tidy three-word set.

### Working model

**Nothing runs unsupervised at any layer — but the supervision mode is tiered, not uniform** (clarified 2026-08-17, refined 2026-08-18 with HITL/HOTL).

Paulo sits down with the Lead agent to plan and organize architecture and new projects: a consulting relationship, not a delegation one. For each project, a separate Subagent is created, directly oriented and supervised by Paulo at all times. It follows the Constitution (federal law) and can learn project-specific rules (state law); a rule that proves genuinely global gets promoted up into the Constitution itself, per the Amendment clause's 2+ independent companies bar.

**Supervision tier follows Proportionality's three Tiers directly, not a binary split**: Tier 1 runs human-on-the-loop throughout; Tier 2 runs human-on-the-loop with human-in-the-loop specifically for anything hard-to-reverse within it; Tier 3 runs human-in-the-loop throughout, no exceptions without a written, Paulo-approved one. All three are still supervised — this makes the existing claim precise and defensible rather than a single flat assertion.

**Paulo is the real top-level supervisor throughout.** The Lead agent is a consulting layer he works with, not a delegate that supervises other agents on his behalf.

The Lead agent's duties evolve continuously rather than being a one-time build: drafting system-build plans, defining standards, reviewing other agents' output, and pruning and organizing documentation to keep token spend down. That last duty is the Lead agent applying Pillar 5 (cost bounded by construction) to itself — a self-referential proof point worth keeping. The live config is `lead-agent.md`.

A Subagent watches its own repo for new commits and updates docs accordingly — a direct extension of Pillar 2's ground-truth practice (read the real commit, don't assume state).

### The org-level tier: a Manager agent per company

Added 2026-08-17, implementation corrected 2026-08-18. One instance per company, sitting between the Lead agent and each project's Subagent, holding that company's state law (derived from the Constitution, the same federal → state relationship `STANDARDS.md` already uses).

**Correction, 2026-08-18: it does not take custody of secrets.** Claude Code subagents share the parent session's shell and auth; there is no per-agent credential vault. Real tenant isolation is already two layers that predate this agent: cloud IAM and secret management, and workspace/directory separation (each company's own memory namespace and its own local settings). What the Manager agent adds is discipline and a registry — which secrets exist, their canonical names, which service account is scoped to what, and flagging any grant that drifts from `STANDARDS.md`. Not custody.

**Federal-conflict identification duty** (added 2026-08-18, `CONSTITUTION.md` commit `fc36843`): when Paulo activates a company's Manager agent — event-triggered by his own invocation, never a continuous background process — it checks whether a Constitution amendment since its last version-pointer creates a real operational conflict for that company, meaning something it genuinely cannot comply with, not a preference mismatch. Any conflict found is surfaced as a flagged exception request; the Manager never resolves it itself. Paulo is the sole approver of any Constitution exception. What is new here is naming *identification* (any tier can flag) as distinct from *approval* (Paulo only). Until a company has its own Manager agent, this check is the Lead agent's default responsibility.

**Why the org tier stays separate from the Lead agent rather than folded into it** — conclusion unchanged, reasoning corrected 2026-08-18. The original argument was multi-tenant credential-vault isolation (one identity should never touch multiple tenants' secrets). That premise does not hold for Claude Code, per the correction above. The conclusion survives on the reasoning that replaced it: **directory and workspace placement is the only real tenant-isolation mechanism Claude Code offers**, so a company-scoped agent has to live in that company's own repo, which a single user-level Lead agent by definition cannot do. Separation of concerns is the second reason — the Lead agent's job is architectural consultation, not holding one company's operational registry. The credential-vault version of this argument was superseded and should not be cited anywhere.

**Scope discipline**: only build a Manager agent for a company that concretely needs one, never pre-provisioned for hypothetical future clients. This is anti-accumulation (Pillar 4) plus the ADR rule of writing forward from a real decision rather than retroactively scaffolding for imagined ones. Exactly one company would qualify today, and its build is deliberately not queued.

### Authorship and drift-sync

Locked 2026-08-18, published as `lead-agent.md` duties 1-2 and `CONSTITUTION.md`'s Authorship and Sync visibility clauses.

**Authorship**: each tier drafts the initial config file for the tier directly below it, never skipping a level. The Lead agent drafts a Manager agent's initial config when one is designed; once a Manager exists, it drafts the initial config for a Subagent beneath it, the same way the Lead agent already drafts and reviews a `STANDARDS.md` one tier down.

**Drift-sync is lazy, not a cascade**: nothing proactively re-checks the whole hierarchy the moment the Constitution amends. A `STANDARDS.md`, Manager config, or Subagent config is checked against the tier above it only when it is next touched for some other reason (a consult, a review), backstopped by the self-assessment's own event-triggered cadence so nothing untouched drifts forever unnoticed.

This bounds token cost by construction — Pillar 5's own principle applied reflexively to the hierarchy's upkeep. **The asymmetry is in blast radius, not per-edit cost**: a federal (Constitution) amendment has the largest total downstream surface, since it can eventually touch every company's `STANDARDS.md` and every Subagent beneath each one; a state (`STANDARDS.md`) amendment is bounded to one company's own Manager and Subagents; a municipal (Subagent) change has zero downstream surface, since nothing sits below it. Editing any one file costs about the same regardless of tier.

### Skill-assignment flow (design intent, not a working mechanism)

Confirmed 2026-08-17. The Lead agent curates the master list of Constitution-approved Claude skills (federal — what is allowed at all); the Manager agent allocates the specific subset a given company's Subagents actually need (state — least-privilege scoping, the same shape as a service account scoped to exactly what a pipeline reads and writes); each Subagent operates with only what its Manager agent assigned.

Labelled design intent rather than a live mechanism because the implementation decision resolved that per-project Subagents need no formal config file today. Reopens once a Manager agent or a named Subagent actually exists.

### IssueOps as a future Subagent trigger

Noted 2026-08-17, an expansion rather than core. For well-defined, bounded processes only — for example, provisioning a storage bucket for a workload that currently runs manually with no cloud infrastructure — using GitHub Issues, labels, and comments as the trigger and approval interface. **IssueOps** is GitHub's own documented term for this, part of GitHub Agentic Workflows, and includes an **ApproveOps** variant for human-approval gates before automation proceeds, which maps directly onto HITL. Deliberately scoped to the Subagent tier only, never the Lead agent, which stays a live consulting relationship rather than a ticket queue. Not something to build now.

### Architecture research (2026-08-17)

Done to confirm this maps onto real, current multi-agent-system practice rather than being a novel invention.

**Anthropic's five named "Building Effective Agents" workflow patterns**: one is actually practiced today, a second is cited as a reference shape only, and the remaining three (prompt chaining, routing, parallelization) have no evidence here and are not claimed.

- **Evaluator-optimizer** — one agent generates a response, another evaluates and gives feedback in a loop. Names what the Lead agent's "reviews other agents' output" duty already does, reinforcing Pillar 2 and Pillar 4. **Actually practiced.**
- **Orchestrator-workers** — a central agent dynamically breaks down tasks, delegates to worker agents, and synthesizes results. **Cited as a reference shape only**, not a claim that real dynamic delegation happens: Paulo is the actual top-level supervisor, so no agent delegates unsupervised work to another agent today. Real costs to respect if this ever becomes real: roughly 15x the tokens of a single chat call, and 2-3 months of iteration before it stops over-spawning subagents for simple tasks.

**Single top-level orchestrator vs. hierarchical multi-supervisor**: clear at this scale. A single orchestrator gives a clean audit trail and lets one agent enforce scoped budgets with full context. Deeper hierarchy ("supervisor of supervisors") adds real coordination latency (6+ seconds before a worker even starts in a three-level chain), and centralized supervision alone runs roughly 285% more tokens than a single-agent baseline; 2026 papers show single-agent systems match or beat multi-agent ones at equal token budgets. Most production systems settle on one top-level agent. **Conclusion: one Lead agent, not several** — this is Proportionality applied to the hierarchy's own design. Revisit only on a concrete trigger, such as several fully independent client engagements needing separate standards at once, never speculatively. Since Paulo himself is the actual top-level supervisor rather than the Lead agent, this is more conservative than the single-agent baseline the research compared against, not merely equivalent to it.

**"Agent Constitution" is already a real, emerging term** in current agent-governance research (2025-2026), not invented here — described in the literature as a single governing document defining standards, checklists, known failure modes, and task-routing rules for specialized agents.

**Cost governance**: 2026 practice draws a real line between *alerts* (notify after spend happens) and *enforcement* (terminate or pause before the next call). Pillar 5's escalating-alerts commitment should lean toward enforcement, not just notification.

---

## Practice index: mechanism and governance

Mechanism and governance mappings only. The pillar-level practice-to-market-framework mappings live in `CONSTITUTION.md`'s own "maps to" lines and `REFERENCES.md`'s links; keeping a second copy of those here drifted stale and was cut 2026-08-18. What remains below has no public equivalent elsewhere, since the mechanism stays out of the Constitution by design.

| Practice | Real market practice(s) it maps to |
|---|---|
| Lead agent / Subagent naming | Anthropic's own "lead agent" term; "subagent" is Claude Code's own term |
| Lead agent reviews Subagent output | Anthropic's **Building Effective Agents**: Evaluator-optimizer pattern (Orchestrator-workers is the reference shape for Lead agent → Subagent, not actually practiced — no real delegation happens today) |
| Future Subagent trigger (IssueOps) | GitHub's own documented IssueOps / ApproveOps pattern |
| Manager agent kept separate per company | Multi-tenant AI-agent isolation practice, realized here as directory/workspace separation (not a per-agent credential vault, which Claude Code doesn't offer) |
| Review and Amendment | Anthropic's own Responsible Scaling Policy pattern |
| Self-assessment scorecard | GCP Well-Architected Framework Review pattern |
| Planned sibling doc — Usage Policy | EU AI Act disclosure requirement + B2B "trust center" publishing practice + LGPD client-data handling obligations |

### Anthropic's full practice catalog

Added 2026-08-17 for completeness, including where little or nothing is borrowed. Cataloguing is not claiming: an "unused" row is not a gap to feel behind on, it is awareness kept on file for when it becomes real.

| Publication | What it covers | Status here |
|---|---|---|
| **Building Effective Agents** (Dec 2024) | 5 named workflow patterns: prompt chaining, routing, parallelization, orchestrator-workers, evaluator-optimizer | 1 of 5 actually practiced (evaluator-optimizer); 1 more cited as a reference shape only, not yet real (orchestrator-workers); other 3 unused, no evidence |
| **How we built our multi-agent research system** (engineering blog) | Lead agent / subagent architecture, token-budget economics, coordination patterns | Used — the direct basis for the Lead agent / Subagent shape |
| **Claude Code: Best practices for agentic coding** (Apr 2025) | Research → plan → execute → review → ship, project memory files, human as the review gate at each step | **Adopted 2026-08-17** — formalized as the Subagent's own working pattern, with Paulo as the gate at each step |
| **The "think" tool** (Mar 2025) | Letting Claude pause and reason explicitly mid-task on complex tool use | Unused, no evidence |
| **Prompt caching** (official docs) | Cached-token pricing, roughly 90% cheaper reads | Adopted as a Pillar 5 commitment, status "in rollout" — not actually in use yet despite being native to an API already in use |
| **Model Context Protocol (MCP)** | Vendor-neutral open standard for connecting an AI system to external tools and data sources. Corrected 2026-08-18: no longer an Anthropic publication, donated to the Linux Foundation's Agentic AI Foundation on 2025-12-09 alongside `goose` and `AGENTS.md` | **Adopted 2026-08-17, a real Pillar 4 commitment since 2026-08-19.** Never built one yet, adopted forward as a real offerable capability, the same logic as the data-lineage commitment. A future Subagent connecting to a client's external tool or data source builds it via MCP by default, not a bespoke integration. The Linux Foundation donation strengthens the Choose Boring Technology case, since it is no longer a single vendor's protocol |
| **Introducing Contextual Retrieval** (Sep 2024) | A retrieval-augmented-generation technique for large document sets | Unused, and no evident fit — there is no large-corpus retrieval system here |
| **Claude's Constitution** (Jan 2026, CC public-domain licensed) | Anthropic's governing document for Claude's character and behavior — principles over instructions, priority order safe → ethical → policy-compliant → helpful | **Used as a structural model.** Two things borrowed: explain *why* each pillar exists rather than stating a bare rule, and define an explicit priority order for when principles conflict. The equivalent order here locked 2026-08-18: Security → Reliability → Governance & Transparency → Engineering Excellence → Financial |
| **Constitutional AI** (original research method) | A training method where the model critiques and revises its own output against written principles | Not used as content — the conceptual origin of "Constitution" as a governance term |
| **Responsible Scaling Policy** | Risk-tiered scaling framework; a named accountable role that approves exceptions and owns the amendment process | Used — the direct model for Review and Amendment |
| **Usage Policy** (Anthropic's own) | Rules for acceptable product use, enforcement approach | Direct precedent for the planned Usage Policy sibling document — same name, same function, one level down |
| **Transparency Hub** | Public reporting on trust and safety processes, enforcement data, security commitments | Precedent for the "trust center"-style page floated for the Usage Policy |

---

## Growth watchlist

The practice index also works in reverse: real, adjacent parts of the same frameworks not claimed yet, only because nothing in current practice proves them. Revisited on a concrete trigger, never on a calendar — the same rule the Constitution's own Amendment clause uses.

- **GCP Well-Architected's Performance Efficiency and Sustainability pillars** — excluded from the 5 pillars, no proof yet.
- **The unused rows of the Anthropic catalog above.**
- **Per-agent digital identity, audit trail, and a formal agent inventory** (Cloud Security Alliance / NIST agentic-governance guidance) — enterprise-scale, disproportionate at a one-person scale.
- **AI-agent harness and eval practices** (researched 2026-08-19 for Pillar 2): an explicit orchestration or state-machine layer constraining agent actions, multi-layer eval scoring the whole trace rather than only the final response, and a standing eval set run before prompt changes. Real, current 2026 practice, not adopted: there is no live multi-step agent loop here yet, only single-shot batch inference plus the consulting relationship the Constitution already says involves no real agent-to-agent delegation. Revisit once an actual multi-step agent loop becomes real infrastructure.
- **Dynamic or learned LLM model routing** (RouteLLM, semantic routers; researched 2026-08-19 for Pillar 5) — real, current practice, not adopted: the research itself names the break-even point at roughly 100k daily active users, far above current request volume. Static model tiering, already adopted, captures most of the same savings without the complexity. Revisit only if volume approaches that order of magnitude.
- **Policy-as-code for AI agent governance** (OPA/Rego, machine-readable policy checked at runtime before each agent action; researched 2026-08-19 for Review and Amendment) — real, current practice (Kyndryl, Microsoft, Altimetrik all publishing on it), not adopted: it solves for an autonomous multi-agent runtime enforcing rules without a human reading text first, which is not what exists here — the Lead agent reads `CONSTITUTION.md` as prose each session, and Paulo is the actual top-level supervisor, not a runtime gate. Same trigger as the harness item above.
- Add to this list as new "not yet, but real" gaps surface; don't let it go stale.

---

## Considered and deliberately rejected

Recorded rather than silently dropped, per Pillar 3's own rule that tradeoffs are written down.

- **LLM-as-a-Judge as a named verification method** (2026-08-18) — a category error under "verify against ground truth, don't infer." Replaced with deterministic checks.
- **A numeric test-coverage target** (2026-08-18) — a number optimized toward rather than a real quality signal.
- **General software metrics / DORA** (2026-08-18) — vanity metrics at a population of one.
- **Cyclomatic Complexity as a metric separate from the static-analysis clause** (2026-08-18) — already covered by the complexity ceiling enforced in CI, so a second named metric adds bookkeeping without adding signal.
- **Bundle size** (2026-08-18) — does not map to this stack; there is no bundler.
- **SQA as a separate formal practice** (2026-08-18) — the Constitution already is one, derived bottom-up.
- **ISO/IEC 42001 and NIST AI RMF as citations** (2026-08-18) — unearned-authority risk, not defensible unprompted at this scale. Kept on the Growth watchlist instead.
- **A minimal-code development persona as a Constitution citation** (2026-08-18) — killed on conflict-of-interest grounds by the Devil's Advocate pass: it was the reviewing session's own active persona proposing its own citation, backed by a non-independent, 9-week-old benchmark. It stays an environment-level tool, not Constitution text.
- **Pairing semantic versioning with calendar-based quarterly review** (2026-08-19) — a real market recommendation, rejected because it reintroduces exactly the calendar-driven upkeep debt the Amendment clause exists to avoid. The versioning scheme is a labeling convention only.

---

## Planned sibling document: Usage Policy

Confirmed 2026-08-17, still unwritten. Not a pillar and not part of the Constitution: a separate, client-facing document that packages relevant Constitution content (mostly Security and Governance) for an external audience.

Real market gap confirmed by research: most freelancers operate on an informal "ask forgiveness, not permission" basis around AI use, while clients actually prefer proactive disclosure, and the EU AI Act (in force since 2026-08-02) already requires disclosure mechanisms for some client-facing AI use.

Content: how AI is used in the work (batch inference, AI-assisted code, review process); what is always human-reviewed (everything); and how client data is handled when it touches an AI tool — with real legal grounding rather than a general statement, since **LGPD** (Brazil's data protection law) applies directly to a service provider handling client personal data, including its international-transfer provisions when clients are outside Brazil.

Likely lives as a lightweight "trust center"-style page rather than a separate site — 2026 practice is that publishing this kind of material publicly is replacing security questionnaires in B2B sales.

**Deliberately deferred** until the Constitution's own base is settled; writing it earlier means rewriting it once the base changes again.

---

## Construction history

### Phase plan (2026-08-17, supersedes an earlier 6-phase plan)

1. **Extract practices — done.** Ten categories derived from real, provable facts. Expanded 2026-08-17 from 8 to 10 after a dedicated re-review against the real source, which found two previously-missed categories (database/data-layer standards, and eliminating tribal knowledge through zero-hidden-context documentation) plus a new proof point for category 1 (IAM-scoping changes verified via impersonation testing before being applied).
2. **Broaden research per category — done for all 10.** Categories 1-8 completed 2026-08-17 (including ADRs for category 7 and risk/criticality tiering for category 8); categories 9 and 10 were researched the same day they were discovered, finding table and partition expiration, column and row-level security, and data-lineage gaps for 9, and postmortem consolidation plus a periodic zero-context test for 10.
3. **Decide, category by category, which gap practices become real commitments — done.** All 19 gap items across categories 1-7 adopted 2026-08-18 (18 from the pillar walkthrough plus a kill switch closed separately); the 6 remaining items across categories 8, 9, and 10 adopted 2026-08-17. Zero open gap items remain.
4. **Draft the Constitution — done 2026-08-17/18.** Preamble, priority order for pillar conflicts, all 5 pillars (why → what it requires of a new `STANDARDS.md` → precedent → dated commitments → market references), Proportionality, and Review and Amendment including the self-assessment scorecard.
5. **Technical implementation decision for the three tiers — definitional work complete.**
   - **Lead agent: decided and built 2026-08-18.** A real Claude Code subagent, user-level so it is available across every workspace (matching the "one Lead agent, not several" conclusion), reading `CONSTITUTION.md` fresh each session rather than embedding a copy, with no Agent tool by design.
   - **Manager agent: design locked 2026-08-18, build deliberately not queued.** Decided as a project-level subagent versioned inside its own company's repo, never user-level — directory placement is the only real tenant-isolation mechanism available, so user-level would recreate the exact cross-tenant blur the org tier exists to avoid. The actual file gets built when the company that needs it is actually being worked on.
   - **Per-project Subagent: resolved, no formal file needed.** A project's own memory file plus its local settings already deliver what a dedicated agent config would buy (scoped context, scoped tools, name-based invocation), and none of those three have real use while nothing delegates to a Subagent by name. Tested against the most complex real case and it still did not need one. **Reopen trigger, written down per Pillar 3's own rule**: a project needing tool scope different from its session's default, or something other than Paulo needing to invoke it by name.
Phases beyond the método's own technical definition — distilling a public-facing layer, rewriting personal materials against it, publish cadence — are personal-branding work, not método construction, and are tracked outside this document.

### Templates for the lower tiers (2026-08-19)

`templates/manager-agent.template.md` and `templates/subagent.template.md` — company-agnostic and project-agnostic patterns to instantiate from, not live agents. Closes the gap between design intent and an actual file existing.

The Manager template mirrors `lead-agent.md`'s consulting-only shape (same PreToolUse hook class, no Agent tool, `sonnet` rather than `opus` per the static model tiering commitment), since its boundary is fixed and identical regardless of company. The Subagent template is structurally different, because it is the one tier that actually executes: tool scope and any technical execution gate are left for instantiation time, driven by that project's own Proportionality Tier, never copied from Lead or Manager.

Both operationalize the authorship rule and the tenant-isolation reasoning above — the hook script is copied into each company's own repo at instantiation, never referenced across repos. Published as commit `e728016`, tagged `v2.1.2`.

### Decision and review log

- **2026-08-16** — the document's name locked as "Constitution."
- **2026-08-17** — bottom-up derivation method locked; ten categories extracted and researched; three-tier hierarchy terminology locked, with the top tier renamed Orchestrator → Lead agent the same day; companion philosophies locked; Usage Policy scoped as a sibling document; Review and Amendment confirmed, modeled on Anthropic's Responsible Scaling Policy, with the self-assessment scorecard modeled on GCP's Well-Architected Framework Review.
- **2026-08-18** — the Constitution drafted, published, and tagged `v1.0`; the agent hierarchy made public for the first time; the pillar priority order stress-tested against real conflict scenarios and locked (deliberately fixed rather than variable per client, since `STANDARDS.md` plus Proportionality already handle company-specific adaptation); the Manager agent's secret-custody premise corrected; four mechanism gaps closed (authorship rule, drift-sync plus sync visibility, a concrete 2+-companies promotion bar replacing the undefined "genuinely global," and exception identification split from approval), commits `fe017f5`, `432c4b1`, `fc36843`.
- **2026-08-18, reframe** — the Constitution's audience was redirected to the agent hierarchy that actually reads and enforces it, rather than an external reader. Every precedent block across all 5 pillars and Proportionality was genericized (no client, company, or repo names; no identifying dates or metrics; technical substance kept), the heading "Real proof this is already practiced, not aspirational" was renamed "Precedent" throughout since there is no skeptical reader left to preempt, and the document's own reference to an external marketing layer was removed. Commits `c4dfb14`, `8660e5e`.
- **2026-08-18, citation audit** — found and fixed a broken Safe Interruptibility link pointing to the wrong 2017 paper, a discontinued product name, a CIS v8 vs v8.1 mismatch, an overstated kill-switch regulatory claim, and an outdated LGPD citation; upgraded several vendor-blog sources to founding papers or standards bodies. `REFERENCES.md` was separately rebuilt to contain only what the Constitution's pillars cite by name, organized per pillar — it had originally been copied wholesale from private notes and included research the Constitution never cites.
- **2026-08-18, quality-practice research applied** — SHA-pinned CI actions and hash-locked dependencies (Pillar 1, also added to the Proportionality Floor for secret-scanning specifically); an eval-harness-integrity rule, no agent edits the test that judges its own output (Pillar 3); data-quality assertions extending silent-failure detection from "did it run" to "did it write correct data" (Pillar 3); static analysis with a security ruleset and a cyclomatic-complexity ceiling in CI (Pillar 4); a de-named data-lineage commitment, since the vendor tool involved renamed itself twice in six months, so `STANDARDS.md` names it rather than the Constitution.
- **2026-08-18, Devil's Advocate practice adopted** — a real anti-sycophancy mechanism, added after research passes were landing too agreeable. Piloted live on the full amendment batch before any of it was written, and the pilot found a real self-contradiction in the practice's own first draft (a mandatory same-family review paired with only an optional cross-family check, when escaping same-family bias was the entire point). What shipped: any externally-sourced claim has its source opened and confirmed before publish — this, not adversarial role-play, is what caught the broken citation above — plus a cross-family model check for anything publicly visible.
- **2026-08-18, language audit** — confirmed every public file reads in English. One real leftover found and translated: the "Revisão e Emenda" section name. Everything else non-ASCII was either an em dash or a proper noun kept in its original language on purpose.
- **2026-08-19, structured pillar-by-pillar review, `v2.0.0`** — a conversational walkthrough of the whole document, one topic at a time, each followed by a targeted market-practice search whose findings were proportionality-filtered before anything was proposed. Published: pillars renumbered to match the priority order (Security 1 / Reliability 2 / Governance & Transparency 3 / Engineering Excellence 4 / Financial 5, previously 1/3/5/4/2) with every cross-reference fixed; an explicit secret-scanning-at-push-boundary commitment in Pillar 1; hardcoded operational numbers (alert thresholds, rotation cadence) removed from three places and deferred to each company's `STANDARDS.md`, with the Graduation rule strengthened so an abstract deferral cannot quietly count as done; a Circuit Breaker commitment and a lightweight per-pipeline SLO and error budget in Pillar 2; an EU AI Act Article 50 disclosure flag and a blameless-postmortem qualifier in Pillar 3; spec-driven development, an AI-generated-diff size cap, and mutation testing for AI-generated tests in Pillar 4; a cost-per-completed-task unit and static model tiering in Pillar 5; CIS Controls' Implementation Groups adopted as Proportionality's primary citation, replacing FAIR-CAM as the lead reference; and Review and Amendment gaining a formal Practice-gap research process plus semantic versioning for the Constitution's own tags.
- **2026-08-19, general coherence pass and agent duties review, `v2.1.2`** — a holistic structure-and-contradiction pass over `CONSTITUTION.md` plus a mapping-clarity pass over `REFERENCES.md`, deliberately sequenced *before* reviewing the agent configs, since the agents depend on the Constitution's text and should be checked against its best version rather than its first-pass-amended one. Then the agent review itself: `lead-agent.md` got three real fixes (a stale cross-reference after Sync visibility was promoted to its own bullet, no duty flagged when the cross-family verification check was due, and `description` frontmatter not naming self-assessment or practice-gap research as invocation triggers), plus a new PreToolUse hook (`hooks/block-risky-ops.sh`) enforcing its "never touches production or credentials" boundary technically rather than by prompt discipline. The hook was tested live via a real subagent invocation, which itself caught a stale version-pointer and a genuine gap in the hook's own credential-file regex. The cross-family check was downgraded from mandatory to opportunistic mid-session, since reliable ongoing access to a second model family is not realistic here and a rule never once met is worse bookkeeping than an honest, scaled-down one — Paulo's own required review remains the real safeguard.
- **2026-08-19, final review, `v2.2.0`** — narrowed an OWASP citation, added the Authorship rule to the Constitution itself, and closed stale caveats. Commit `de23acd`.
- **2026-08-22, open question flagged, `v2.3.0`** — Pillar 1's exposure rules cover a credential reaching a commit or push, not one dictated as plaintext into an AI chat session to have an agent act on it (e.g. "set this as a Cloud Run secret"), which leaves the value sitting in that session's transcript. Surfaced while reasoning through a real "can an AI administer credentials" question; not resolved, just written down as open per Pillar 3's own rule against silently assuming a gap decided. Commit `f993f1c`.

### Known open items

- **No demo repo yet demonstrates this Constitution's mechanism** — no public `STANDARDS.md`, no CI, ADR, or dependency scan in any published example. Real repo work rather than a text fix.
- **One real CI workflow** (static analysis, secret scanning, SHA pinning, lockfile checks) is designed and unblocked but not built.
- **This repo's own GitHub description is empty** — cosmetic, a one-line fix whenever the repo is next touched.
- **Migrating the existing client work up to this Constitution's standard is a distinct, deliberately unscheduled project.** Every precedent cited in `CONSTITUTION.md` is real and already happened, but the commitments marked "adopted, in rollout" define the target standard, not a description of any existing system's current state. Real gaps remain there. "Adopted, in rollout" must never be read as "already true everywhere."
- **That company's existing `STANDARDS.md` does not yet carry the one-line version pointer** the Sync visibility rule now requires — it gets added when that migration happens, not before.

---

## Sources behind these notes

Sources the Constitution's own pillars cite live in `REFERENCES.md`, organized per pillar. What follows is the research that informed *how this document set is structured*, which is not cited by any pillar and therefore does not belong there.

**AI-agent governance document structure** (researched 2026-08-18, informed the functional/agent-governance reframe):

- [Best Practices for AI Agent Implementations: Enterprise Guide 2026](https://onereach.ai/blog/best-practices-for-ai-agent-implementations/)
- [AGENTS.md Complete Guide for Engineering Teams (2026)](https://blog.buildbetter.ai/agents-md-complete-guide-for-engineering-teams-in-2026/) — a length ceiling of roughly 200-500 lines, growing only when an agent demonstrably errs; negative-example framing more effective than aspirational statements; imperative language
- [Why your 2026 IT strategy needs an agentic constitution | CIO](https://www.cio.com/article/4118138/why-your-2026-it-strategy-needs-an-agentic-constitution.html) — a 3-tier autonomy model (full / supervised / human-only). "Nothing ships unsupervised" is deliberately stricter than this baseline, with no true full-autonomy tier
- [Agentic AI Governance: NIST Standards for Autonomous Systems](https://labs.cloudsecurityalliance.org/wp-content/uploads/2026/03/governance-nist-ai-agent-standards-agentic-governance-v1-csa-styled.pdf) — per-agent digital identity, audit trail, formal agent inventory; on the Growth watchlist, not adopted
- [The Instruction Gap: LLMs get lost in Following Instruction](https://arxiv.org/html/2601.03269v1)
- [Analyzing and Internalizing Complex Policy Documents for LLM Agents](https://arxiv.org/html/2510.11588) — concrete scenarios outperform abstract specifications alone, but examples alone risk surface pattern-matching over genuine rule understanding; keep both the abstract rule and a concrete precedent, never precedent alone
- [Best Practices for Agent System Prompts](https://docs.treasure.ai/products/customer-data-platform/ai-agent-foundry/ai-agent/system-prompt-best-practices) — an instruction hierarchy for conflicts (validating the Priority order), and escape hatches so agents admit ignorance rather than fabricate (adopted into Pillar 3, 2026-08-18)
- [Writing System Prompts for AI Agents: Best Practices for 2026 | Runyard](https://runyard.io/blog/ai-agent-system-prompts-guide)
