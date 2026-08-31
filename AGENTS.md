# AGENTS.md

Documentation-only repo for the NCPDP Telecom Format (pharmacy claims standard). No application code — content is Markdown rendered by HonKit.

## Commands

- `make install` — `npm install` (deps are HonKit only)
- `make serve` — builds then serves the book at http://localhost:4000 (HonKit default)
- `make build` — builds static site to `docs/_book/`
- `make clean` — removes `docs/_book/` and `node_modules/`
- `npm run serve` / `npm run build` — equivalents without Make

There is no linter, typecheck, or test suite. Verification = `make build` succeeds and the served book renders.

## Structure

- All content lives in `docs/`. `docs/SUMMARY.md` is the table of contents and the source of truth for page order — add new pages there or they won't appear in the book.
- `docs/book.json` + `docs/.gitbook.yaml` configure HonKit/GitBook. `docs.yaml` at root is for GitBook.com sync, not local builds.
- `docs/_book/` is the build output (gitignored) — never edit by hand.
- Root `package.json` is `private: true`; nothing is published.

## Content conventions

- NCPDP uses non-printable ASCII separators. HonKit/GitBook treats angle-bracket notation like `<FS>` as HTML tags and strips them. **Always use HTML entities**: write `&lt;STX&gt;`, `&lt;ETX&gt;`, `&lt;RS&gt;`, `&lt;FS&gt;`, `&lt;GS&gt;` — never bare `<FS>` etc. This applies everywhere: prose, tables, headings, and code blocks.
- Field identifiers are 2-char codes (e.g. `AM`, `C2`); segment identifiers are 2-char (e.g. `G1`, `AM`); transaction codes are 2-char (e.g. `B1` claim, `B2` reversal). Keep this casing exact.
- The B1 claim in `docs/examples/b1-claim.md` is the canonical worked example — update it together with `docs/intro.md` and `docs/field-reference.md` so they stay consistent.
- Cross-references between pages use relative `.md` paths (HonKit resolves them); from a subfolder use `../` (see `docs/examples/b1-claim.md`).

## Gotchas

- `package-lock.json` is gitignored but present on disk — don't commit it.
- HonKit (GitBook fork) is unmaintained upstream; treat plugin/formatter quirks as fixed. Don't try to upgrade HonKit without reason.
- `make serve` depends on `make build` (the `serve: build` rule); if you skip the Makefile and run `npx honkit serve docs` directly, note the arg is the `docs` directory, not a config path.