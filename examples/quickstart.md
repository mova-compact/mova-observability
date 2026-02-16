# Quick Start (Sequential)

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
# Option A: Claude / Anthropic connector
python connectors/anthropic/anthropic_connector_demo.py \
  | mova-compact collect --run-dir runs/demo --run-id demo-001 --input -

# Option B: Codex / OpenAI connector
# python connectors/openai/openai_connector_demo.py \
#   | mova-compact collect --run-dir runs/demo --run-id demo-001 --input -
```

Minimal semantic event shape emitted by agent adapter:

```json
{"run_id":"demo-001","actor_id":"agent_main","ts_ms":1735732800000,"dur_ms":12,"action_code":2,"tool_name":"file_search","result_code":1,"subject_ref":"tool://file_search"}
```

## 3. Expand compact payload

```bash
mova-compact expand --run-dir runs/demo
```

## 4. OTel time-axis integration

```bash
# Export OTel-derived timeline to JSONL
python export_otel_jsonl.py --service my-agent --out otel_time.jsonl
```

## 5. Join and verify

```bash
# Join semantic axis with OTel time axis
mova-compact join --run-dir runs/demo --time otel_time.jsonl

# Verify integrity + determinism checks
mova-compact verify --run-dir runs/demo
```

## 6. Connector references

```bash
# Claude / Anthropic
python connectors/anthropic/anthropic_connector_demo.py
# Codex / OpenAI
python connectors/openai/openai_connector_demo.py
```

Connector sources:
- Connector pack download: https://github.com/mova-compact/mova-downloads/releases/latest/download/mova-connectors-python.zip

## 7. Inspect output

```bash
cat runs/demo/reports/merged_journal.jsonl | head -3
cat runs/demo/reports/summary.json
```
