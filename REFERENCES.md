# References

Every source `CONSTITUTION.md` cites by name, grouped by theme — scoped strictly to what the Constitution's own text references, not the broader research that shaped how I work day to day. A few are named in the document without a confirmed public URL — listed here without a link rather than guessing one.

## Anthropic

- [Claude's Constitution (Jan 2026)](https://www.anthropic.com/news/claude-new-constitution) — structural precedent cited in the Preamble
- [Prompt caching documentation](https://docs.anthropic.com/en/docs/build-with-claude/prompt-caching) — Pillar 5 (Financial)
- [Responsible Scaling Policy](https://www.anthropic.com/responsible-scaling-policy) — model for Review and Amendment

## Philosophies (Preamble)

- [Dan McKinley — Choose Boring Technology](https://mcfunley.com/choose-boring-technology)
- [Databricks — What is Human-in-the-Loop (HITL)](https://www.databricks.com/blog/human-in-the-loop)
- [AWS — Enterprise DevOps: Why You Should Run What You Build](https://aws.amazon.com/blogs/enterprise-strategy/enterprise-devops-why-you-should-run-what-you-build/) — Werner Vogels' "You Build It, You Run It"
- Agentic engineering (2026 market terminology) — named source, no link on file

## Pillar 1: Security

- [NIST SP 800-207 — Zero Trust Architecture](https://nvlpubs.nist.gov/nistpubs/specialpublications/NIST.SP.800-207.pdf)
- [Google Cloud — Service account impersonation](https://cloud.google.com/iam/docs/service-account-impersonation)
- [AWS Well-Architected — SEC03-BP04, reduce permissions continuously](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/sec_permissions_continuous_reduction.html)
- [Resolução CD/ANPD nº 19/2024 — international data transfer standard contractual clauses](https://www.gov.br/anpd/pt-br) (ANPD's own site; the specific resolution text itself wasn't reachable via a stable direct link — the Mayer Brown citation below is treated as sufficient secondary confirmation for this claim, proportional to his scale; revisit only if a stable primary link surfaces)
- [Mayer Brown — End of grace period, Brazil's SCCs for international data transfers](https://www.mayerbrown.com/pt/insights/publications/2025/08/end-of-grace-period-implementation-of-brazils-standard-contractual-clauses-in-international-transfers-of-personal-data) — confirms the grace period ended August 2025, already binding; this is the citation the public Pillar 1 claim actually rests on
- [Unit 42 (Palo Alto Networks) — tj-actions/changed-files supply chain attack](https://unit42.paloaltonetworks.com/github-actions-supply-chain-attack/) — precedent for the SHA-pinning commitment
- [GitHub Changelog — Actions policy supports SHA pinning](https://github.blog/changelog/2025-08-15-github-actions-policy-now-supports-blocking-and-sha-pinning-actions/)

## Pillar 2: Reliability

- [Palo Alto Networks — Defense-in-Depth](https://www.paloaltonetworks.com/cyberpedia/what-is-defense-in-depth)
- [Principles of Chaos Engineering](https://principlesofchaos.org/)
- [Martin Fowler — CircuitBreaker](https://martinfowler.com/bliki/CircuitBreaker.html) — the Circuit Breaker pattern, crediting Michael Nygard's *Release It!* (2007) as its origin; added 2026-08-19
- [Google SRE Book — Service Level Objectives](https://sre.google/sre-book/service-level-objectives/) — SLI/SLO/error budget, cited as the reliability-governance counterpart to Pillar 5's budget alerts; added 2026-08-19
- [Safely Interruptible Agents (Orseau & Armstrong, UAI 2016)](https://dl.acm.org/doi/10.5555/3020948.3021006) — corrected 2026-08-18, the previous link pointed to a 2017 paper by different authors
- [Corrigibility (Soares, Fallenstein, Yudkowsky & Armstrong, AAAI-15 Workshop on AI and Ethics, 2015; MIRI technical report 2014-6)](https://intelligence.org/2014/10/18/new-report-corrigibility/) — corrected 2026-08-18, replaces a vendor-glossary source with the founding paper
- [EU AI Act — Regulation (EU) 2024/1689, Article 14](https://artificialintelligenceact.eu/article/14/) — cited only as the shape of runtime-halt regulatory convergence for high-risk systems, not as a requirement currently binding his own work; California SB-1047 (vetoed) and the 2024 Seoul Declaration (voluntary) were dropped from this citation 2026-08-18 as overstated for that purpose
- [OWASP Top 10 for Agentic Applications (2026)](https://genai.owasp.org/resource/owasp-top-10-for-agentic-applications-for-2026/) — added 2026-08-18
- [Sonatype — Software Composition Analysis (SCA)](https://www.sonatype.com/resources/articles/what-is-software-composition-analysis)
- [Fortinet — Shift Left Security](https://www.fortinet.com/resources/cyberglossary/shift-left-security)
- [Atlan — data quality testing techniques, 2026](https://atlan.com/data-quality-testing/) — source for the freshness/volume/schema/distribution assertion shape; a single vendor source, not a standards body, worth a stronger citation if this gets cited anywhere public-facing

## Pillar 3: Governance & Transparency

- [adr.github.io — Architectural Decision Records](https://adr.github.io/)
- [AWS Architecture Blog — ADR best practices](https://aws.amazon.com/blogs/architecture/master-architecture-decision-records-adrs-best-practices-for-effective-decision-making/)
- [AI Buzz — AI System Cards Explained](https://aibuzz.blog/ai-system-cards-explained/)
- [CycloneDX — ML-BOM](https://cyclonedx.org/capabilities/mlbom/) — corrected 2026-08-18, replaces a vendor blog with the actual standard (now also ECMA-424)
- [EU AI Act — Article 50 transparency rules](https://artificialintelligenceact.eu/transparency-rules-article-50/) — consumer-facing AI-content disclosure, live since 2026-08-02; added 2026-08-19
- [Clio — Succession Planning for Solo Law Firms ("key person risk")](https://www.clio.com/blog/solo-law-firm-succession-planning/)
- [Rootly — How to Run Effective Blameless Postmortems](https://rootly.com/incident-postmortems/blameless) — added 2026-08-19

## Pillar 4: Engineering Excellence

- [Google SRE Book — Eliminating Toil](https://sre.google/sre-book/eliminating-toil/)
- [NIST SP 800-57 Part 1 Rev. 5 — Recommendation for Key Management](https://csrc.nist.gov/pubs/sp/800/57/pt1/r5/final) — cites cryptoperiod ranges, not a specific figure; the Constitution defers the exact rotation interval to each company's `STANDARDS.md` rather than stating one itself
- [CIS Critical Security Controls v8.1](https://www.cisecurity.org/controls/v8-1) — corrected 2026-08-18, was citing the superseded v8
- [NIST SSDF SP 800-218 — static analysis (practice PW.7)](https://secportal.io/blog/nist-ssdf-implementation-guide)
- [NIST SP 500-235 — McCabe cyclomatic complexity](https://www.mccabe.com/pdf/mccabe-nist235r.pdf) — PDF downloads and appears legitimate by size/host, but its text content wasn't verifiable in this pass; confirm before citing this one publicly
- [Spec-Driven Development in 2026: What It Is, the Tooling, and How Teams Actually Use It](https://dev.to/krlz/spec-driven-development-in-2026-what-it-is-the-tooling-and-how-teams-actually-use-it-2fk2) — added 2026-08-19
- [How to Review AI-Generated Code in 2026: Pipeline, Tools, and Best Practices](https://codeant.ai/blogs/how-to-review-ai-generated-code) — source for the AI-generated-PR quality-gap figures behind the diff-size cap; added 2026-08-19
- [Mutation Testing for AI-Generated Code: A Practical Guide | Augment Code](https://www.augmentcode.com/guides/mutation-testing-ai-generated-code) — added 2026-08-19
- [Google Cloud — Introduction to security and access controls in BigQuery](https://docs.cloud.google.com/bigquery/docs/access-control-intro)
- [Google Cloud — Manage partition and cluster recommendations in BigQuery](https://docs.cloud.google.com/bigquery/docs/manage-partition-cluster-recommendations)
- [NIST SP 800-34 Rev. 1 — Contingency Planning Guide](https://nvlpubs.nist.gov/nistpubs/legacy/sp/nistspecialpublication800-34r1.pdf) (12h/30d recovery targets)
- [NinjaOne — Backup and Disaster Recovery (BDR) Explained](https://www.ninjaone.com/blog/what-is-backup-and-disaster-recovery-and-why-do-you-need-it/) (3-2-1-1-0 backup practice)

## Pillar 5: Financial

- [FinOps for AI Overview | FinOps Foundation](https://www.finops.org/wg/finops-for-ai-overview/) — cost-per-token/cost-per-inference/cost-per-completed-task unit-economics practice; added 2026-08-19
- [Right-Sizing the Frontier: LLM Routing, Workload-to-Model Matching, and Token-per-Dollar Economics](https://medium.com/@adnanmasood/right-sizing-the-frontier-a-guide-to-llm-routing-workload-to-model-matching-and-token-per-dollar-1032d3dbcb01) — source for static tiering as the proportionate slice of LLM cost optimization, and for the ~100k DAU threshold where dynamic routing starts to pay for itself; added 2026-08-19

## Proportionality

- [Home Office UK — Proportionate security](https://engineering.homeoffice.gov.uk/principles/proportionate-security/)
- [CIS Critical Security Controls — Implementation Groups](https://www.cisecurity.org/controls/implementation-groups) — closest direct parallel to the Tiers; added 2026-08-19
- [FAIR Institute — Risk-Based Technology Controls Framework](https://www.fairinstitute.org/blog/establishing-a-risk-based-technology-controls-framework)
- [FAIR Institute — FAIR-CAM (FAIR Controls Analytics Model) v1.0](https://www.fairinstitute.org/fair-controls-analytics-model) — added 2026-08-18, cited as a parallel to the Tiers, not an implementation

## Review and Amendment

- [Responsible Scaling Policy](https://www.anthropic.com/responsible-scaling-policy) — see Anthropic, above
- [Google Cloud Well-Architected Framework](https://docs.cloud.google.com/architecture/framework)
