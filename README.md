# NCPDP Telecom Format

A study guide for the NCPDP telecommunication standard for pharmacy claims — how pharmacy claims are structured, transmitted, and parsed.

HIPAA mandates the NCPDP telecom standard (and the related batch standard) for pharmacy drug claim submission. If you work with pharmacy data, you will encounter NCPDP.

## Contents

This is a documentation-only repository. All content is Markdown rendered into a static site by [HonKit](https://github.com/honkit/honkit) (a GitBook fork). Source lives in [`docs/`](docs/); the table of contents is [`docs/SUMMARY.md`](docs/SUMMARY.md).

| Section | What it covers |
|---------|----------------|
| [Overview](docs/intro.md) | A walkthrough of a real claim |
| [Separators](docs/separators.md) | Non-printable ASCII delimiters (`RS`, `FS`, `STX`, `ETX`) |
| [Fields](docs/fields.md) | 2-character field identifiers and how to read them |
| [Segments](docs/segments.md) | Logical groups of fields (patient, claim, pricing) |
| [Transactions](docs/transactions.md) | How segments combine into a complete transaction |
| [Headers](docs/headers.md) | Fixed-length transaction header — batch vs telecom |
| [Data Types](docs/data-types.md) | Strings, dates, integers, decimals, signed overpunch |
| [Repeating Fields](docs/repeating-fields.md) | Repeating fields and groups |
| [Field Reference](docs/field-reference.md) | Every field in the B1 claim |
| [Segment Reference](docs/segments-reference.md) | Every segment type (01–16 request, 20–29 response) |
| [Responses](docs/response.md) | Status, reject codes, and pricing |
| [B1 Claim Example](docs/examples/b1-claim.md) | A complete B1 claim, raw NCPDP and decoded |

## Quick start

```sh
make install   # npm install
make serve     # build, then serve at http://localhost:4000
```

Or without Make:

```sh
npm install
npx honkit serve docs
```

## Build

```sh
make build     # static site -> docs/_book/
```

The build output (`docs/_book/`) is gitignored — never edit it by hand.

## Docker

Build and serve the documentation in a lightweight container:

```sh
make docker-build   # build the Docker image
make docker-run     # run on http://localhost:8080
make docker         # build + run in one step
```

The image uses a two-stage build — HonKit compiles in a Node stage, then only the static HTML is copied into an Alpine + nginx image (~10 MB).

To stop and remove the container:

```sh
docker rm -f ncpdp-docs
```

## Project layout

```
docs/              Markdown source for the book
  SUMMARY.md       Table of contents (source of truth for page order)
  book.json        HonKit configuration
  _book/           Build output (gitignored)
Makefile           install / serve / build / docker / clean targets
Dockerfile         two-stage Docker build (Node -> Alpine nginx)
nginx.conf         nginx config for the container
package.json       private; HonKit only
docs.yaml          GitBook.com sync config (not for local builds)
```

## License

This is a study guide. Source attribution is on the [Overview](docs/intro.md) page.