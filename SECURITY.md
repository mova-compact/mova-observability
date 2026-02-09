# Security Policy

## Design Principles

- **Zero network calls** — all processing is local
- **No telemetry** — no data leaves your machine
- **Integrity-first** — SHA256 verification on all inputs and outputs
- **Fail-fast** — any integrity mismatch is a hard error, not a warning
- **Deterministic** — identical input always produces identical output (hash-verifiable)

## Security Gates (Built-in)

1. **Structure gate** — validates manifest, run artifacts, and directory layout
2. **Integrity gate** — SHA256 hash check on every input and output file
3. **Runtime gate** — duplicate detection, timestamp monotonicity enforcement
4. **Sanity controls** — shift/shuffle negative tests must degrade coverage (anti-self-deception)
5. **Release gate** — negative control results required before any release

## Binary Verification

Every release includes SHA256 checksums in `checksums/SHA256SUMS.txt`.

Verify after download:

```bash
# Linux/macOS
sha256sum -c SHA256SUMS.txt

# Windows PowerShell
Get-FileHash mova-compact.exe -Algorithm SHA256
```

## Reporting Vulnerabilities

If you discover a security issue, please report it responsibly by emailing the maintainers directly. Do not open a public issue for security vulnerabilities.
