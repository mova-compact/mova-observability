# Quick Start

## 1. Download

```bash
# Linux/macOS
curl -fsSL https://github.com/mova-compact/mova-compact/releases/latest/download/mova-compact-linux.zip -o mova-compact.zip
unzip mova-compact.zip && chmod +x mova-compact

# Windows PowerShell
Invoke-WebRequest -Uri "https://github.com/mova-compact/mova-compact/releases/latest/download/mova-compact-windows.zip" -OutFile mova-compact.zip
Expand-Archive mova-compact.zip -DestinationPath .
```

## 2. Run a demo

```bash
# Start a new observation run
./mova-compact observe start --run-dir runs/demo --run-id demo-001

# Record semantic events
./mova-compact observe record --run-dir runs/demo --input semantic_input.jsonl

# Finish observation
./mova-compact observe finish --run-dir runs/demo

# Expand compact to JSONL
./mova-compact expand --run-dir runs/demo

# Join with time events
./mova-compact join --run-dir runs/demo --time otel_time.jsonl

# Verify integrity
./mova-compact verify --run-dir runs/demo
```

## 3. Inspect output

```bash
cat runs/demo/reports/merged_journal.jsonl | head -3
cat runs/demo/reports/summary.json
```
