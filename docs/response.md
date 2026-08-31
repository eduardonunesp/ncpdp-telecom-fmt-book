# Responses

The NCPDP telecom standard uses a **request-response** model. A pharmacy submits a request (e.g., a B1 claim), and the payer returns a **response** containing the adjudication result. This page documents the response side of the exchange.

## Response Structure

A response is structurally identical to a request: a fixed-length **header** followed by **segments**. The difference is the segment IDs used. Response segments use IDs **20–29** (see [Segment Reference](segments-reference.md)).

The response header uses the same fixed-length layout as the request header (see [Headers](headers.md)):

| Field | Length | Description |
|-------|--------|-------------|
| BIN Number | 6 | Processor identification number |
| Version/Release Number | 2 | NCPDP standard version |
| Transaction Code | 2 | Transaction type (e.g., `B1`) |
| Processor Control Number | 10 | Control number for the transaction |
| Transaction Count | 1 | Number of transactions (typically `1`) |
| Service Provider ID Qualifier | 2 | Qualifier for the service provider ID |
| Service Provider ID | 15 | Pharmacy or provider identifier |
| Date of Service | 8 | Service date in `YYYYMMDD` format |
| Software Vendor/Certification ID | 10 | ID of the pharmacy system software |

## Response Segments

The most important response segments are:

| ID | Segment | Purpose |
|----|---------|---------|
| 20 | Response Message | Free-text message from the payer |
| 21 | Response Status | Adjudication status, reject codes, authorization number |
| 22 | Response Claim | Claim-level response (e.g., preferred products) |
| 23 | Response Pricing | Amounts paid, copay, deductible, benefit stage |
| 24 | Response DUR/PPS | DUR/PPS response codes and messages |
| 25 | Response Insurance | Payer/plan identification |
| 26 | Response Prior Authorization | Prior authorization decision |
| 28 | Response Coordination of Benefits | Other-payer details |
| 29 | Response Patient | Patient name/DOB echoed back |

## Response Status (21)

The **Response Status** segment is the heart of the adjudication result. Its key fields:

| Field ID | Name | Description |
|----------|------|-------------|
| AN | Response Status | Overall status code. Common values: `A` = Approved, `C` = Captured, `D` = Duplicate, `E` = Error, `P` = Paid, `R` = Rejected. |
| F3 | Authorization Number | The authorization/approval number assigned by the payer when the claim is approved. |
| FA | Reject Count | The number of reject codes (field FB) that follow. A count field preceding a repeating group. |
| FB | Reject Code | A code explaining why the claim was rejected. Repeats according to the count in field FA. |
| 4F | Reject Field Occurrence Indicator | Identifies which occurrence of a repeating field caused the rejection. |
| 5F | Approved Message Code Count | The number of approved message codes (field 6F) that follow. |
| 6F | Approved Message Code | A code providing additional information about an approved claim. |
| 8F | Help Desk Phone Number | A phone number the pharmacy can call for help with the claim. |
| K5 | Transaction Reference Number | Echoes the transaction reference number to match the response to the request. |

### Reject Codes

Reject codes are the primary way a payer tells a pharmacy why a claim was not approved. Each reject code is a short alphanumeric code; the payer's documentation defines the exact meaning. Common categories include:

- **Invalid/missing data** — a required field was absent or malformed
- **Patient not eligible** — the cardholder or patient is not covered on the plan
- **Product not covered** — the drug is not on the plan's formulary
- **Prior authorization required** — the claim needs a prior authorization before it can be paid
- **Refill too soon** — the prescription is being refilled before the allowed date

## Response Pricing (23)

The **Response Pricing** segment reports what the payer actually paid and how the amount was calculated. Key fields:

| Field ID | Name | Description |
|----------|------|-------------|
| F5 | Gross Amount Due | The gross amount the payer will pay. |
| F6 | Ingredient Cost Paid | The amount paid for the drug ingredient(s). |
| F7 | Dispensing Fee Paid | The amount paid for the dispensing fee. |
| F9 | Total Amount Paid | The total amount the payer will reimburse the pharmacy. |
| FI | Amount of Copay | The patient's copay amount. |
| FC | Accumulated Deductible Amount | The patient's accumulated deductible. |
| FD | Remaining Deductible Amount | The patient's remaining deductible. |
| FE | Remaining Benefit Amount | The patient's remaining benefit amount. |
| FM | Basis of Reimbursement Determination | The pricing benchmark used for reimbursement. |
| MU | Benefit Stage Count | The number of benefit stage groups that follow. |
| MV | Benefit Stage Qualifier | Qualifier for the benefit stage (e.g., coverage gap). |
| MW | Benefit Stage Amount | The amount associated with the benefit stage. |

## A Worked Request → Response Example

Here is a simplified B1 claim request and the corresponding response.

### Request (B1 Claim)

```
&lt;RS&gt;&lt;FS&gt;AM07&lt;FS&gt;EM1&lt;FS&gt;D2000000123456&lt;FS&gt;E103&lt;FS&gt;D700003089421&lt;FS&gt;E70000030000&lt;FS&gt;D301&lt;FS&gt;D5030&lt;FS&gt;D80&lt;FS&gt;DE20210701&lt;FS&gt;DJ3&lt;FS&gt;C800&lt;FS&gt;DT3&lt;FS&gt;28EA
&lt;RS&gt;&lt;FS&gt;AM11&lt;FS&gt;D90000057A&lt;FS&gt;DC0000027E&lt;FS&gt;DX0000016B&lt;FS&gt;DQ00000000&lt;FS&gt;DU0000084F&lt;FS&gt;DN07
```

### Response (Approved)

```
&lt;RS&gt;&lt;FS&gt;AM21&lt;FS&gt;ANA&lt;FS&gt;F31234567890&lt;FS&gt;5F1&lt;FS&gt;6F00
&lt;RS&gt;&lt;FS&gt;AM23&lt;FS&gt;F500000846F&lt;FS&gt;F600000571A&lt;FS&gt;F70000027E&lt;FS&gt;F900000846F&lt;FS&gt;FI0000016B&lt;FS&gt;FM01
```

Decoded:

| Segment | Field | Value | Meaning |
|---------|-------|-------|---------|
| Response Status (21) | AN | `A` | Approved |
| | F3 | `1234567890` | Authorization Number |
| | 5F | `1` | One approved message code follows |
| | 6F | `00` | Approved message code |
| Response Pricing (23) | F5 | `000000846F` | Gross Amount Due = 8.46 |
| | F6 | `000000571A` | Ingredient Cost Paid = 5.71 |
| | F7 | `00000027E` | Dispensing Fee Paid = 2.75 |
| | F9 | `000000846F` | Total Amount Paid = 8.46 |
| | FI | `0000016B` | Amount of Copay = 1.62 |
| | FM | `01` | Basis of Reimbursement Determination |

> **Note:** The monetary fields in the response use the same [signed overpunch](data-types.md) encoding as the request. For example, `000000846F` decodes to 8.46 (F = positive 6).

### Response (Rejected)

```
&lt;RS&gt;&lt;FS&gt;AM21&lt;FS&gt;ANR&lt;FS&gt;FA1&lt;FS&gt;FB77&lt;FS&gt;4F00
```

Decoded:

| Segment | Field | Value | Meaning |
|---------|-------|-------|---------|
| Response Status (21) | AN | `R` | Rejected |
| | FA | `1` | One reject code follows |
| | FB | `77` | Reject code (e.g., "Refill too soon") |
| | 4F | `00` | Reject field occurrence indicator |

## See Also

- [Transactions](transactions.md) — The request-response model
- [Segment Reference](segments-reference.md) — All response segment field mappings
- [Field Reference](field-reference.md) — Detailed descriptions of the B1 claim fields
- [Data Types](data-types.md) — Signed overpunch and other encodings
- [Repeating Fields](repeating-fields.md) — Count fields and repeating groups (used by reject codes)

---

*Field mappings sourced from the [dzero](https://github.com/apiv/dzero) NCPDP Telecom Standard D.0 reference implementation.*
