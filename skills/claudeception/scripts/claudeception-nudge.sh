#!/usr/bin/env bash
# Claudeception quiet nudge hook — one line, once per session.
#
# Wired automatically via hooks/hooks.json when the plugin is installed.

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')

STATE_FILE="/tmp/claudeception-nudged-${SESSION_ID}"
LOG_DIR="${HOME}/.claude/logs/claudeception"
LOG_FILE="${LOG_DIR}/nudge.log"
mkdir -p "$LOG_DIR"

TS=$(date -u +%FT%TZ)

if [[ ! -f "$STATE_FILE" ]]; then
  touch "$STATE_FILE"
  echo "${TS} session=${SESSION_ID} event=nudge-emitted" >> "$LOG_FILE"
  echo "Reminder: if this session produced a non-obvious insight or workaround, consider running /claudeception to extract it as a skill or memory."
else
  echo "${TS} session=${SESSION_ID} event=nudge-suppressed-duplicate" >> "$LOG_FILE"
fi

exit 0
