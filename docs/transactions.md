# Transactions

A **transaction** is a group of segments that convey information related to a single use case, such as a pharmacy claim submission or a claim reversal.

## Transaction Codes

Each NCPDP transaction is assigned a **two-character code** that identifies its purpose:

| Code | Name | Description |
|------|------|-------------|
| B1 | Claim Billing | Submit a pharmacy claim for adjudication |
| B2 | Claim Reversal | Reverse a previously submitted claim |
| B3 | Reversal (Resubmission) | Resubmit a previously reversed claim |
| D0 | Prior Authorization | Request prior authorization for a prescription |
| D1 | Prior Authorization Response | Response to a prior authorization request |
| E1 | Eligibility Inquiry | Check a patient's eligibility |
| E2 | Eligibility Response | Response to an eligibility inquiry |

> **Note:** The transaction code appears in the transaction header. When you know the transaction code, you know which segments are expected to follow — the standard defines the required and optional segments for each transaction type.

In addition to these telecom transactions, NCPDP has developed the **Real-Time Pharmacy Benefit Inquiry (RTPBI)** — a prescriber-to-payer transaction that occurs before a prescription is written. RTPBI is a separate standard with its own transaction structure. See [Real-Time Pharmacy Benefit Inquiry](rtpbi.md).

## Transaction Structure

A complete NCPDP transaction consists of:

1. **Transaction header** — fixed-length fields (no separators) containing metadata
2. **One or more segments** — each starting with `&lt;RS&gt;` and containing `&lt;FS&gt;`-delimited fields

In batch mode, the transaction is also wrapped with `&lt;STX&gt;` (STX) and `&lt;ETX&gt;` (ETX) separators.

### Example: B1 Claim Transaction

```
&lt;STX&gt;G11234567890123456D1B101        1234567890123     202108210000000100	
&lt;RS&gt;&lt;FS&gt;AM04&lt;FS&gt;C2123456789&lt;FS&gt;CCJANE&lt;FS&gt;CDDOE&lt;FS&gt;FOMYPLAN&lt;FS&gt;C90&lt;FS&gt;C1GR1&lt;FS&gt;C3001&lt;FS&gt;C62	
&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C419800225&lt;FS&gt;C52&lt;FS&gt;CAJANE&lt;FS&gt;CBDOE&lt;FS&gt;CM100 MAIN STR&lt;FS&gt;CNWASHINGTON&lt;FS&gt;CODC&lt;FS&gt;CP100010000&lt;FS&gt;CQ5551234567&lt;GS&gt;
&lt;RS&gt;&lt;FS&gt;AM07&lt;FS&gt;EM1&lt;FS&gt;D2000000123456&lt;FS&gt;E103&lt;FS&gt;D700003089421&lt;FS&gt;E70000030000&lt;FS&gt;D301&lt;FS&gt;D5030&lt;FS&gt;D80&lt;FS&gt;DE20210701&lt;FS&gt;DJ3&lt;FS&gt;C800&lt;FS&gt;DT3&lt;FS&gt;28EA	
&lt;RS&gt;&lt;FS&gt;AM11&lt;FS&gt;D90000057A&lt;FS&gt;DC0000027E&lt;FS&gt;DX0000016B&lt;FS&gt;DQ00000000&lt;FS&gt;DU0000084F&lt;FS&gt;DN07	
&lt;RS&gt;&lt;FS&gt;AM03&lt;FS&gt;EZ01&lt;FS&gt;DB1234567890&lt;FS&gt;DREVIL&lt;FS&gt;PM5557654321&lt;ETX&gt;
```

Breaking this transaction into its components:

| Part | Content |
|------|---------|
| Header | `G11234567890123456D1B101...000000100` |
| Insurance Segment | `&lt;RS&gt;&lt;FS&gt;AM04&lt;FS&gt;C2...&lt;FS&gt;C62` |
| Patient Segment | `&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C4...&lt;FS&gt;CQ5551234567` |
| Claim Segment | `&lt;RS&gt;&lt;FS&gt;AM07&lt;FS&gt;EM1...&lt;FS&gt;28EA` |
| Pricing Segment | `&lt;RS&gt;&lt;FS&gt;AM11&lt;FS&gt;D9...&lt;FS&gt;DN07` |
| Prescriber Segment | `&lt;RS&gt;&lt;FS&gt;AM03&lt;FS&gt;EZ01...&lt;FS&gt;PM5557654321` |

## Transaction Header

The header is always the first part of a transaction and uses **fixed-length fields** (no separators). It contains:

- Transaction code (e.g., `B1`)
- BIN number
- Version/release number
- Service provider ID
- Date of service
- Software vendor certification ID

See [Headers](headers.md) for a detailed breakdown.

## Request-Response Model

The NCPDP telecom standard uses a **request-response** model:

1. A **request** contains a single transaction (e.g., a B1 claim)
2. The **response** from the payer contains the adjudication result

> **Warning:** The telecom standard assumes only one transaction per transmission. To transmit multiple transactions, use the NCPDP **batch standard**, which wraps each transaction with headers and trailers.

## Batch Transactions

When using the batch standard, each transaction in a batch file is enclosed by `&lt;STX&gt;` (STX) and `&lt;ETX&gt;` (ETX) separators. A batch file also includes:

- A **batch header** at the beginning (`&lt;STX&gt;00T...&lt;ETX&gt;`)
- A **batch trailer** at the end (`&lt;STX&gt;99...&lt;ETX&gt;`)

### Transmission Structure

A batch file is a **transmission** made up of **records**. Each record is a fixed-width block delimited by `&lt;STX&gt;` (start) and `&lt;ETX&gt;` (end):

| Record | Identifier | Purpose |
|--------|-----------|---------|
| Transmission Header | `00T` | Batch-level metadata (sender, receiver, date/time) |
| Transaction Detail | `G1` | A single transaction: header + segments |
| Transmission Trailer | `99` | Batch-level counts and message |

The transaction detail record (`G1`) contains the fixed-width transaction header followed by the `&lt;RS&gt;`/`&lt;FS&gt;`-delimited segments. See [Headers](headers.md) for the exact fixed-width layouts of the transmission header and trailer.

Full batch example:

```
&lt;STX&gt;00T123456789               2021123456789123456P1234567WPS0000000         &lt;ETX&gt;
&lt;STX&gt;G11234567890123456D1B101        1234567890123     202108210000000100	
&lt;RS&gt;&lt;FS&gt;AM04&lt;FS&gt;C2123456789&lt;FS&gt;CCJANE&lt;FS&gt;CDDOE&lt;FS&gt;FOMYPLAN&lt;FS&gt;C90&lt;FS&gt;C1GR1&lt;FS&gt;C3001&lt;FS&gt;C62	
&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C419800225&lt;FS&gt;C52&lt;FS&gt;CAJANE&lt;FS&gt;CBDOE&lt;FS&gt;CM100 MAIN STR&lt;FS&gt;CNWASHINGTON&lt;FS&gt;CODC&lt;FS&gt;CP100010000&lt;FS&gt;CQ5551234567&lt;GS&gt;
&lt;RS&gt;&lt;FS&gt;AM07&lt;FS&gt;EM1&lt;FS&gt;D2000000123456&lt;FS&gt;E103&lt;FS&gt;D700003089421&lt;FS&gt;E70000030000&lt;FS&gt;D301&lt;FS&gt;D5030&lt;FS&gt;D80&lt;FS&gt;DE20210701&lt;FS&gt;DJ3&lt;FS&gt;C800&lt;FS&gt;DT3&lt;FS&gt;28EA	
&lt;RS&gt;&lt;FS&gt;AM11&lt;FS&gt;D90000057A&lt;FS&gt;DC0000027E&lt;FS&gt;DX0000016B&lt;FS&gt;DQ00000000&lt;FS&gt;DU0000084F&lt;FS&gt;DN07	
&lt;RS&gt;&lt;FS&gt;AM03&lt;FS&gt;EZ01&lt;FS&gt;DB1234567890&lt;FS&gt;DREVIL&lt;FS&gt;PM5557654321&lt;ETX&gt;
&lt;STX&gt;9920211840000005162END Dyl B1                         &lt;ETX&gt;
```

## Segments Per Transaction

The NCPDP standard defines which segments are required and which are optional for each transaction type. Segments **do not repeat** — there can be only one segment with a given ID per transaction.

For the B1 (Claim Billing) transaction:

| Segment | ID | Required |
|---------|----|----------|
| Insurance | 04 | Yes |
| Patient | 01 | Conditional |
| Claim | 07 | Yes |
| Pricing | 11 | Yes |
| Prescriber | 03 | Conditional |

## See Also

- [Headers](headers.md) — Transaction header format and field reference
- [Segments](segments.md) — Detailed segment structure and field lists
- [Segment Reference](segments-reference.md) — Every segment type and its fields
- [Response](response.md) — The response side of the request-response model
- [Field Reference](field-reference.md) — Complete descriptions of every B1 claim field
- [Examples: B1 Claim](examples/b1-claim.md) — Full decoded example
- [Real-Time Pharmacy Benefit Inquiry](rtpbi.md) — Prescriber-to-payer benefit inquiry (separate standard)

---

*Source: [Healthcare Data Insight — NCPDP Telecom Format for Mere Mortals](https://datainsight.health/ncpdp/intro/)*