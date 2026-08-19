# The Constitution

*Governs how Paulo Cremasco's own work gets built and run: security, cost, reliability, engineering standards, and how tradeoffs get disclosed. Published here in full since 2026-08-18. The mechanism that enforces this document (the agent hierarchy: Lead agent / Manager agent / Subagent) is a technical/implementation layer, so it sits outside this document rather than inside it, per the philosophy/principles/mechanism separation this document is built on. Today only the top tier has a live config, published alongside this file as `lead-agent.md`; the Manager and Subagent tiers are design intent only, not yet formalized as their own files.*

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
- **Security first**: a security failure compounds silently with time undetected, and Zero Trust's core premise ("never trust, always verify") breaks the moment it's compromised even once — nothing downstream matters if this fails.
- **Reliability second**: a system that doesn't work reliably fails its basic purpose, ahead of how well-documented or clean it is.
- **Governance & Transparency third**: when reliability or security is imperfect, the rule is to disclose it, never hide it — this pillar governs how failures in the pillars above get handled, so it sits above the two "quality" pillars below it. It isn't purely competitive with the others the way Security and Reliability are — the same disclosure rule applies regardless of which pillar's gap is in question, a cross-cutting role closer to Proportionality's — but it carries enough substantive content of its own (ADRs, System Cards, documentation standards) to stay a full pillar rather than fold into Proportionality.
- **Engineering Excellence fourth**: verification and anti-accumulation discipline matter, but can flex under real constraint (do the minimum necessary verification, not none) in a way security and reliability can't.
- **Financial last, not least**: cost is real and bounded by construction, but the one pillar that's acceptable to spend more against if the alternative is a security or reliability failure.

**Locked 2026-08-18.** Changes only through Review and Amendment below, never silently.

---

## Pillar 1: Security

**Why this pillar exists**: A system that leaks access or credentials fails silently until it doesn't — the cost of a security failure compounds with time undetected, unlike most other failure types. Security is placed first in the priority order for the same reason.

### Practice: Exposure & access discipline

**What this requires of any new project's `STANDARDS.md`**: one scoped runtime service account per pipeline, never mixed with the deploy identity; access narrowed to the resource level actually used, confirmed by reading the code, not assumed; any public-vs-private exposure decision documented in-repo before it ships; any IAM or permission change tested via temporary impersonation before it's made permanent; any project handling personal data gets an explicit data-handling note covering what's collected, why, how long, and the legal basis for any cross-border transfer; no credential ever reaches a commit or push, caught by an automated scan at the push boundary, not by discipline alone; CI workflows pin any third-party action to a full commit SHA, never a mutable tag; dependencies resolve from a hash-locked file, never a bare unpinned list.

**Precedent**:
- One scoped runtime service account per pipeline in production, never mixed with the deploy identity.
- BigQuery IAM narrowed to table-level after confirming real read/write usage via code grep, not guesswork.
- A public-vs-private exposure decision for a live ops dashboard documented in-repo so it can't be silently "hardened back" without the reasoning being visible.
- An accounts/IAM page paused specifically because it would leak security posture on a now-public dashboard.
- A pipeline's access was narrowed from dataset-wide `WRITER` to table-scoped, tested via temporary self-impersonation before the change was made permanent, then the test grant reverted.

**Commitments, adopted 2026-08-18 unless noted, status "in rollout"**:
- Escalating budget alerts — specific thresholds and hard cap defined per company in its own `STANDARDS.md`, leaning toward enforcement, not just notification.
- Per-app API key isolation.
- IAM Recommender run as an actual periodic check, not a stated intention.
- Sensitive IAM data never ships on a public surface without a gate.
- **Secret-scanning at the push boundary** (adopted 2026-08-19) — no credential ever reaches a commit or push; caught by an automated scan at the push boundary, not by discipline alone. This is also Proportionality's Floor — the one Security baseline that applies to every project regardless of tier.
- **LGPD-aware data handling** (adopted 2026-08-17, citation corrected 2026-08-18) — any project touching personal data gets the data-handling note described above; grounded in Brazil's data protection law, which applies to him directly as a service provider handling client personal data. The specific cross-border-transfer rule is **Resolução CD/ANPD nº 19/2024**, whose standard-contractual-clause adoption grace period already ended in August 2025 — this is a currently binding requirement, not an upcoming one.
- **Supply-chain integrity** (adopted 2026-08-18) — CI workflows pin third-party actions to a full commit SHA, never a mutable tag; dependencies resolve from a hash-locked file, never a bare unpinned list. Precedent for why this matters at all: a 2025 attack rewrote every version tag on a popular CI action used by roughly 23,000 repositories, exfiltrating secrets from any workflow that ran during the window a mutable tag would have trusted.

**Real market practices this maps to**: **Zero Trust** ("never trust, always verify"); Google Cloud's own documented method for testing permission changes via service-account impersonation; AWS Well-Architected's **SEC03-BP04** ("reduce permissions continuously"); Brazil's **LGPD** (Lei Geral de Proteção de Dados), specifically Resolução CD/ANPD nº 19/2024; SHA-pinned CI dependencies and hash-locked package resolution as the concrete 2026 supply-chain expression of the same "never trust, always verify" principle.

### Practice: Confidentiality by construction

**What this requires of any new project's `STANDARDS.md`**: any project touching another party's confidential material lives in its own directory/repo, physically separate from any public-facing material — never a `.gitignore` boundary alone; any public rebuild of a real, confidential system is a sanitized generalization built from scratch, never a redacted copy of the real code or data.

**Precedent**:
- Every company/client gets its own repo, in the same parent directory as any public material, with no client folder living beside it.
- A public showcase mirrors a real production architecture in fully generic form — no real client data, no redacted-but-recognizable code.

**Commitment, adopted 2026-08-18, status "in rollout"**:
- A directory-separation check before any new public repo is created: confirm no confidential material sits in the same tree.

**Real market practices this maps to**: data minimization / need-to-know as a security-engineering principle; clean-room reimplementation (building from a spec or generic pattern rather than derived from confidential source).

---

## Pillar 2: Reliability

**Why this pillar exists**: a system that doesn't work reliably fails its basic purpose, ahead of how well-documented or well-verified it is elsewhere — this is why it sits second in the priority order, right after Security. It has three practices: designing so any real failure is cheap when it happens, detecting that a failure happened at all without waiting for a human to notice, and never trusting an inferred state over checking the real one — together they mean incidents are caught quickly, contained cheaply, and verified against reality, not silent or catastrophic.

### Practice: Design for cheap failure

**What this requires of any new project's `STANDARDS.md`**: independent, overlapping fixes for any real failure mode, never a single layer of defense; idempotent operations wherever a retry is possible, so a failure costs a retry, not lost or duplicated data; a circuit breaker on any external dependency call, stopping calls once a dependency is clearly failing instead of retrying into a worsening incident; a kill switch that halts any agent immediately without a new deployment; the same concurrency/retry discipline extended to AI agent tool-calling loops, not just traditional pipeline code; blast-radius-scoped chaos testing before trusting any resilience claim.

**Precedent**:
- A rate-limit incident: root cause was a vendor API account limit silently shared across multiple pipelines, invisible to each pipeline's own semaphore — an undisclosed shared limit at the vendor, not a bug in the pipeline code itself.
- Fixed in two independent layers — retry-on-429 plus schedule retiming, not just one.
- Idempotent cursor design (`MAX(id_item)` in BigQuery) meant the incident cost a retry, not lost data.

**Commitments, adopted 2026-08-18 unless noted, status "in rollout"**:
- Concurrency/retry discipline extended to AI agent tool-calling loops.
- An incident runbook turning root-cause write-ups into reusable "when X breaks, do Y" references.
- Chaos engineering — blast-radius-scoped proactive failure injection, starting small, expanding only after safety controls are confirmed.
- A kill switch — any agent halted immediately, no new deployment needed.
- An agent never modifies the test or evaluation harness that judges its own output — closes a loophole nothing else in this pillar covers, added 2026-08-18 after a review found no existing commitment prevented it.
- **Circuit breaker on external dependency calls** (adopted 2026-08-19) — retry alone assumes the failure is transient; a circuit breaker additionally stops calling a dependency once it's clearly failing, rather than continuing to retry into a worsening incident. Directly motivated by the rate-limit incident above: retry-on-429 alone kept pressure on an already-failing vendor limit until schedule retiming addressed the real cause — a circuit breaker would have contained that pressure faster.

**Real market practices this maps to**: **Defense in Depth**; **Chaos Engineering**; the **Circuit Breaker pattern** (Michael Nygard, *Release It!*, 2007) as the protective complement to retry — retry is optimistic and best for idempotent, transient faults, circuit breaker is protective and stops cascading failure, the two used together rather than as alternatives; kill switch → **Safe Interruptibility** (Orseau & Armstrong, DeepMind/Oxford, 2016) + **Corrigibility** (Soares, Fallenstein, Yudkowsky & Armstrong, AAAI-15 Workshop on AI and Ethics, 2015) — real engineering concepts a regulatory trend is converging toward (the EU AI Act's Article 14 runtime-halt requirement for high-risk systems), not a requirement currently binding his own work; the eval-harness-integrity commitment above and the kill switch both map to named risk categories in the **OWASP Top 10 for Agentic Applications (2026)**.

### Practice: Verify against ground truth, don't infer

**What this requires of any new project's `STANDARDS.md`**: any status or state claim is read from the real, authoritative source — an API, a live log, actual system state — never inferred from a proxy that could be wrong; AI output gets the same verification rigor as any other output before it's trusted; dependency vulnerabilities get scanned automatically, never assumed absent; CI must actually gate deploys on passing tests, not just have tests that exist somewhere.

**Precedent**:
- An ops dashboard's data model was rebuilt after inferring job status from log-text presence caused two real bugs — a job with zero log rows vanished, and different pipelines log different success text.
- The docs-compliance audit greps actual section headers instead of trusting memory.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- The same ground-truth discipline applied to AI output — for a batch-inference workload's results specifically, deterministic checks (schema conformance, non-null rate, allowed-value set, duplicate rate) plus a human-reviewed sample, not another probabilistic model judging the first one. Sharpened 2026-08-18: an earlier draft of this commitment considered naming a model-based judge as the verification method, rejected as a category error inside a practice named "don't infer" — a second inference is not ground truth.
- Automated dependency-vulnerability scanning.
- Confirming CI actually gates deploys on passing tests, not just that tests exist.

**Real market practices this maps to**: **Software Composition Analysis (SCA)**, the same practice behind a Software Bill of Materials (SBOM) — the traditional-software parallel to the Light AI-BOM adopted under Pillar 3; **Shift Left** (catch problems as early in the lifecycle as possible).

### Practice: Detect failure, don't wait to notice it

**What this requires of any new project's `STANDARDS.md`**: every scheduled or recurring job has an automated check that alerts when it doesn't run, or runs and produces no output, on its own — detection never depends on a human opening a dashboard; a pipeline's output is checked against a minimum set of assertions after every load — freshness and volume required at every tier, schema conformance required wherever the schema is known in advance, distribution checks optional until a real baseline exists at Tier 2+ — so a job that ran and wrote wrong data is caught the same way a job that didn't run at all already is; every production pipeline states one lightweight SLO (a stated success-rate target) backed by an error budget that governs pace, not just a measurement.

**Precedent**:
- A real incident ran a full day, zero items captured, before anyone noticed — the root cause was fixable in minutes once found; the day was lost entirely to not knowing.

**Commitments, adopted 2026-08-18 unless noted, status "in rollout"**:
- Automated silent-failure detection: a missed or zero-output scheduled run triggers an alert on its own.
- Data-quality assertions (freshness, volume, schema required; distribution optional at Tier 2+) extending silent-failure detection from "did it run" to "did it write something correct" — the gap this closes: nothing before this caught a job that ran cleanly and still wrote wrong data.
- **A lightweight SLO and error budget per production pipeline** (adopted 2026-08-19) — one stated success-rate target per pipeline, no quarterly review ritual, no multi-service SLO program; when the error budget burns out, reliability work on that pipeline takes priority over new feature work until it recovers. Scaled down deliberately from the enterprise SRE version: a governance rule against his own stated target, never a benchmark against another company's numbers — the same reasoning that already ruled out DORA metrics as meaningless at his scale doesn't apply here, since nothing is being compared against a cohort.

**Real market practices this maps to**: **MTTD (Mean Time to Detect)** as a reliability metric distinct from MTTR; the dead man's switch / heartbeat monitoring pattern; the four-dimension data-quality-assertion shape (freshness, volume, schema, distribution) used in current data-observability practice; **SLI/SLO/error budgets** (Google SRE) as the reliability-governance counterpart to Pillar 5's budget alerts — the same escalation logic applied to a reliability target instead of a dollar figure.

---

## Pillar 3: Governance & Transparency

**Why this pillar exists**: this pillar governs how failures, tradeoffs, and gaps in every other pillar get handled — the rule is always disclose, never hide, and never let critical knowledge live only in one person's head. Third in the priority order, right after Security and Reliability: a technical shortcut is forgivable if it's disclosed, not if it's hidden. It's also the direct accounting mechanism behind the whole "nothing ships unsupervised" thesis — since a person, not a system, is ultimately accountable for every decision, that accounting has to be written down and accessible without that person in the room.

### Practice: Tradeoffs written down, never silent

**What this requires of any new project's `STANDARDS.md`**: any hard-to-reverse or cross-team decision gets a written ADR before or immediately after the fact, never only remembered; any deployed AI-involving system gets a System Card documenting the model, the review/oversight mechanism, and known limitations; any project using AI discloses, in one line, which model/version, whether it's fine-tuned (never, here), and which APIs/infra the AI touches; any project whose AI output reaches an end consumer directly (e.g. AI-generated product content shown on a live storefront) flags this in the AI-BOM so the deploying client is aware of its own AI-content disclosure obligation; an open question stays written down as open, never quietly assumed resolved; when it's unclear whether a Constitution rule applies, or the information needed to decide is missing, that gap is stated explicitly and flagged for a decision, never silently assumed or fabricated.

**Precedent**:
- Reusing a broad-scope personal token as a CI fix was a conscious, asked-first decision, with the properly-scoped fix named as a real follow-up — not hidden.
- The AI enricher's lack of automation is documented as an open, undecided question rather than quietly assumed fine.

**Commitments, adopted 2026-08-18 unless noted, status "in rollout"**:
- **ADR (Architecture Decision Record)** — root-cause write-ups already function as informal ADRs; formalized as one ADR per hard-to-reverse or cross-team decision, stored in `docs/adr/`, written forward from now rather than retroactively.
- **System Card per project** — documents the deployed system: model, review/oversight mechanism, limitations.
- **Light AI-BOM** — one line per project disclosing model/version, no fine-tuning, and which APIs/infra the AI touches.
- **EU AI Act Article 50 flag** (adopted 2026-08-19) — when a project's AI output reaches an end consumer directly, the AI-BOM additionally notes this so the deploying client is aware of its own Article 50 consumer-facing disclosure obligation (live since 2026-08-02). An advisory flag, not a claim that he personally discharges the client's disclosure duty: Article 50 obligations fall on the provider/deployer facing the end consumer — typically the client, not the service provider who built the pipeline.

**Real market practices this maps to**: **ADR** (adr.github.io, AWS Architecture Blog); **System Cards**; **AI-BOM** — the same disclosure surface CycloneDX's **ML-BOM** standard (now **ECMA-424**) covers, though his own version stays a one-line disclosure, not a generated CycloneDX document; the EU AI Act's **Article 50** consumer-facing AI-content disclosure requirement — unlike the Article 14 kill-switch requirement cited under Pillar 2, already binding since 2026-08-02, though on the deploying client rather than on him directly.

### Practice: Eliminate tribal knowledge

**What this requires of any new project's `STANDARDS.md`**: documentation complete enough that someone — or an AI — with zero prior context can understand the whole project by reading only the docs, no hidden context required; postmortems consolidated in one discoverable location, never scattered; a periodic zero-context test that actually verifies this empirically instead of assuming it.

**Precedent**:
- A real `STANDARDS.md` already functions as the single source of truth for how a company's pipelines get built — new work derives from it, not from asking around.
- A governance clarification: "AI driven" does not mean removing human code review — it means the docs must stand on their own, with no hidden context needed to understand the business.

**Commitments, adopted 2026-08-17 unless noted, status "in rollout"**:
- Postmortems consolidated into `docs/postmortems/`, alongside `docs/adr/`, written blameless (added 2026-08-19) — focused on systemic root cause, never individual fault.
- A periodic zero-context test.

**Real market practices this maps to**: bus factor reduction / documentation as the single source of truth; also his real, named answer to **"key person risk"** (the sole-practitioner succession-planning term) — no separate commitment needed for that beyond the two above, the zero-context-test discipline already is the mitigation; **blameless postmortem** practice (Google SRE) — also named in DORA's own research as a high-performer trait, cited here only as corroborating evidence, not as adoption of DORA's benchmarking metrics, which stay rejected as disproportionate at his scale.

---

## Pillar 4: Engineering Excellence

**Why this pillar exists**: this is the discipline that keeps a system correct and maintainable over time, not just working today — verifying a change before and after it ships, refusing to let complexity or debt accumulate silently, and applying that same rigor to the data layer specifically, since data outlives any one pipeline that touches it. Fourth in the priority order: this pillar can flex under real constraint (doing the minimum verification actually necessary, not none) in a way Security and Reliability can't.

### Practice: Verify before shipping, revert without drama when it doesn't generalize

**What this requires of any new project's `STANDARDS.md`**: a real, measured verification step before any optimization or port replaces an existing method — never assumed equivalent; a tested rollback path before anything ships that could need one; extra scrutiny for any AI-suggested library, pattern, or API that isn't already proven in this environment — standard library preferred by default — treated as needing verification, not baseline trust; a caveat documented and kept, not hidden, when a technique that worked once doesn't generalize elsewhere; any non-trivial AI-agent-driven change starts from a written spec with explicit acceptance criteria, not a bare prompt, so the agent has a real target and there's something concrete to verify against afterward; any AI-generated diff too large to meaningfully review gets broken into smaller reviewable pieces before it ships, never rubber-stamped whole; any project with non-trivial logic (a branch, a loop, a parser, a money or security path) ships with a minimal test suite covering it — not full coverage, just enough that Pillar 2's CI test-gate has something real to enforce, verified by mutation testing that the suite actually fails when the logic breaks, not just that it exists; static analysis (linting plus a security ruleset, with a cyclomatic-complexity ceiling enforced the same way) runs in CI on every project.

**Precedent**:
- A concurrent-fetch optimization was verified byte-identical against the old method before switching.
- The same technique tried on a different pipeline made it meaningfully slower instead of faster — reverted cleanly, and documented as a real caveat rather than hidden.

**Commitments, adopted 2026-08-18 unless noted, status "in rollout"**:
- A tested, verified rollback path as a standing rule: a ported optimization needs an equivalent verification step before it replaces the old method.
- Extra verification for AI-suggested unfamiliar tools before they're treated as trustworthy.
- A minimal test suite required for any non-trivial logic before a project counts as "ready to ship" — closes the gap where Pillar 2's CI test-gate had nothing guaranteed to enforce.
- **Model Context Protocol (MCP)** as the default method for any future integration with a client's external tool or data source, instead of a bespoke integration — adopted forward, no real usage yet, same logic as the data-lineage commitment under "Database / data-layer standards" below. Strengthened 2026-08-18: MCP is now a vendor-neutral standard under the Linux Foundation's Agentic AI Foundation, not a single vendor's protocol — a better fit for Choose Boring Technology than when first adopted.
- **Static analysis in CI** (adopted 2026-08-18) — linting with a security ruleset enabled, plus a cyclomatic-complexity ceiling enforced by the same tool.
- **Spec-driven development for AI-agent changes** (adopted 2026-08-19) — any non-trivial AI-agent-driven change starts from a written spec with explicit acceptance criteria before the agent generates anything. Formalizes the plan step his own research→plan→execute→review→ship pattern already requires; the failure mode this closes is confident, plausible code that quietly solves the wrong problem because nothing grounded it in a real specification.
- **AI-generated diffs capped to a reviewable size** (adopted 2026-08-19) — a diff too large to meaningfully review gets broken into smaller pieces before it ships. A diff nobody can actually read isn't reviewed, it's rubber-stamped — which breaks "nothing ships unsupervised" in practice even when the letter of the rule is followed.
- **Mutation testing wherever the minimal test suite requirement applies** (adopted 2026-08-19) — confirms a test suite actually fails when the underlying logic breaks, not just that coverage exists. Closes a failure mode specific to AI-generated tests: a test can assert nothing meaningful and still show green, the same category of risk the eval-harness-integrity commitment under Pillar 2 already guards against for evaluation harnesses.

**Real market practices this maps to**: **Choose Boring Technology** (Dan McKinley); **Shift Left**; static analysis / SAST (NIST SSDF SP 800-218, practice PW.7); McCabe cyclomatic complexity (NIST SP 500-235); **Spec-Driven Development** (2026 market practice, formalized across GitHub Spec Kit, AWS Kiro, and Claude Code's own workflow) as the AI-specific expression of Shift Left already cited above; the documented quality gap between AI-generated and human-written pull requests (roughly 1.7x more issues per PR, logic errors up ~75%) as the empirical basis for the diff-size cap; **mutation testing** (Stryker, PIT) as the practice that verifies test-suite quality itself, not just its existence.

### Practice: Anti-accumulation

**What this requires of any new project's `STANDARDS.md`**: status reporting that fits in one line by design, so "is this done yet" never requires touching more than one place; no new document created unless it earns its keep over what already exists — deleted the moment it just duplicates something else; a one-off setup mistake turned into a checklist so it can't recur on the next project; a defined rotation cadence for credentials, so a secret never becomes silent debt.

**Precedent**:
- Repo status fits one line by design across every repo in production.
- Two org-level "overview" docs were built and then deleted once they proved to just duplicate content and cost upkeep without paying for itself.
- A one-off CI setup bug was turned into a checklist so it can't recur on the next repo.
- An orphaned service-account key, found via audit log, was removed once its absence was confirmed safe — nothing left as silent debt.

**Commitments, adopted 2026-08-18, status "in rollout"**:
- A defined secret-rotation cadence for privileged/service credentials, shorter for broad-access credentials — the exact interval is set per company's `STANDARDS.md`, not fixed here, since NIST/CIS give cryptoperiod ranges rather than a specific figure to borrow.

**Real market practices this maps to**: **Toil Reduction** (Google SRE); **NIST SP 800-57** + CIS Controls **v8.1** (note: this is the standard for *privileged/service* credentials specifically — NIST's separate, newer guidance against forced rotation applies only to memorized user passwords, a different category).

### Practice: Database / data-layer standards

**What this requires of any new project's `STANDARDS.md`**: BigQuery (or equivalent) IAM scoped at dataset level for broad access, table level when a project's reads and writes target different tables; datasets separated by concern, never mixed; partitioned tables by default, never date-sharded, so storage growth is bounded by construction the same way cost is under Pillar 5; a table/partition expiration policy so old data ages out on purpose; column- or row-level security on any table carrying customer data; a real backup and disaster-recovery plan for anything that can't simply be regenerated.

**Precedent**:
- A `STANDARDS.md` already codifies the BigQuery IAM pattern above for any new pipeline.
- Datasets separated by concern and never mixed (pipeline data, log sink, and billing export kept in separate datasets).
- Partitioned tables mandated over date-sharded for the logging sink specifically, to bound table growth by construction.
- BigQuery clustering documented as an invariant in a pipeline's own README Rules section.

**Commitments, adopted 2026-08-17, status "in rollout"**:
- Table/partition expiration policy.
- Column/row-level security for tables carrying customer data (e.g. an orders table).
- Data lineage tracking — adopted deliberately even though it was flagged as likely disproportionate at his current one-person scale. The specific tool is named in `STANDARDS.md`, not here: the vendor product behind this has already been renamed twice in six months, and naming it here would just create a future rename-driven amendment.
- Backup and disaster recovery (BDR) — restoring mission-essential data within a bounded time, not left to chance.

**Real market practices this maps to**: GCP's own BigQuery IAM and partitioning guidance; **NIST SP 800-34** (contingency planning — mission-essential functions restored within 12 hours, fully restored within 30 days) and the modern **3-2-1-1-0** backup practice.

---

## Pillar 5: Financial

**Why this pillar exists**: cost overrun is an old failure mode, not a new one — but AI-driven work gives it a new, faster shape: an agentic loop or an unbounded batch job can spend money indefinitely if nothing bounds it by design, faster than a traditional misconfiguration usually would. Cost needs to be bounded **by construction**, the architecture itself makes the failure impossible or capped, not just caught after the fact on a monthly bill. This is also the most flexible pillar in the priority order above: worth spending more against, deliberately, if the alternative is a security or reliability failure — but that flexibility only holds because the baseline discipline below already exists and isn't itself the thing failing.

**What this requires of any new project's `STANDARDS.md`**: any AI work runs through a bounded-cost interface (a batch API, not an open-ended interactive loop) unless a specific, reviewed exception is documented; escalating budget alerts configured before a new agent or pipeline ships, not after; a real cost projection done before a new agent ships, expressed as a cost-per-completed-task unit, not just a raw dollar figure, and not discovered from the first bill; the smallest model capable of a task used by deliberate choice, not the frontier model by default; prompt/response caching used by default wherever the underlying API supports it.

**Precedent**:
- An AI enrichment workload runs via a batch inference API — inherently bounded-cost, never an open-ended interactive agent loop.
- A live ops dashboard's billing panel makes real spend visible on demand, not discovered from a monthly bill after the fact.
- The AI enrichment workload already runs on a deliberately smaller, cheaper model rather than a frontier one — static tiering in practice, just not yet named as a formal commitment.

**Commitments, adopted 2026-08-18 unless noted, status "in rollout"**:
- Escalating budget alerts (same structure as Pillar 1: thresholds and hard cap defined per company's `STANDARDS.md`), leaning toward enforcement — stopping the next call, not just notifying after the spend already happened.
- A real cost projection required before any new agent ships, stated as cost-per-completed-task (adopted 2026-08-19: sharpened from a bare dollar figure to a unit-economics number, so cost is comparable across runs of different size).
- Prompt/response caching used by default — Anthropic's own **Prompt Caching** feature, cache-read tokens priced roughly 90% below base input-token rates, currently unused anywhere despite being native to the exact API already in use.
- **Static model tiering** (adopted 2026-08-19) — the smallest model capable of a task is used by deliberate, static choice, never a learned/dynamic router. Names what the AI enrichment workload already does; deliberately excludes dynamic model-routing systems, which only pay for themselves at a request volume far above his own.

**Real market practices this maps to**: Anthropic's own officially named **Prompt Caching** feature; the 2026 cost-governance distinction between *alerts* (notify after spend happens) and *enforcement* (pause or terminate before the next call happens) — this pillar leans toward enforcement specifically, since an alert alone doesn't bound anything by construction, it only reports it after the fact; **FinOps for AI**'s cost-per-token/cost-per-inference/cost-per-completed-task unit-economics practice (FinOps Foundation), scaled down to the one metric that's actually useful at his size; **static model tiering** as the proportionate slice of 2026 LLM cost-optimization practice — the same **Choose Boring Technology** reasoning already cited under Pillar 4 applied to model selection: static tiering captures most of the available savings without the complexity of a learned router.

---

## Proportionality — a cross-cutting interpretive principle, not a sixth pillar

**Why this exists, and why it isn't a pillar**: none of the 5 pillars above are meant to apply with identical weight to every project regardless of size or risk — a principle applied that rigidly gets ignored under real constraint, or demands disproportionate overhead from something small enough not to need it. Proportionality is the rule for how hard each pillar's controls get applied to a given project, not a sixth substantive article beside them — the same way a real constitution has interpretive clauses about how the document itself should be read, distinct from its substantive articles.

**What this requires of any new project's `STANDARDS.md`**: every project gets classified by consequence-of-failure and reversibility before deciding which subset of the 5 pillars' controls actually apply to it. A project with no cloud infrastructure and no scaling lever doesn't need an escalating-autoscale-alert practice, for instance — pretending it does wastes effort without reducing any real risk.

**Floor**: Proportionality scales the depth and frequency of a pillar's controls, never whether Security's non-negotiable baseline applies. Every project, regardless of tier, requires the four non-negotiables named in Pillar 1: no runtime service account mixed with a deploy identity, no untested IAM change made permanent, no public-vs-private exposure decision left undocumented, no credential ever reaching a commit or push — since a leaked credential is irreversible regardless of the project it leaked from. Everything else in every pillar scales by tier.

**Tiers**: every project is classified into one of three tiers by consequence-of-failure and reversibility, which sets both how much of each pillar's controls apply and which supervision mode governs the work.
- **Tier 1 — Low**: reversible, no external exposure, failure affects only Paulo's own workflow (e.g. a manual, no-infra AI enrichment run). Full pillar controls optional beyond the Floor above. Supervision: human-on-the-loop.
- **Tier 2 — Standard**: touches live infrastructure or third-party data, failure is recoverable but costly (e.g. a production pipeline running under its own service account). Full pillar controls apply. Supervision: human-on-the-loop, human-in-the-loop for anything hard-to-reverse.
- **Tier 3 — Critical**: touches customer or personal data, has public exposure, or is hard to reverse (e.g. an IAM change, a public dashboard, anything carrying PII). Full pillar controls apply, no exceptions without a written, Paulo-approved exception (Review and Amendment). Supervision: human-in-the-loop.

**Precedent**:
- Two AI enrichment workloads are manual-only, no cloud infrastructure at all — Tier 1, a practice like escalating autoscale alerts simply doesn't map onto something with no scaling lever to escalate to.

**Commitment, adopted 2026-08-17, status "in rollout"**:
- The **Tiers** defined above turn proportionality from a per-case judgment call into a repeatable rule, and are the concrete mechanism behind the HITL/HOTL supervision tiering this Constitution's enforcement already uses in practice.

**Real market practices this maps to**: proportionality as a named principle in security engineering (control depth should match risk exposure and system size, not be applied identically everywhere); **CIS Controls v8.1's Implementation Groups** (added 2026-08-19) as the closest direct parallel to the Tiers above — IG1/IG2/IG3 are cumulative maturity layers (IG2 includes IG1, IG3 includes IG1+IG2, the same nesting the Tiers use), and IG1's own target profile (limited security expertise, standard commercial hardware/software) describes his actual scale directly, unlike the framework below; the **FAIR Institute**'s risk-based technology controls framework, specifically its **FAIR-CAM** (FAIR Controls Analytics Model, v1.0) as a further artifact this pillar's tiering echoes — cited as a parallel, not an implementation; actually certifying against it would be disproportionate at his own scale, the same logic Proportionality applies to everything else.

---

## Review and Amendment — who enforces this, and how it changes

**Why this exists**: a constitution that can't be checked against reality, or amended when it's wrong, is either quietly ignored or followed past the point it still makes sense. This section names who is accountable, how compliance actually gets checked instead of assumed, and how the document itself is allowed to change.

**Modeled on Anthropic's own Responsible Scaling Policy**: a named, accountable role approves exceptions, reviews decisions against the policy, and owns both non-compliance handling and framework updates. For this Constitution, Paulo holds that role, formally — the same logic as "nothing ships unsupervised," applied to the document that defines what supervision means.

**What this requires**:
- **Exceptions**: any exception to a Constitution rule, when a real tradeoff demands one, is approved by Paulo explicitly and written down — never silently taken (Pillar 3). Identifying a candidate exception can come from any tier — a Manager agent flagging that a new amendment creates a real operational conflict for its company counts as this — but approval never does; only Paulo grants one.
- **Verification and cross-check before publish** (added 2026-08-18, the Devil's Advocate idea, refined by its own adversarial pass before being written in): any claim this Constitution makes about external reality — a cited standard, a regulatory claim, a market practice, a statistic — has its source opened and confirmed to actually say what's being claimed, before it's published, never assumed correct because it sounds right. Any change to a publicly-visible claim additionally gets a mandatory cross-check from a genuinely different model family before it ships — not a same-family review, which carries documented self-preference and family bias that a same-family adversarial framing doesn't escape. Triggered by publication (a push to the public repo), not by an undefined "high tier" label: a claim in a private, unpublished draft is trivially reversible, a claim quoted back at him in public or in an interview is not. The mechanism that actually caught a wrong citation during this rule's own drafting was verification, not adversarial argument — that's why verification is the mandatory half and cross-family review is the debiasing half, rather than same-family role-play carrying the weight.
- **Amendment**: this Constitution changes only on a real, concrete event — a new practice proven, a gap found, a decision that no longer holds — never on a calendar schedule. The lesson behind this is real: two internal "org overview" documents were built and deleted for costing upkeep without paying for themselves; a document that updates on a schedule accumulates exactly that kind of debt. This governs how the *document itself* changes, not the handful of operational checks it requires (credential rotation, IAM Recommender scans, the periodic zero-context test) that run on a minimum calendar floor — those exist because the thing they check doesn't announce its own drift, and a fixed floor is the only way to guarantee it gets looked at. A rule that proves genuinely global at the project level is promoted into this Constitution the same way — event-triggered by real proof at a smaller scale, not scheduled. In practice today: the same practice independently proving necessary in two or more separate companies' `STANDARDS.md` counts as real proof of that kind. A percentage-based bar (e.g. "present in most clients") isn't a meaningful measure yet at a population of one or two real companies — revisit once there's a large enough population of clients for a percentage to mean anything.
- **Self-assessment**: a short, honest check that the Constitution is actually being followed, not assumed to be — run on the same event-triggered cadence as amendment (a new project, an incident, or a stretch of time where nothing got checked), never calendar-based. Modeled on GCP's own Well-Architected Framework Review: one short question per pillar, scaled down to one person instead of an enterprise team.

  **Graduation**: a commitment moves from "in rollout" to standing Precedent the first time it's demonstrated on a real, running project — not on a calendar, not on intention. Every self-assessment counts how many of each pillar's commitments have graduated, so "in rollout" can't quietly become the permanent state. For a commitment that defers a specific value to a company's `STANDARDS.md` (an alert threshold, a rotation interval, a named tool) rather than stating one itself: the abstract rule alone never counts as graduated — that `STANDARDS.md` has to actually state the concrete value first.

  **Sync visibility**: every `STANDARDS.md`, Manager agent config, and Subagent config states, in one line, which version of the tier directly above it it was last checked against — the same one-line-status discipline Pillar 4 already requires of repo status, applied to hierarchy sync. The Constitution itself carries a semantic version (added 2026-08-19: MAJOR.MINOR.PATCH, bumped on every amendment) — MAJOR for a change to the Priority order or a pillar's core structure, MINOR for a new commitment, PATCH for a citation or wording fix — so a stale sync line signals how severe the drift is, not just that it's stale. Self-assessment includes comparing that line against the current HEAD (and current version) of the tier above; anything stale is flagged as due for a check, never silently assumed current. The versioning scheme is a labeling convention only, not a review cadence: a 2026 market recommendation to pair semantic versioning with quarterly major-version review was considered and rejected — that's exactly the calendar-based debt the Amendment clause above already exists to avoid.
  - **Security** — can I point to a real, current proof of least-privilege/impersonation-testing on the last project touched?
  - **Reliability** — does the last incident have a written root cause plus two independent fixes, not one?
  - **Governance & Transparency** — does the last hard-to-reverse decision have an ADR?
  - **Engineering Excellence** — was the last shipped change verified before going out, with a real rollback path?
  - **Financial** — is there an actual configured budget alert, not just a stated intention?

  Answered honestly against real evidence each time, not assumed — a "no" is the point of running it, not a failure to hide.

- **Practice-gap research** (added 2026-08-19, formalizing a pattern used across this Constitution's own pillar-by-pillar review): whenever a pillar is walked through — a formal self-assessment, or a periodic pillar-by-pillar review — a short, targeted search (2-3 queries, not an open-ended survey) checks that pillar's domain for current market practices not yet covered. Distinct from the market re-check inside self-assessment above, which only re-verifies that existing citations are still accurate: this one looks for what's missing, not what's stale. Every finding is filtered before anything is proposed — real precedent tying it to his actual work, proportionate to his scale, not duplicating an existing commitment, not already rejected for a documented reason — the same discipline the Verification and cross-check rule above already applies to citations. Only what survives the filter becomes a candidate amendment; same publish gate as any other change, Paulo decides.

**Real market practices this maps to**: Anthropic's own **Responsible Scaling Policy**; GCP's own **Well-Architected Framework Review**; **Semantic Versioning** (added 2026-08-19) as the scheme backing the Constitution's own version tags.
