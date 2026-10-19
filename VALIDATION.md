# Validation

Validated from this standalone package on 2026-10-19 (Asia/Shanghai).

| Command | Result |
|---|---|
| `swift build` | PASS |
| `swift run orbitdock-utilities-checks` | 12 regression cases passed |
| `swift run orbitdock-utilities-demo` | PASS |

The selected source and adapted regression cases depend only on Foundation and
the Swift standard library. The check program reports failures through a nonzero
process exit; it does not require the XCTest module or the full commercial project.
Cases cover daylight-saving changes, half/quarter-hour offsets, malformed input,
style bounds, incomplete badge samples and baseline/attention transitions.
This validates only the published utilities, not the commercial OrbitDock app.
