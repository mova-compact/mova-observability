# MOVA Compact Overview

MOVA Compact is a **Dual Observability Pack** that deterministically joins time-axis and semantic-axis event streams into a single evidence-grade journal.

## Problem

- Time-based logs alone don't explain the **intent** behind each step
- Semantic logs without timing don't reveal **delay causes**
- Engineers need correlated evidence: what happened AND when AND whether it's trustworthy

## Solution

MOVA Compact takes two JSONL inputs (time events + semantic events), correlates them by `run_id` and `step_id`, and produces a merged evidence journal with confidence scores.

## Key Properties

| Property | Guarantee |
|----------|-----------|
| Determinism | Same input → same output (SHA256 verified) |
| Compression | 13.81x-16.18x on published proof runs |
| Integrity | CRC32 + SHA256 on all artifacts |
| Vendor-agnostic | Vendor-independent contract, validated on Codex + Claude Code |
| Privacy | No network calls, local-only processing |

## Output Artifacts

Each run produces:
- `outputs/final_observation.jsonl` — final correlated evidence rows
- `outputs/summary.json` — coverage and deterministic KPI summary
- `outputs/sanity_controls.json` — negative control gate result
- `outputs/determinism.sha256` — deterministic hash checkpoint
- `outputs/compact_expanded.jsonl` — expanded compact rows
