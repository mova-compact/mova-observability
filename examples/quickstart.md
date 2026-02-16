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

## 2. Quick sanity

```bash
mova-compact -h
mova-compact collect -h
```

## 3. Connect to your agent (semantic stream -> compact)

```bash
# Codex / OpenAI connector (copy-paste pipeline)
python connectors/openai/openai_connector_demo.py \
  | mova-compact collect --run-dir runs/o1 --run-id o1 --input - --strict
```

Minimal semantic event shape emitted by agent adapter:

```json
{"run_id":"demo-001","actor_id":"agent_main","ts_ms":1735732800000,"dur_ms":12,"action_code":2,"tool_name":"file_search","result_code":1,"subject_ref":"tool://file_search"}
```

## 4. Expand compact payload

```bash
mova-compact expand --run-dir runs/o1
```

## 5. OTel time-axis integration

```bash
# Export OTel-derived timeline to JSONL
python export_otel_jsonl.py --service my-agent --out otel_time.jsonl
```

## 6. Join and verify

```bash
# Join semantic axis with OTel time axis
mova-compact join --run-dir runs/o1 --time otel_time.jsonl

# Verify integrity + determinism checks
mova-compact verify --run-dir runs/o1
```

## 7. Connector references

```bash
# Claude / Anthropic
python connectors/anthropic/anthropic_connector_demo.py
# Codex / OpenAI
python connectors/openai/openai_connector_demo.py
```

Connector sources:
- Connector pack download: https://github.com/mova-compact/mova-downloads/releases/latest/download/mova-connectors-python.zip

## 8. Inspect output

```bash
cat runs/o1/outputs/final_observation.jsonl | head -3
cat runs/o1/outputs/summary.json
cat runs/o1/outputs/sanity_controls.json
```

## 9. PASS criteria

- `mova-compact verify` returns `status: ok`
- `outputs/summary.json`: `coverage` close to `1.0`, `unmatched_semantic = 0`, `unmatched_time = 0`
- `outputs/sanity_controls.json`: `gate_passed = true`

## 10. Codex one-shot task

```bash
codex exec "Read this landing runbook, run MOVA quickstart end-to-end in /tmp/mova_eval, and report:
1) verify status
2) coverage from outputs/summary.json
3) gate_passed from outputs/sanity_controls.json
4) any command mismatch in the docs."
```
