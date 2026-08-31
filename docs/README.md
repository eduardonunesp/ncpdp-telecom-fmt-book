# NCPDP Telecom Format

**NCPDP** (National Council for Prescription Drug Programs) telecommunication standard specifies the format of pharmacy claims and other pharmacy-related transactions.

This documentation is a study guide for understanding the NCPDP telecom format — how pharmacy claims are structured, transmitted, and parsed.

## Why NCPDP Matters

[HIPAA mandates](https://www.cms.gov/Regulations-and-Guidance/Administrative-Simplification/HIPAA-ACA/AdoptedStandardsandOperatingRules) the use of the NCPDP telecom standard (and the related batch standard) for pharmacy drug claim submission. If you work with pharmacy data, you will encounter NCPDP.

## At a Glance

| Concept | Description |
|---------|-------------|
| **Transaction** | A single request-response exchange (e.g., a pharmacy claim) |
| **Segment** | A group of logically related fields (e.g., patient, claim, pricing) |
| **Field** | A single piece of data identified by a 2-character code |
| **Separator** | Non-printable ASCII characters that delimit segments and fields |

## Where to Start

> **Note:** New to NCPDP? Start with the [Overview](intro.md) for a quick walkthrough of a real claim.

### Context

| Page | What You'll Learn |
|------|-------------------|
| [Healthcare Industry Context](healthcare-context.md) | Where NCPDP fits in the broader healthcare system — industry segments, health system models, and the pharmacy claims pipeline |
| [Pharmacy Benefit Managers](pbms.md) | What PBMs do, how they adjudicate claims, and their role in the pharmacy supply chain |
| [Real-Time Pharmacy Benefit Inquiry](rtpbi.md) | How prescribers query patient benefit information before writing a prescription |

### Concepts

| Page | What You'll Learn |
|------|-------------------|
| [Separators](separators.md) | The non-printable characters (RS, FS, STX, ETX) that structure NCPDP data |
| [Fields](fields.md) | How fields are identified by 2-character codes and how to read them |
| [Segments](segments.md) | How fields are grouped into logical segments (patient, claim, etc.) |
| [Transactions](transactions.md) | How segments combine to form a complete transaction |
| [Headers](headers.md) | The fixed-length transaction header — batch vs telecom flavors |
| [Data Types](data-types.md) | Strings, dates, integers, decimals, and the signed overpunch encoding |
| [Repeating Fields](repeating-fields.md) | How NCPDP handles repeating fields and groups |

### Reference

| Page | What You'll Learn |
|------|-------------------|
| [Field Reference](field-reference.md) | Detailed descriptions of every field in B1 claim segments and headers |
| [Segment Reference](segments-reference.md) | Every segment type (01–16 request, 20–29 response) and its fields |

### Responses

| Page | What You'll Learn |
|------|-------------------|
| [Responses](response.md) | The response side of the request-response model — status, reject codes, and pricing |

### Examples

| Page | What You'll See |
|------|-----------------|
| [Pharmacy Claim (B1)](examples/b1-claim.md) | A complete B1 claim in both raw NCPDP and decoded JSON |

---

*Source: [Healthcare Data Insight — NCPDP Basics](https://datainsight.health/ncpdp/intro/)*