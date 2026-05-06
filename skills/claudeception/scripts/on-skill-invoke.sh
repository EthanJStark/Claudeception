#!/usr/bin/env bash
# Claudeception skill-invocation observer.
#
# Fires on every PreToolUse:Skill event (wired via hooks/hooks.json).
# Logs invocations of the `claudeception` skill specifically, plus a
# compact record of every other skill invocation, to help debug triggering
# behavior while we refine the plugin.

INPUT=$(cat)
SESSION_ID=$(echo "$INPUT" | jq -r '.session_id // "unknown"')
TOOL_INPUT=$(echo "$INPUT" | jq -c '.tool_input // {}')

LOG_DIR="${HOME}/.claude/logs/claudeception"
LOG_FILE="${LOG_DIR}/skill-invocations.log"
mkdir -p "$LOG_DIR"

TS=$(date -u +%FT%TZ)

echo "${TS} session=${SESSION_ID} tool_input=${TOOL_INPUT}" >> "$LOG_FILE"

exit 0
