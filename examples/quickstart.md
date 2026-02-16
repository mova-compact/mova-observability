# Quick Start

## 1. Download

```bash
# Linux
curl -fsSL https://github.com/mova-compact/mova-downloads/releases/latest/download/mova-compact-linux -o mova-compact
chmod +x mova-compact
sudo mv mova-compact /usr/local/bin/mova-compact

# macOS
curl -fsSL https://github.com/mova-compact/mova-downloads/releases/latest/download/mova-compact-macos -o mova-compact
chmod +x mova-compact
sudo mv mova-compact /usr/local/bin/mova-compact

# Windows PowerShell
Invoke-WebRequest -Uri "https://github.com/mova-compact/mova-downloads/releases/latest/download/mova-compact.exe" -OutFile ".\mova-compact.exe"

# Optional checksum file
curl -fsSL https://github.com/mova-compact/mova-downloads/releases/latest/download/SHA256SUMS.txt -o SHA256SUMS.txt
```

## 2. Connect to your agent (semantic stream -> compact)

```bash
# Your agent should emit one JSON object per line to stdout.
# Pipe that stream directly to MOVA Compact:
python my_agent_with_mova_adapter.py | mova-compact collect --run-dir runs/demo --run-id demo-001 --input -
```

Minimal semantic event shape emitted by agent adapter:

```json
{"run_id":"demo-001","actor_id":"agent_main","ts_ms":1735732800000,"dur_ms":12,"action_code":2,"tool_name":"file_search","result_code":1,"subject_ref":"tool://file_search"}
```

## 3. Expand, join, verify

```bash
# Expand compact to JSONL
mova-compact expand --run-dir runs/demo

# Join with time events
mova-compact join --run-dir runs/demo --time otel_time.jsonl

# Verify integrity
mova-compact verify --run-dir runs/demo
```

## 4. OTel time-axis integration

```bash
# Export OTel-derived timeline to JSONL, then join:
python export_otel_jsonl.py --service my-agent --out otel_time.jsonl
mova-compact join --run-dir runs/demo --time otel_time.jsonl
```

## 5. Claude and Codex connectors

```bash
# Claude / Anthropic connector demo
python connectors/anthropic/anthropic_connector_demo.py | mova-compact collect --run-dir runs/claude --run-id claude-001 --input -

# Codex / OpenAI connector demo
python connectors/openai/openai_connector_demo.py | mova-compact collect --run-dir runs/codex --run-id codex-001 --input -
```

Connector sources:
- Claude / Anthropic: https://github.com/mova-compact/mova/tree/main/connectors/anthropic
- Codex / OpenAI: https://github.com/mova-compact/mova/tree/main/connectors/openai

## 6. Inspect output

```bash
cat runs/demo/reports/merged_journal.jsonl | head -3
cat runs/demo/reports/summary.json
```
