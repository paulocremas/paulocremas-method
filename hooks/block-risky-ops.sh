#!/bin/bash
# PreToolUse hook for lead-agent.md: technical backstop for the prompt-level
# boundary in "What you never do" (never execute production changes, never
# touch live credentials). Blocks Bash/Edit/Write calls that match known
# deploy-command or credential-file patterns.
#
# ponytail: greps the raw hook JSON for known-dangerous substrings instead of
# parsing it properly - jq isn't installed on this machine, and these
# patterns are distinctive enough not to need real JSON parsing. Ceiling: a
# command that obfuscates a keyword (string concatenation, base64, an alias)
# slips through. This is a backstop for the agent's own stated boundary, not
# a sandbox - add jq-based field extraction if the pattern set ever grows
# complex enough for raw-text matching to misfire.

INPUT=$(cat)

if echo "$INPUT" | grep -qiE 'terraform apply|gcloud[^"]*deploy|kubectl apply|docker push|npm publish'; then
  echo 'Blocked: looks like a production deployment command. The Lead agent never executes production changes (see lead-agent.md, "What you never do").' >&2
  exit 2
fi

if echo "$INPUT" | grep -qiE '\.env|\.pem|\.key|service-account[^"]*\.json|credentials\.json'; then
  echo 'Blocked: looks like a credential file. The Lead agent never touches live credentials (see lead-agent.md, "What you never do").' >&2
  exit 2
fi

exit 0
