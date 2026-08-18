# The Constitution

*Governs Paulo Cremasco's own work. Published here in full since 2026-08-18; the public marketing layer (portfolio, resume, LinkedIn) carries only distilled, proof-anchored pieces of it, through a separate process. The mechanism that enforces this document (the agent hierarchy) is a technical/implementation layer, so it sits beside this document in `lead-agent.md` rather than inside it, per the philosophy/principles/mechanism separation this document is built on.*

## Preamble

Paulo works from one belief: **one person, with the right machinery, can do it all himself — and nothing ships unsupervised.** Every pillar in this document is a different facet of that belief made concrete and checkable. It applies at every scale this practice ever reaches — a future automated subagent still goes through review before anything it produces ships, the same as everything does today.

This Constitution states the principles that follow from that belief: why each one exists, and what it requires going forward. It was not written from an external framework downward — every pillar below was derived bottom-up from real, provable practice, then cross-checked against established market frameworks to confirm the practice already had a name. Where market research led to a new commitment, it's dated and marked "adopted, in rollout" — a real commitment starting from that date, not a retroactive claim about the past.

Structurally, this document borrows from Anthropic's own Claude's Constitution (2026): principles are explained, not just stated, and a priority order exists for when they conflict — because a constitution that only lists rules can't be reasoned from when a real situation doesn't fit any rule exactly.

**Four philosophies sit behind these principles**, each a real, established school of thought rather than something invented for this document: **agentic engineering** (a human directs and reviews AI agent output — governance, architecture, and security stay owned by the person, never the agent); **Choose Boring Technology** (Dan McKinley — spend novelty budget only where it truly matters, especially now that AI can suggest unfamiliar tools with no way to verify they're sound); **human-in-the-loop / human-on-the-loop** (approval before high-risk action, monitoring for everything else — the precise, tiered version of "nothing ships unsupervised"); and **You Build It, You Run It** (Werner Vogels, Amazon, 2006 — whoever builds a system also operates it, no handoff to someone else). This is a canonical summary, not the full reasoning behind each — that reasoning evolves in Paulo's own working notes and reaches this document only when it's settled enough to state as a standing principle, through the amendment process this Constitution defines for itself.

**A note on scope**: the pillars below are written to stand on their own — proof and commitments, no internal jargon, no mechanism detail — which is what makes publishing this document in full possible. What stays private regardless is anything that would break a confidentiality boundary (client names, proprietary data).

## Priority order

*Anthropic's own Constitution orders Claude's priorities safe → ethical → policy-compliant → helpful. This is the equivalent order for these 5 pillars — stress-tested against real conflict scenarios and locked 2026-08-18.*

**Security → Reliability → Governance & Transparency → Engineering Excellence → Financial**

Reasoning for this order:
- **Security first**: the whole branding thesis ("nothing ships unsupervised") and Zero Trust both fail if security is compromised even once — nothing downstream matters if this breaks.
- **Reliability second**: a system that doesn't work reliably fails its basic purpose, ahead of how well-documented or clean it is.
- **Governance & Transparency third**: when reliability or security is imperfect, the rule is to disclose it, never hide it — this pillar governs how failures in the pillars above get handled, so it sits above the two "quality" pillars below it. It isn't purely competitive with the others the way Security and Reliability are — the same disclosure rule applies regardless of which pillar's gap is in question, a cross-cutting role closer to Proportionality's — but it carries enough substantive content of its own (ADRs, System Cards, documentation standards) to stay a full pillar rather than fold into Proportionality.
- **Engineering Excellence fourth**: verification and anti-accumulation discipline matter, but can flex under real constraint (do the minimum necessary verification, not none) in a way security and reliability can't.
- **Financial last, not least**: cost is real and bounded by construction, but the one pillar that's acceptable to spend more against if the alternative is a security or reliability failure.

**Locked 2026-08-18.** Changes only through Review and Amendment below, never silently.

---

## Pillar 1: Security

**Why this pillar exists**: A system that leaks access or credentials fails silently until it doesn't — the cost of a security failure compounds with time undetected, unlike most other failure types. Security is placed first in the priority order for the same reason.

### Practice: Exposure & access discipline

**What this requires of any new project's `STANDARDS.md`**: one scoped runtime service account per pipeline, never mixed with the deploy identity; access narrowed to the resource level actually used, confirmed by reading the code, not assumed; any public-vs-private exposure decision documented in-repo before it ships; any IAM or permission change tested via temporary impersonation before it's made permanent; any project handling personal data gets an explicit data-handling note covering what's collected, why, how long, and the legal basis for any cross-border transfer.

**Real proof this is already practiced, not aspirational**:
- One scoped runtime SA per pipeline at ChannelFront, never mixed with the deploy identity.
- BigQuery IAM narrowed to table-level after confirming real read/write usage via code grep, not guesswork.
- A public-vs-private exposure decision for `channelfront-ops-dashboard` documented in-repo so it can't be silently "hardened back" without the reasoning being visible.
- An accounts/IAM page paused specifically because it would leak security posture on a now-public dashboard.
- `rgg-automation`'s access was narrowed from dataset-wide `WRITER` to table-scoped, tested via temporary self-impersonation before the change was made permanent, then the test grant reverted.

**Commitments, adopted 2026-08-18 unless noted, status "in rollout"**:
- Escalating budget alerts (50/75/90% of budget, plus a hard cap) — leaning toward enforcement, not just notification.
- Per-app API key isolation.
- IAM Recommender run as an actual periodic check, not a stated intention.
- Sensitive IAM data never ships on a public surface without a gate.
- **LGPD-aware data handling** (adopted 2026-08-17) — any project touching personal data gets the data-handling note described above; grounded in Brazil's data protection law, which applies to him directly as a service provider handling client personal data, including its cross-border transfer rules.

**Real market practices this maps to**: **Zero Trust** ("never trust, always verify"); Google Cloud's own documented method for testing permission changes via service-account impersonation; AWS Well-Architected's **SEC03-BP04** ("reduce permissions continuously"); Brazil's **LGPD** (Lei Geral de Proteção de Dados).

---

## Pillar 2: Financial

**Why this pillar exists**: AI-driven work has a failure mode traditional software mostly doesn't — an agentic loop or an unbounded batch job can spend money indefinitely if nothing bounds it by design. Cost needs to be bounded **by construction**, the architecture itself makes the failure impossible or capped, not just caught after the fact on a monthly bill. This is also the most flexible pillar in the priority order above: worth spending more against, deliberately, if the alternative is a security or reliability failure — but that flexibility only holds because the baseline discipline below already exists and isn't itself the thing failing.

**What this requires of any new project's `STANDARDS.md`**: any AI work runs through a bounded-cost interface (a batch API, not an open-ended interactive loop) unless a specific, reviewed exception is documented; escalating budget alerts configured before a new agent or pipeline ships, not after; a real cost projection done before a new agent ships, not discovered from the first bill; prompt/response caching used by default wherever the underlying API supports it.

**Real proof this is already practiced, not aspirational**:
- AI work at ChannelFront (the product enricher) runs via OpenAI's Batch API — inherently bounded-cost, never an open-ended interactive agent loop.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- Escalating budget alerts (same structure as Pillar 1: 50/75/90% of budget plus a hard cap), leaning toward enforcement — stopping the next call, not just notifying after the spend already happened.
- A real cost projection required before any new agent ships.
- Prompt/response caching used by default — Anthropic's own **Prompt Caching** feature, cache-read tokens priced roughly 90% below base input-token rates, currently unused anywhere despite being native to the exact API already in use.

**Real market practices this maps to**: Anthropic's own officially named **Prompt Caching** feature; the 2026 cost-governance distinction between *alerts* (notify after spend happens) and *enforcement* (pause or terminate before the next call happens) — this pillar leans toward enforcement specifically, since an alert alone doesn't bound anything by construction, it only reports it after the fact.

---

## Pillar 3: Reliability

**Why this pillar exists**: a system that doesn't work reliably fails its basic purpose, ahead of how well-documented or well-verified it is elsewhere — this is why it sits second in the priority order, right after Security. It has two practices: designing so any real failure is cheap when it happens, and never trusting an inferred state over checking the real one — together they mean incidents get contained and caught quickly, not silent or catastrophic.

### Practice: Design for cheap failure

**What this requires of any new project's `STANDARDS.md`**: independent, overlapping fixes for any real failure mode, never a single layer of defense; idempotent operations wherever a retry is possible, so a failure costs a retry, not lost or duplicated data; a kill switch that halts any agent immediately without a new deployment; the same concurrency/retry discipline extended to AI agent tool-calling loops, not just traditional pipeline code; blast-radius-scoped chaos testing before trusting any resilience claim.

**Real proof this is already practiced, not aspirational**:
- The 2026-08-09 rate-limit incident: root cause was a Rithum account limit silently shared across 3 pipelines, invisible to each pipeline's own semaphore — a single external vendor's undisclosed shared limit, not a bug in his own code.
- Fixed in two independent layers — retry-on-429 plus schedule retiming, not just one.
- Idempotent cursor design (`MAX(id_item)` in BigQuery) meant the incident cost a retry, not lost data.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- Concurrency/retry discipline extended to AI agent tool-calling loops.
- An incident runbook turning root-cause write-ups into reusable "when X breaks, do Y" references.
- Chaos engineering — blast-radius-scoped proactive failure injection, starting small, expanding only after safety controls are confirmed.
- A kill switch — any agent halted immediately, no new deployment needed.

**Real market practices this maps to**: **Defense in Depth**; **Chaos Engineering**; kill switch → **Safe Interruptibility** (Orseau & Armstrong, DeepMind/Oxford, 2016) + **Corrigibility** — now also a regulatory requirement (EU AI Act, California SB-1047, 2024 Seoul AI Safety Summit); third-party/vendor dependency risk management (the Rithum incident is the direct proof of this).

### Practice: Verify against ground truth, don't infer

**What this requires of any new project's `STANDARDS.md`**: any status or state claim is read from the real, authoritative source — an API, a live log, actual system state — never inferred from a proxy that could be wrong; AI output gets the same verification rigor as any other output before it's trusted; dependency vulnerabilities get scanned automatically, never assumed absent; CI must actually gate deploys on passing tests, not just have tests that exist somewhere.

**Real proof this is already practiced, not aspirational**:
- The ops dashboard's data model was rebuilt after inferring job status from log-text presence caused two real bugs — a job with zero log rows vanished, and different pipelines log different success text.
- The docs-compliance audit greps actual section headers instead of trusting memory.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- The same ground-truth discipline applied to AI output — a verification step for the enricher's batch results, equivalent in spirit to the byte-identical check used for the 18.2x port.
- Automated dependency-vulnerability scanning.
- Confirming CI actually gates deploys on passing tests, not just that tests exist.

**Real market practices this maps to**: **Software Composition Analysis (SCA)**, the same practice behind a Software Bill of Materials (SBOM) — the traditional-software parallel to the Light AI-BOM adopted under Pillar 5; **Shift Left** (catch problems as early in the lifecycle as possible).

---

## Pillar 4: Engineering Excellence

**Why this pillar exists**: this is the discipline that keeps a system correct and maintainable over time, not just working today — verifying a change before and after it ships, refusing to let complexity or debt accumulate silently, and applying that same rigor to the data layer specifically, since data outlives any one pipeline that touches it. Fourth in the priority order: this pillar can flex under real constraint (doing the minimum verification actually necessary, not none) in a way Security and Reliability can't.

### Practice: Verify before shipping, revert without drama when it doesn't generalize

**What this requires of any new project's `STANDARDS.md`**: a real, measured verification step before any optimization or port replaces an existing method — never assumed equivalent; a tested rollback path before anything ships that could need one; extra scrutiny for any AI-suggested library, pattern, or API that isn't already proven in this environment, treated as needing verification, not baseline trust; a caveat documented and kept, not hidden, when a technique that worked once doesn't generalize elsewhere.

**Real proof this is already practiced, not aspirational**:
- The 18.2x concurrent-fetch port was verified byte-identical against the old method before switching.
- The same technique tried on a different pipeline made it 1.6-2.8x slower — reverted cleanly, and documented as a real caveat rather than hidden.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- A tested, verified rollback path as a standing rule: a ported optimization needs an equivalent verification step before it replaces the old method.
- Extra verification for AI-suggested unfamiliar tools before they're treated as trustworthy.

**Real market practices this maps to**: **Choose Boring Technology** (Dan McKinley); **Shift Left**.

### Practice: Anti-accumulation

**What this requires of any new project's `STANDARDS.md`**: status reporting that fits in one line by design, so "is this done yet" never requires touching more than one place; no new document created unless it earns its keep over what already exists — deleted the moment it just duplicates something else; a one-off setup mistake turned into a checklist so it can't recur on the next project; a defined rotation cadence for credentials, so a secret never becomes silent debt.

**Real proof this is already practiced, not aspirational**:
- Repo status fits one line by design across ChannelFront's repos.
- Two org-level "overview" docs were built and then deleted once they proved to just duplicate content and cost upkeep without paying for itself.
- A one-off CI setup bug was turned into a checklist so it can't recur on the next repo.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- A defined secret-rotation cadence — privileged/service credentials (production or infra access) rotate at least every 90 days, 30 days for broad-access credentials.

**Real market practices this maps to**: **Toil Reduction** (Google SRE); **NIST SP 800-57** + CIS Controls v8 (note: this is the standard for *privileged/service* credentials specifically — NIST's separate, newer guidance against forced rotation applies only to memorized user passwords, a different category).

### Practice: Database / data-layer standards

**What this requires of any new project's `STANDARDS.md`**: BigQuery (or equivalent) IAM scoped at dataset level for broad access, table level when a project's reads and writes target different tables; datasets separated by concern, never mixed; partitioned tables by default, never date-sharded, so storage growth is bounded by construction the same way cost is under Pillar 2; a table/partition expiration policy so old data ages out on purpose; column- or row-level security on any table carrying customer data; a real backup and disaster-recovery plan for anything that can't simply be regenerated.

**Real proof this is already practiced, not aspirational**:
- `STANDARDS.md` already codifies the BigQuery IAM pattern above for any new ChannelFront pipeline.
- Datasets separated by concern and never mixed (`luxlair` = pipeline data, `ops` = log sink, `billing` = billing export).
- Partitioned tables mandated over date-sharded for the logging sink specifically, to bound table growth by construction.
- BigQuery clustering documented as an invariant in `products-extraction`'s own README Rules section.

**Commitments, adopted 2026-08-17, status "in rollout"**:
- Table/partition expiration policy.
- Column/row-level security for tables carrying customer data (e.g. `luxlair.orders`).
- Data lineage via Data Catalog/Dataplex — adopted deliberately even though it was flagged as likely disproportionate at his current one-person scale.
- Backup and disaster recovery (BDR) — restoring mission-essential data within a bounded time, not left to chance.

**Real market practices this maps to**: GCP's own BigQuery IAM and partitioning guidance; **NIST SP 800-34** (contingency planning — mission-essential functions restored within 12 hours, fully restored within 30 days) and the modern **3-2-1-1-0** backup practice.

---

## Pillar 5: Governance & Transparency

**Why this pillar exists**: this pillar governs how failures, tradeoffs, and gaps in every other pillar get handled — the rule is always disclose, never hide, and never let critical knowledge live only in one person's head. Third in the priority order, right after Security and Reliability: a technical shortcut is forgivable if it's disclosed, not if it's hidden. It's also the direct accounting mechanism behind the whole "nothing ships unsupervised" thesis — since a person, not a system, is ultimately accountable for every decision, that accounting has to be written down and accessible without that person in the room.

### Practice: Tradeoffs written down, never silent

**What this requires of any new project's `STANDARDS.md`**: any hard-to-reverse or cross-team decision gets a written ADR before or immediately after the fact, never only remembered; any deployed AI-involving system gets a System Card documenting the model, the review/oversight mechanism, and known limitations; any project using AI discloses, in one line, which model/version, whether it's fine-tuned (never, here), and which APIs/infra the AI touches; an open question stays written down as open, never quietly assumed resolved; when it's unclear whether a Constitution rule applies, or the information needed to decide is missing, that gap is stated explicitly and flagged for a decision, never silently assumed or fabricated.

**Real proof this is already practiced, not aspirational**:
- Reusing a broad-scope personal token as a CI fix was a conscious, asked-first decision, with the properly-scoped fix named as a real follow-up — not hidden.
- The AI enricher's lack of automation is documented as an open, undecided question rather than quietly assumed fine.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- **ADR (Architecture Decision Record)** — root-cause write-ups already function as informal ADRs; formalized as one ADR per hard-to-reverse or cross-team decision, stored in `docs/adr/`, written forward from now rather than retroactively.
- **System Card per project** — documents the deployed system: model, review/oversight mechanism, limitations.
- **Light AI-BOM** — one line per project disclosing model/version, no fine-tuning, and which APIs/infra the AI touches.

**Real market practices this maps to**: **ADR** (adr.github.io, AWS Architecture Blog); **System Cards**; **AI-BOM** — an informal parallel to the SBOM/SCA already cited under Pillar 3.

### Practice: Eliminate tribal knowledge

**What this requires of any new project's `STANDARDS.md`**: documentation complete enough that someone — or an AI — with zero prior context can understand the whole project by reading only the docs, no hidden context required; postmortems consolidated in one discoverable location, never scattered; a periodic zero-context test that actually verifies this empirically instead of assuming it.

**Real proof this is already practiced, not aspirational**:
- The 2026-08-06 governance clarification: "AI driven" does not mean removing human code review — it means the docs must stand on their own, with no hidden context needed to understand the business.

**Commitments, adopted 2026-08-17, status "in rollout"**:
- Postmortems consolidated into `docs/postmortems/`, alongside `docs/adr/`.
- A periodic zero-context test.

**Real market practices this maps to**: bus factor reduction / documentation as the single source of truth; also his real, named answer to **"key person risk"** (the sole-practitioner succession-planning term) — no separate commitment needed for that beyond the two above, the zero-context-test discipline already is the mitigation.

---

## Proportionality — a cross-cutting interpretive principle, not a sixth pillar

**Why this exists, and why it isn't a pillar**: none of the 5 pillars above are meant to apply with identical weight to every project regardless of size or risk — a principle applied that rigidly gets ignored under real constraint, or demands disproportionate overhead from something small enough not to need it. Proportionality is the rule for how hard each pillar's controls get applied to a given project, not a sixth substantive article beside them — the same way a real constitution has interpretive clauses about how the document itself should be read, distinct from its substantive articles.

**What this requires of any new project's `STANDARDS.md`**: every project gets classified by consequence-of-failure and reversibility before deciding which subset of the 5 pillars' controls actually apply to it. A project with no cloud infrastructure and no scaling lever doesn't need an escalating-autoscale-alert practice, for instance — pretending it does wastes effort without reducing any real risk.

**Real proof this is already practiced, not aspirational**:
- `channelfront-image-enricher` and `luxlair-ai-product-enricher` are manual-only, no cloud infrastructure at all — a practice like escalating autoscale alerts simply doesn't map onto something with no scaling lever to escalate to.

**Commitment, adopted 2026-08-17, status "in rollout"**:
- A **risk/criticality tiering method**: classify each project by consequence-of-failure and reversibility, then apply only the tier-appropriate subset of the 5 pillars' controls. Turns proportionality from a per-case judgment call into a repeatable rule — and is the concrete mechanism behind the HITL/HOTL supervision tiering this Constitution's enforcement already uses in practice.

**Real market practices this maps to**: proportionality as a named principle in security engineering (control depth should match risk exposure and system size, not be applied identically everywhere); the **FAIR Institute**'s risk-based technology controls framework.

---

## Review and Amendment — who enforces this, and how it changes

**Why this exists**: a constitution that can't be checked against reality, or amended when it's wrong, is either quietly ignored or followed past the point it still makes sense. This section names who is accountable, how compliance actually gets checked instead of assumed, and how the document itself is allowed to change.

**Modeled on Anthropic's own Responsible Scaling Policy**: a named, accountable role approves exceptions, reviews decisions against the policy, and owns both non-compliance handling and framework updates. For this Constitution, Paulo holds that role, formally — the same logic as "nothing ships unsupervised," applied to the document that defines what supervision means.

**What this requires**:
- **Exceptions**: any exception to a Constitution rule, when a real tradeoff demands one, is approved by Paulo explicitly and written down — never silently taken (Pillar 5).
- **Amendment**: this Constitution changes only on a real, concrete event — a new practice proven, a gap found, a decision that no longer holds — never on a calendar schedule. The lesson behind this is real: two ChannelFront "org overview" documents were built and deleted for costing upkeep without paying for themselves; a document that updates on a schedule accumulates exactly that kind of debt.
- **Self-assessment**: a short, honest check that the Constitution is actually being followed, not assumed to be — run on the same event-triggered cadence as amendment (a new project, an incident, or a stretch of time where nothing got checked), never calendar-based. Modeled on GCP's own Well-Architected Framework Review: one short question per pillar, scaled down to one person instead of an enterprise team.
  - **Security** — can I point to a real, current proof of least-privilege/impersonation-testing on the last project touched?
  - **Financial** — is there an actual configured budget alert, not just a stated intention?
  - **Reliability** — does the last incident have a written root cause plus two independent fixes, not one?
  - **Engineering Excellence** — was the last shipped change verified before going out, with a real rollback path?
  - **Governance & Transparency** — does the last hard-to-reverse decision have an ADR?

  Answered honestly against real evidence each time, not assumed — a "no" is the point of running it, not a failure to hide.

**Real market practices this maps to**: Anthropic's own **Responsible Scaling Policy**; GCP's own **Well-Architected Framework Review**.
