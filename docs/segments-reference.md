# Segment Reference

This page catalogs every segment type defined by the NCPDP telecom standard, based on the field mappings in the [dzero](https://github.com/apiv/dzero) and [higher-pixels/ncpdp](https://github.com/higher-pixels/ncpdp) reference implementations (NCPDP Telecom Standard D.0). It complements the [Segments](segments.md) concept page, which walks through the B1 claim segments in detail.

> **Note:** Field names below follow the canonical D.0 naming used by dzero. Some names differ slightly from the D.1-era names used elsewhere in this guide (e.g., `CN` = Patient City). The two-character field identifiers are the authoritative key. Where available, the **Ref** column shows the official NCPDP field reference number (e.g., `111-AM`, `455-EM`).

## Segment ID Overview

Each segment is identified by the value of its `AM` field. Request segments (01–16) appear in a submitted transaction; response segments (20–29) appear in the payer's reply.

| ID | Segment | Direction | Purpose |
|----|---------|-----------|---------|
| 01 | Patient | Request | Patient demographics |
| 02 | Pharmacy Provider | Request | Submitting pharmacy identification |
| 03 | Prescriber | Request | Prescribing provider identification |
| 04 | Insurance | Request | Cardholder and plan information |
| 05 | Coordination of Benefits | Request | Other-payer / COB information |
| 06 | Workers' Compensation | Request | Workers' comp claim details |
| 07 | Claim | Request | Prescription and drug details |
| 08 | DUR/PPS | Request | Drug utilization review / prospective drug use review |
| 09 | Coupon | Request | Coupon or discount information |
| 10 | Compound | Request | Compound medication ingredients |
| 11 | Pricing | Request | Financial details of the claim |
| 12 | Prior Authorization | Request | Prior authorization request details |
| 13 | Clinical | Request | Clinical information (diagnoses, measurements) |
| 14 | Additional Documentation | Request | Supporting documentation for a claim |
| 15 | Facility | Request | Facility (e.g., long-term care) information |
| 16 | Narrative | Request | Free-text narrative message |
| 20 | Response Message | Response | Free-text message from the payer |
| 21 | Response Status | Response | Adjudication status, reject codes, authorization |
| 22 | Response Claim | Response | Claim-level response (preferred products) |
| 23 | Response Pricing | Response | Amounts paid, copay, deductible, benefit stage |
| 24 | Response DUR/PPS | Response | DUR/PPS response codes and messages |
| 25 | Response Insurance | Response | Payer/plan identification in the response |
| 26 | Response Prior Authorization | Response | Prior authorization decision details |
| 27 | Response Insurance Additional Documentation | Response | Medicare Part D / formulary response |
| 28 | Response Coordination of Benefits | Response | Other-payer details in the response |
| 29 | Response Patient | Response | Patient name/DOB echoed in the response |

## Request Segments

### 01 — Patient

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| CX | 331 | Patient ID Qualifier |
| CY | 332 | Patient ID |
| C4 | 304 | Date of Birth |
| C5 | 305 | Patient Gender Code |
| CA | 310 | Patient First Name |
| CB | 311 | Patient Last Name |
| CM | 322 | Patient Street Address |
| CN | 323 | Patient City |
| CO | 324 | Patient State or Province |
| CP | 325 | Patient ZIP/Postal Code |
| CQ | 326 | Patient Phone Number |
| C7 | 307 | Place of Service |
| CZ | 333 | Employer ID |
| 1C | 334 | Smoker/Non-Smoker Code |
| 2C | 335 | Pregnancy Indicator |
| HN | 350 | Patient Email Address |
| 4X | 384 | Patient Residence |

### 02 — Pharmacy Provider

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| EY | 465 | Provider ID Qualifier |
| E9 | 444 | Provider ID |

### 03 — Prescriber

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| EZ | 466 | Prescriber ID Qualifier |
| DB | 411 | Prescriber ID |
| DR | 427 | Prescriber Last Name |
| PM | 498 | Prescriber Phone Number |
| 2E | 468 | Primary Care Provider ID Qualifier |
| DL | 421 | Primary Care Provider ID |
| 4E | 470 | Primary Care Provider Last Name |
| 2J | 364 | Prescriber First Name |
| 2K | 365 | Prescriber Street Address |
| 2M | 366 | Prescriber City Address |
| 2N | 367 | Prescriber State/Province Address |
| 2P | 368 | Prescriber ZIP/Postal Zone |

### 04 — Insurance

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| C2 | 302 | Cardholder ID |
| CC | 312 | Cardholder First Name |
| CD | 313 | Cardholder Last Name |
| CE | 314 | Home Plan |
| FO | 524 | Plan ID |
| C9 | 309 | Eligibility Clarification Code |
| C1 | 301 | Group ID |
| C3 | 303 | Person Code |
| C6 | 306 | Patient Relationship Code |
| MG | 990 | Other Payer BIN Number |
| MH | 991 | Other Payer Processor Control Number |
| NU | 356 | Other Payer Cardholder ID |
| MJ | 992 | Other Payer Group ID |
| 2A | 359 | Medigap ID |
| 2B | 360 | Medicaid Indicator |
| 2D | 361 | Provider Accept Assignment Indicator |
| G2 | 997 | CMS Part D Defined Qualified Facility |
| N5 | 115 | Medicaid ID Number |
| N6 | 116 | Medicaid Agency Number |

### 05 — Coordination of Benefits

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| 4C | COB Other Payments Count |
| 5C | Other Payer Coverage Type |
| 6C | Other Payer ID Qualifier |
| 7C | Other Payer ID |
| E8 | Other Payer Date |
| A7 | Internal Control Number |
| HB | Other Payer Amount Paid Count |
| HC | Other Payer Amount Paid Qualifier |
| DV | Other Payer Amount Paid |
| 5E | Other Payer Reject Count |
| 6E | Other Payer Reject Code |
| NR | Other Payer Patient Responsibility Amount Count |
| NP | Other Payer Patient Responsibility Amount Qualifier |
| NQ | Other Payer Patient Responsibility Amount |
| MU | Benefit Stage Count |
| MV | Benefit Stage Qualifier |
| MW | Benefit Stage Amount |

### 06 — Workers' Compensation

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| DY | — | Date of Injury |
| CF | — | Employer Name |
| CG | — | Employer Street Address |
| CH | — | Employer City Address |
| CI | — | Employer State/Province Address |
| CJ | — | Employer ZIP/Postal Code |
| CK | — | Employer Phone Number |
| CL | — | Employer Contact Name |
| CR | — | Carrier ID |
| DZ | — | Claim Reference ID |
| TR | — | Billing Entity Type Indicator |
| TS | — | Pay-To Qualifier |
| TT | — | Pay-To ID |
| TU | — | Pay-To Name |
| TV | — | Pay-To Street Address |
| TW | — | Pay-To City Address |
| TX | — | Pay-To State/Province Address |
| TY | — | Pay-To ZIP/Postal Zone |
| TZ | — | Generic Equivalent Product ID Qualifier |
| UA | — | Generic Equivalent Product ID |

### 07 — Claim

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| EM | 455 | Prescription Reference Number Qualifier |
| D2 | 402 | Prescription Reference Number |
| E1 | 436 | Product/Service ID Qualifier |
| D7 | 407 | Product/Service ID |
| EN | 456 | Associated Prescription Reference Number |
| EP | 457 | Associated Prescription Date |
| SE | 458 | Procedure Modifier Code Count |
| ER | 459 | Procedure Modifier Code |
| E7 | 442 | Quantity Dispensed |
| D3 | 403 | Fill Number |
| D5 | 405 | Days Supply |
| D6 | 406 | Compound Code |
| D8 | 408 | Dispense As Written / Product Selection Code |
| DE | 414 | Date Prescription Written |
| DF | 415 | Number of Refills Authorized |
| DJ | 419 | Prescription Origin Code |
| NX | 354 | Submission Clarification Code Count |
| DK | 420 | Submission Clarification Code |
| ET | 460 | Quantity Prescribed |
| C8 | 308 | Other Coverage Code |
| DT | 429 | Special Packaging Indicator |
| EJ | 453 | Originally Prescribed ID Qualifier |
| EA | 445 | Originally Prescribed Code |
| EB | 446 | Originally Prescribed Quantity |
| CW | 330 | Alternate ID |
| EK | 454 | Scheduled Prescription ID Number |
| 28 | 600 | Unit of Measure |
| DI | 418 | Level of Service |
| EU | 461 | Prior Authorization Type Code |
| EV | 462 | Prior Authorization Number Submitted |
| EW | 463 | Intermediary Authorization Type ID |
| EX | 464 | Intermediary Authorization ID |
| HD | 343 | Dispensing Status |
| HF | 344 | Quantity Intended to Be Dispensed |
| HG | 345 | Days Supply Intended to Be Dispensed |
| NV | 357 | Delay Reason Code |
| K5 | 880 | Transaction Reference Number |
| MT | 391 | Patient Assignment Indicator |
| E2 | 995 | Route of Administration |
| G1 | 996 | Compound Type |
| N4 | 114 | Medicaid ICN |
| U7 | 147 | Pharmacy Service Type |

### 08 — DUR/PPS

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| 7E | DUR/PPS Code Counter |
| E4 | Reason for Service Code |
| E5 | Professional Service Code |
| E6 | Result of Service Code |
| 8E | DUR/PPS Level of Effort |
| J9 | DUR Co-Agent ID Qualifier |
| H6 | DUR Co-Agent ID |

### 09 — Coupon

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| KE | Coupon Type |
| ME | Coupon Number |
| NE | Coupon Value Amount |

### 10 — Compound

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| EF | Compound Dosage Form Description Code |
| EG | Compound Dispensing Unit Form Indicator |
| EC | Compound Ingredient Component Count |
| RE | Compound Product ID Qualifier |
| TE | Compound Product ID |
| ED | Compound Ingredient Quantity |
| EE | Compound Ingredient Drug Cost |
| UE | Compound Ingredient Basis of Cost Determination |
| 2G | Compound Ingredient Modifier Code Count |
| 2H | Compound Ingredient Modifier Code |

### 11 — Pricing

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| D9 | 409 | Ingredient Cost Submitted |
| DC | 412 | Dispensing Fee Submitted |
| BE | 477 | Professional Service Fee Submitted |
| DX | 433 | Patient Paid Amount Submitted |
| E3 | 438 | Incentive Amount Submitted |
| H7 | 478 | Other Amount Claimed Submitted Count |
| H8 | 479 | Other Amount Claimed Submitted Qualifier |
| H9 | 480 | Other Amount Claimed Submitted |
| HA | 481 | Flat Sales Tax Amount Submitted |
| GE | 482 | Percentage Sales Tax Amount Submitted |
| HE | 483 | Percentage Sales Tax Rate Submitted |
| JE | 484 | Percentage Sales Tax Basis Submitted |
| DQ | 426 | Usual and Customary Charge |
| DU | 430 | Gross Amount Due |
| DN | 423 | Basis of Cost Determination |
| N3 | 113 | Medicaid Paid Amount |

### 12 — Prior Authorization

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| PA | Request Type |
| PB | Request Period Date Begin |
| PC | Request Period Date End |
| PD | Basis of Request |
| PE | Authorized Representative First Name |
| PF | Authorized Rep Last Name |
| PG | Authorized Rep Street Address |
| PH | Authorized Rep City |
| PJ | Authorized Rep State/Province |
| PK | Authorized Rep ZIP/Postal Code |
| PY | Prior Authorization Number Assigned |
| F3 | Authorization Number |
| PP | Prior Authorization Supporting Documentation |

### 13 — Clinical

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| VE | Diagnosis Code Count |
| WE | Diagnosis Code Qualifier |
| DO | Diagnosis Code |
| XE | Clinical Information Counter |
| ZE | Measurement Date |
| H1 | Measurement Time |
| H2 | Measurement Dimension |
| H3 | Measurement Unit |
| H4 | Measurement Value |

### 14 — Additional Documentation

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| 2Q | Additional Documentation Type ID |
| 2V | Request Period Begin Date |
| 2W | Request Period Recert/Revised Date |
| 2U | Request Status |
| 2S | Length of Need Qualifier |
| 2R | Length of Need |
| 2T | Prescriber/Supplier Date Signed |
| 2X | Supporting Documentation |
| 2Z | Question Number/Letter Count |
| 4B | Question Number/Letter |
| 4D | Question Percent Response |
| 4G | Question Date Response |
| 4H | Question Dollar Amount Response |
| 4J | Question Numeric Response |
| 4K | Question Alphanumeric Response |

### 15 — Facility

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| 8C | Facility ID |
| 3Q | Facility Name |
| 3U | Facility Street Address |
| 5J | Facility City Address |
| 3V | Facility State/Province Address |
| 6D | Facility ZIP/Postal Zone |

### 16 — Narrative

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| BM | Narrative Message |

## Response Segments

### 20 — Response Message

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| F4 | Message |

### 21 — Response Status

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| AN | 112 | Response Status |
| F3 | 503 | Authorization Number |
| FA | 510 | Reject Count |
| FB | 511 | Reject Code |
| 4F | 546 | Reject Field Occurrence Indicator |
| 5F | 547 | Approved Message Code Count |
| 6F | 548 | Approved Message Code |
| UF | 130 | Additional Message Information Count |
| UH | 132 | Additional Message Information Qualifier |
| FQ | 526 | Additional Message Information |
| UG | 131 | Additional Message Information Continuity |
| 7F | 550 | Help Desk Phone Number Qualifier |
| 8F | 550 | Help Desk Phone Number |
| K5 | 880 | Transaction Reference Number |
| A7 | 993 | Internal Control Number |
| MA | 987 | URL |

### 22 — Response Claim

| Field ID | Ref | Name |
|----------|-----|------|
| AM | 111 | Segment Identification |
| EM | 455 | Prescription Reference Number Qualifier |
| D2 | 402 | Prescription Reference Number |
| 9F | 551 | Preferred Product Count |
| AP | 552 | Preferred Product ID Qualifier |
| AR | 553 | Preferred Product ID |
| AS | 554 | Preferred Product Incentive |
| AT | 555 | Preferred Product Cost Share Incentive |
| AU | 556 | Preferred Product Description |
| N4 | 114 | Medicaid ICN |

### 23 — Response Pricing

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| F5 | Gross Amount Due |
| F6 | Ingredient Cost Paid |
| F7 | Dispensing Fee Paid |
| AV | Tax Exempt Indicator |
| AW | Flat Sales Tax Amount Paid |
| AX | Percentage Sales Tax Amount Paid |
| AY | Percentage Sales Tax Rate Paid |
| AZ | Percentage Sales Tax Basis Paid |
| FL | Incentive Amount Paid |
| J1 | Professional Service Fee Paid |
| J2 | Other Amount Paid Count |
| J3 | Other Amount Paid Qualifier |
| J4 | Other Amount Paid |
| J5 | Other Payer Amount Recognized |
| F9 | Total Amount Paid |
| FM | Basis of Reimbursement Determination |
| FN | Amount Attributed to Sales Tax |
| FC | Accumulated Deductible Amount |
| FD | Remaining Deductible Amount |
| FE | Remaining Benefit Amount |
| FH | Amount Applied to Periodic Deductible |
| FI | Amount of Copay |
| FK | Amount Exceeding Periodic Benefit Maximum |
| HH | Basis of Calculation Dispensing Fee |
| HJ | Basis of Calculation Copay |
| HK | Basis of Calculation Flat Sales Tax |
| HM | Basis of Calculation Percentage Sales Tax |
| NZ | Amount Attributed to Processor Fee |
| EQ | Patient Sales Tax Amount |
| 2Y | Plan Sales Tax Amount |
| 4U | Amount of Coinsurance |
| 4V | Basis of Calculation Coinsurance |
| MU | Benefit Stage Count |
| MV | Benefit Stage Qualifier |
| MW | Benefit Stage Amount |
| G3 | Estimated Generic Savings |
| UC | Spending Account Amount Remaining |
| UD | Health Plan Funded Assistance Amount |
| UJ | Amount Attributed to Provider Network Selection |
| UK | Amount Attributed to Product Selection Brand Drug |
| UM | Amount Attributed to Product Selection Non-Preferred Formulary Selection |
| UN | Amount Attributed to Product Selection Brand Non-Preferred Formulary Selection |
| UP | Amount Attributed to Coverage Gap |
| U8 | Ingredient Cost Contracted Reimbursable Amount |
| U9 | Dispensing Fee Contracted Reimbursable Amount |

### 24 — Response DUR/PPS

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| J6 | DUR/PPS Response Code Counter |
| E4 | Reason for Service Code |
| FS | Clinical Significance Code |
| FT | Other Pharmacy Indicator |
| FV | Quantity of Previous Fill |
| FU | Previous Date of Fill |
| FW | Database Indicator |
| FX | Other Prescriber Indicator |
| FY | DUR Free Text Message |
| NS | DUR Additional Text |

### 25 — Response Insurance

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| C1 | Group ID |
| FO | Plan ID |
| 2F | Network Reimbursement ID |
| J7 | Payer ID Qualifier |
| J8 | Payer ID |
| N5 | Medicaid ID Number |
| N6 | Medicaid Agency Number |
| C2 | Cardholder ID |

### 26 — Response Prior Authorization

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| PR | Prior Authorization Processed Date |
| PS | Prior Authorization Effective Date |
| PT | Prior Authorization Expiration Date |
| RA | Prior Authorization Quantity |
| RB | Prior Authorization Dollars Authorized |
| PW | Prior Authorization Number of Refills Authorized |
| PX | Prior Authorization Quantity Accumulated |
| PY | Prior Authorization Number Assigned |

### 27 — Response Insurance Additional Documentation

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| UR | Medicare Part D Coverage Code |
| UQ | CMS Low Income Cost Sharing (LICS) Level |
| U1 | Contract Number |
| FF | Formulary ID |
| U6 | Benefit ID |
| US | Next Medicare Part D Effective Date |
| UT | Next Medicare Part D Termination Date |

### 28 — Response Coordination of Benefits

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| NT | Other Payer ID Count |
| 5C | Other Payer Coverage Type |
| 6C | Other Payer ID Qualifier |
| 7C | Other Payer ID |
| MH | Other Payer Processor Control Number |
| NU | Other Payer Cardholder ID |
| MJ | Other Payer Group ID |
| UV | Other Payer Person Code |
| UB | Other Payer Help Desk Phone Number |
| UW | Other Payer Patient Relationship Code |
| UX | Other Payer Benefit Effective Date |
| UY | Other Payer Benefit Termination Date |

### 29 — Response Patient

| Field ID | Name |
|----------|------|
| AM | Segment Identification |
| CA | Patient First Name |
| CB | Patient Last Name |
| C4 | Date of Birth |

## See Also

- [Segments](segments.md) — How segments are structured and the B1 claim segments in detail
- [Fields](fields.md) — How field identifiers work
- [Field Reference](field-reference.md) — Detailed descriptions of the B1 claim fields
- [Transactions](transactions.md) — How segments combine into transactions
- [Response](response.md) — The response side of the request-response model
- [Repeating Fields](repeating-fields.md) — Count fields and repeating groups

---

*Field mappings sourced from the [dzero](https://github.com/apiv/dzero) and [higher-pixels/ncpdp](https://github.com/higher-pixels/ncpdp) NCPDP Telecom Standard D.0 reference implementations.*
