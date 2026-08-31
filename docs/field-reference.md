# Field Reference

This page provides detailed descriptions of every field used in the B1 (Pharmacy Claim) transaction. Each entry includes the field identifier, its NCPDP name, a plain-language description, and practical usage notes.

## Transaction Header Fields

The transaction header uses **fixed-length fields** (no separators). In batch mode, it is preceded by `&lt;STX&gt;` and a `G1` segment identifier. See [Headers](headers.md) for format details.

| Position (Batch) | Position (Telecom) | Length | Ref | Field ID | Name | Description |
|------------------|--------------------|--------|-----|----------|------|-------------|
| 1 | — | 1 | 880-K4 | — | STX Separator | The `&lt;STX&gt;` character (ASCII 0x02). Batch-only. Marks the beginning of a transaction header in a batch file. Not present in the telecom (single-transaction) format. |
| 2–3 | — | 2 | 701 | — | Segment Identifier | Always `G1`. Batch-only. Identifies this record as a transaction header. Not present in the telecom format because there is only one transaction per transmission — the header is simply the first line. |
| 4–13 | — | 10 | 880-K5 | — | Transaction Reference Number | A payer-defined number that allows the payer to match the transaction facilitator's response back to the original request. Ideally, this should match the value in field `880-K5` in the claim segment. Batch-only — not present in the telecom header. |
| 14–19 | 1–6 | 6 | 101-A1 | — | BIN Number | The Bank Identification Number assigned by NCPDP to identify the processor or payer. This number routes the claim to the correct claims processor. Every pharmacy claim must specify a valid BIN to be processed. Common BINs include `016696` (Medicare Part D), `610011` (Medicaid), and BINs assigned by commercial insurers. |
| 20–21 | 7–8 | 2 | 102-A2 | — | Version/Release Number | Identifies which version of the NCPDP telecom standard is being used (e.g., `D1`, `E1`). The version determines which fields are required, optional, or not supported. The payer and pharmacy must agree on a version; mismatched versions can cause claim rejections. |
| 22–23 | 9–10 | 2 | 103-A3 | — | Transaction Code | A two-character code identifying the type of transaction. Common values: `B1` = Claim Billing, `B2` = Claim Reversal, `B3` = Reversal/Resubmission, `D0` = Prior Authorization Request, `E1` = Eligibility Inquiry. This tells the payer what action to perform. |
| 24–33 | 11–20 | 10 | 104-A4 | — | Processor Control Number | A control number assigned by the processor. Used for tracking and reference purposes. Often left blank or padded with spaces if not required by the payer. |
| 34 | 21 | 1 | 109-A9 | — | Transaction Count | The number of transactions included in this transmission. For the telecom standard (single transaction), this is always `1`. In batch mode, it is also `1` per transaction header. |
| 35–36 | 22–23 | 2 | 202-B2 | — | Service Provider ID Qualifier | A code that identifies the type of number used in the Service Provider ID field. Common values: `01` = NPI (National Provider Identifier), `23` = NCPDP Provider ID number. This qualifier tells the payer how to interpret the Service Provider ID. |
| 37–51 | 24–38 | 15 | 201-B1 | — | Service Provider ID | The unique identifier for the pharmacy or service provider submitting the claim. The meaning depends on the qualifier field above — it could be an NPI number or an NCPDP Provider ID. Right-padded with spaces to fill the 15-character fixed length. |
| 52–59 | 39–46 | 8 | 401-D1 | — | Date of Service | The date the prescription was dispensed or the service was provided, in `YYYYMMDD` format (e.g., `20210821` for August 21, 2021). This is the date the pharmacy filled the prescription, not the date the prescription was written. |
| 60–69 | 47–56 | 10 | 110-AK | — | Software Vendor/Certification ID | Identifies the pharmacy management software used to generate the claim. This ID is assigned by NCPDP to each software vendor. Payers use it to track which systems are submitting claims and for certification validation. |

## Insurance Segment (AM04)

The Insurance segment contains cardholder and plan information — essentially, whose insurance is being billed.

| Field ID | Ref | Name | Description |
|----------|-----|------|-------------|
| AM | 111 | Segment Identifier | Always `04` for the Insurance segment. Identifies this group of fields as insurance/cardholder information. |
| C2 | 302 | Cardholder ID | The unique identifier for the cardholder (the person whose insurance policy is being used). This is typically the member ID printed on the insurance card. It is not necessarily the patient's ID — it belongs to the person who holds the policy (e.g., a parent when filling a prescription for a dependent child). |
| CC | 312 | Cardholder First Name | The first name of the cardholder (policy holder). Used to verify identity and match the claim to the correct insurance member. |
| CD | 313 | Cardholder Last Name | The last name of the cardholder (policy holder). Combined with the first name for identity verification. |
| CE | 314 | Home Plan | The cardholder's home plan identifier. |
| FO | 524 | Plan ID | The identifier for the specific insurance plan under which the claim is submitted. Plans within the same payer can have different coverage rules, copay structures, and formularies. |
| C9 | 309 | Eligibility Clarification Code | A code that provides additional context about the cardholder's eligibility status. For example, `0` may indicate normal eligibility, while other values indicate special conditions or overrides. |
| C1 | 301 | Group ID | The employer or organization group number associated with the insurance plan. Many insurance plans are organized by group, and the group ID helps route the claim to the correct benefit structure. |
| C3 | 303 | Person Code | A code that distinguishes individuals within the same cardholder's family plan. Typically `001` for the cardholder, `002` for the spouse, `003+` for dependents. This identifies which family member is the patient. |
| C6 | 306 | Patient Relationship Code | Describes the patient's relationship to the cardholder. Common values: `1` = Cardholder (the patient IS the policy holder), `2` = Spouse, `3` = Child/dependent, `4` = Other. This affects benefit calculation and copay amounts. |
| MG | 990 | Other Payer BIN Number | The BIN number of another payer (used for coordination of benefits). |
| MH | 991 | Other Payer Processor Control Number | The processor control number of another payer. |
| NU | 356 | Other Payer Cardholder ID | The cardholder ID as known to another payer. |
| MJ | 992 | Other Payer Group ID | The group ID as known to another payer. |
| 2A | 359 | Medigap ID | The cardholder's Medigap (Medicare supplement) identifier. |
| 2B | 360 | Medicaid Indicator | Indicates whether the patient is covered by Medicaid. |
| 2D | 361 | Provider Accept Assignment Indicator | Indicates whether the provider accepts assignment. |
| G2 | 997 | CMS Part D Defined Qualified Facility | Indicates whether the facility is a CMS Part D defined qualified facility. |
| N5 | 115 | Medicaid ID Number | The patient's Medicaid ID number. |
| N6 | 116 | Medicaid Agency Number | The Medicaid agency number. |

## Patient Segment (AM01)

The Patient segment provides demographic information about the person receiving the medication.

| Field ID | Ref | Name | Description |
|----------|-----|------|-------------|
| AM | 111 | Segment Identifier | Always `01` for the Patient segment. |
| CX | 331 | Patient ID Qualifier | A code indicating the type of patient ID in field CY. |
| CY | 332 | Patient ID | The patient's identifier, as qualified by field CX. |
| C4 | 304 | Date of Birth | The patient's date of birth in `YYYYMMDD` format (e.g., `19800225` for February 25, 1980). Used to verify identity, determine eligibility (e.g., pediatric vs. adult dosing), and calculate age-based benefits. |
| C5 | 305 | Patient Gender Code | The patient's gender. Common values: `1` = Male, `2` = Female. Some versions support additional codes. Used for clinical editing (certain drugs are gender-specific) and benefit determination. |
| CA | 310 | Patient First Name | The patient's first (given) name. Used for identity verification and matching to insurance records. |
| CB | 311 | Patient Last Name | The patient's last (family) name. Combined with first name and date of birth for unique identification. |
| CM | 322 | Patient Street Address | The patient's street address (e.g., `100 MAIN STR`). Used for identity verification and, in some cases, for determining pharmacy network eligibility based on geographic location. |
| CN | 323 | Patient City | The patient's city (e.g., `WASHINGTON`). Part of the address for identification and geographic benefit determination. |
| CO | 324 | Patient State/Province | The patient's state or province code (e.g., `DC` for District of Columbia, `NY` for New York). Two-character state abbreviation. |
| CP | 325 | Patient ZIP/Postal Code | The patient's ZIP or postal code, left-padded with zeros to fill the field length (e.g., `100010000`). Used for geographic benefit determination and fraud screening. |
| CQ | 326 | Patient Phone Number | The patient's phone number. Used for follow-up communications and identity verification. |
| C7 | 307 | Place of Service | A code indicating the place of service (e.g., retail pharmacy, long-term care). |
| CZ | 333 | Employer ID | The patient's employer identifier. |
| 1C | 334 | Smoker/Non-Smoker Code | Indicates whether the patient is a smoker. |
| 2C | 335 | Pregnancy Indicator | Indicates whether the patient is pregnant. |
| HN | 350 | Patient Email Address | The patient's email address. |
| 4X | 384 | Patient Residence | A code indicating the patient's residence type. |

## Claim Segment (AM07)

The Claim segment contains the prescription and drug details — the core of what is being billed.

| Field ID | Ref | Name | Description |
|----------|-----|------|-------------|
| AM | 111 | Segment Identifier | Always `07` for the Claim segment. |
| EM | 455 | Prescription/Service Reference Number Qualifier | A code indicating what type of identifier follows in field D2. Common values: `1` = Prescription Number (assigned by the pharmacy). This qualifier tells the payer how to interpret the reference number. |
| D2 | 402 | Prescription/Service Reference Number | The unique number assigned to the prescription by the pharmacy. This is the pharmacy's internal tracking number for the prescription. Used to link subsequent refills and reversals to the original claim. |
| E1 | 436 | Product/Service ID Qualifier | A code indicating what type of product identifier follows in field D7. Common values: `03` = National Drug Code (NDC). The NDC is the most commonly used qualifier for pharmacy claims because it uniquely identifies the specific drug product dispensed. |
| D7 | 407 | Product/Service ID | The identifier for the product or service dispensed. When the qualifier (E1) is `03`, this field contains the NDC number, which is an 11-digit code that uniquely identifies a specific drug product (manufacturer, strength, dosage form, and package size). |
| EN | 456 | Associated Prescription/Service Reference Number | A reference number associated with the prescription (e.g., for a prior related claim). |
| EP | 457 | Associated Prescription/Service Date | The date associated with the associated prescription reference number. |
| SE | 458 | Procedure Modifier Code Count | The number of procedure modifier codes (field ER) that follow. A count field preceding a repeating group. |
| ER | 459 | Procedure Modifier Code | A procedure modifier code. Repeats according to the count in field SE. |
| E7 | 442 | Quantity Dispensed | The quantity of the product dispensed, encoded as a decimal without a decimal point. The number of implied decimal places depends on the Unit of Measure (field 28). For example, `0000030000` with an implied 2 decimal places means 30.00 units. |
| D3 | 403 | Fill Number | Indicates which fill this claim represents. `00` = Original fill, `01` = First refill, `02` = Second refill, etc. This distinguishes the original dispensing from subsequent refills of the same prescription. |
| D5 | 405 | Days Supply | The number of days the dispensed medication is expected to last. For example, `030` means a 30-day supply. Used for clinical editing, benefit determination, and to verify that the quantity dispensed is consistent with the days supply. |
| D6 | 406 | Compound Code | Indicates whether the prescription is a compound (a medication mixed from multiple ingredients). Common values: `1` = Not a compound, `2` = Compound. When `2`, a Compound segment (10) is expected. |
| D8 | 408 | Dispense As Written (DAW) Code | Indicates whether the pharmacist dispensed a generic or brand-name product as written by the prescriber. Common values: `0` = No DAW (substitution allowed — pharmacist may dispense a generic), `1` = Brand medically necessary (prescriber explicitly requires brand). Affects reimbursement and copay calculation. |
| DE | 414 | Date Prescription Written | The date the prescriber originally wrote the prescription, in `YYYYMMDD` format (e.g., `20210701` for July 1, 2021). This is the date on the prescription itself, not the date it was filled. Used for refill timing validation and clinical editing. |
| DF | 415 | Number of Refills Authorized | The number of refills the prescriber authorized on the prescription. Used to validate that the fill number (D3) does not exceed the authorized refills. |
| DJ | 419 | Prescription Origin Code | Indicates the method by which the prescription was received. Common values: `1` = Written (paper prescription), `2` = Telephone (pharmacy received via phone call from prescriber), `3` = Electronic (e-prescribing). Important for compliance tracking and, increasingly, for regulatory requirements around e-prescribing. |
| NX | 354 | Submission Clarification Code Count | The number of submission clarification codes (field DK) that follow. A count field that precedes a repeating group. |
| DK | 420 | Submission Clarification Code | A code that provides additional clarification about the claim submission (e.g., why a prior authorization was not obtained). Repeats according to the count in field NX. |
| ET | 460 | Quantity Prescribed | The quantity the prescriber originally prescribed, encoded as a decimal without a decimal point. Used to compare against the quantity dispensed (E7) for clinical editing. |
| C8 | 308 | Other Coverage Code | A code indicating whether the patient has other (primary) coverage that may affect how this claim is adjudicated. Common values: `00` = No other coverage, `01` = Other coverage exists. Used for coordination of benefits (COB) — the payer uses this to determine whether it is primary or secondary. |
| DT | 429 | Special Packaging Indicator | A code indicating whether the medication was dispensed in special packaging. Common values: `00` = Not applicable / no special packaging. Used for reimbursement adjustments — some drugs require child-resistant or unit-dose packaging that affects cost. |
| EJ | 453 | Originally Prescribed Product/Service ID Qualifier | A qualifier for the originally prescribed product code (field EA). |
| EA | 445 | Originally Prescribed Product/Service Code | The product code originally prescribed. |
| EB | 446 | Originally Prescribed Quantity | The quantity originally prescribed. |
| CW | 330 | Alternate ID | An alternate identifier for the claim. |
| EK | 454 | Scheduled Prescription ID Number | The scheduled prescription ID number. |
| 28 | 600 | Unit of Measure | A code indicating the unit in which the quantity dispensed (field E7) is measured. Common values: `3` = Each (individual units, e.g., tablets, capsules). This qualifier is essential for correctly interpreting the quantity — 30 "each" means 30 tablets, while 30 "ml" means 30 milliliters, which has very different cost implications. |
| DI | 418 | Level of Service | A code indicating the level of service provided. |
| EU | 461 | Prior Authorization Type Code | A code indicating the type of prior authorization. |
| EV | 462 | Prior Authorization Number Submitted | The prior authorization number submitted with the claim. |
| EW | 463 | Intermediary Authorization Type ID | The type of intermediary authorization. |
| EX | 464 | Intermediary Authorization ID | The intermediary authorization identifier. |
| HD | 343 | Dispensing Status | A code indicating the dispensing status. |
| HF | 344 | Quantity Intended to Be Dispensed | The quantity intended to be dispensed. |
| HG | 345 | Days Supply Intended to Be Dispensed | The days supply intended to be dispensed. |
| NV | 357 | Delay Reason Code | A code indicating the reason for a delay in submission. |
| K5 | 880 | Transaction Reference Number | A reference number that links the claim to the transaction header's transaction reference number. Used to match a response back to the original request. |
| MT | 391 | Patient Assignment Indicator | Indicates whether the patient has assigned their benefits to the pharmacy. Common values: `Y` = Yes, `N` = No. Affects whether the pharmacy can bill the patient directly. |
| E2 | 995 | Route of Administration | A code indicating the route of administration. |
| G1 | 996 | Compound Type | Indicates the type of compound when the claim is a compound (D6 = `2`). Common values: `1` = Non-sterile compound, `2` = Sterile compound. |
| N4 | 114 | Medicaid ICN/TCN | The Medicaid subrogation internal control number / transaction control number. |
| U7 | 147 | Pharmacy Service Type | A code indicating the type of pharmacy service provided (e.g., standard dispensing, long-term care, compounding). Used for benefit determination. |

## Pricing Segment (AM11)

The Pricing segment contains the financial details of the claim — what was charged and what is being requested as reimbursement.

| Field ID | Ref | Name | Description |
|----------|-----|------|-------------|
| AM | 111 | Segment Identifier | Always `11` for the Pricing segment. |
| D9 | 409 | Ingredient Cost Submitted | The total cost of the drug ingredient(s) dispensed, encoded using signed overpunch. This is the pharmacy's acquisition cost for the medication, not the dispensing fee. For example, `0000057A` decodes to $5.71 (A = positive 1 in the last digit → 5.71). |
| DC | 412 | Dispensing Fee Submitted | The fee the pharmacy charges for dispensing the medication, encoded using signed overpunch. This covers the pharmacist's professional services: verifying the prescription, counseling the patient, counting/measuring the medication, and labeling. For example, `0000027E` decodes to $2.75 (E = positive 5 → 2.75). |
| BE | 477 | Professional Service Fee Submitted | A professional service fee submitted with the claim. |
| DX | 433 | Patient Paid Amount Submitted | The amount the patient paid at the pharmacy counter (copay, coinsurance, or full price if not covered), encoded using signed overpunch. For example, `0000016B` decodes to $1.62 (B = positive 2 → 1.62). This amount is subtracted from the total reimbursement to the pharmacy. |
| E3 | 438 | Incentive Amount Submitted | An incentive amount submitted with the claim. |
| H7 | 478 | Other Amount Claimed Submitted Count | The number of other amount claimed groups (fields H8/H9) that follow. A count field preceding a repeating group. |
| H8 | 479 | Other Amount Claimed Submitted Qualifier | A qualifier for the other amount claimed. |
| H9 | 480 | Other Amount Claimed Submitted | The other amount claimed. Repeats according to the count in field H7. |
| HA | 481 | Flat Sales Tax Amount Submitted | A flat sales tax amount submitted with the claim. |
| GE | 482 | Percentage Sales Tax Amount Submitted | A percentage-based sales tax amount submitted. |
| HE | 483 | Percentage Sales Tax Rate Submitted | The percentage sales tax rate submitted. |
| JE | 484 | Percentage Sales Tax Basis Submitted | The basis for the percentage sales tax. |
| DQ | 426 | Usual and Customary Charge | The pharmacy's usual and customary price for the medication to cash-paying customers, encoded using signed overpunch. In this example, `00000000` means the U&C charge is $0.00, which may indicate the pharmacy does not have a cash price for this particular drug. Payers use U&C as a ceiling — they will not reimburse more than the pharmacy's regular cash price. |
| DU | 430 | Gross Amount Due | The total amount the pharmacy is requesting from the payer, encoded using signed overpunch. Typically calculated as: Ingredient Cost + Dispensing Fee - Patient Paid Amount. For example, `0000084F` decodes to $8.46 (F = positive 6 → 8.46). This is the "bottom line" amount the pharmacy expects to receive from the insurer. |
| DN | 423 | Basis of Cost Determination | A code indicating how the ingredient cost was determined. Common values: `01` = Average Wholesale Price (AWP), `04` = Wholesale Acquisition Cost (WAC), `07` = Other. This tells the payer what pricing benchmark was used, which affects reimbursement calculations. |
| N3 | 113 | Medicaid Paid Amount | The amount paid by Medicaid. |

## Prescriber Segment (AM03)

The Prescriber segment identifies the healthcare provider who wrote the prescription.

| Field ID | Ref | Name | Description |
|----------|-----|------|-------------|
| AM | 111 | Segment Identifier | Always `03` for the Prescriber segment. |
| EZ | 466 | Prescriber ID Qualifier | A code indicating the type of identifier in field DB. Common values: `01` = NPI (National Provider Identifier), `0A` = DEA Number (Drug Enforcement Administration). The NPI is the most commonly used qualifier since it is the standard unique identifier for healthcare providers in the US. |
| DB | 411 | Prescriber ID | The unique identifier for the prescriber, corresponding to the qualifier in field EZ. When EZ = `01`, this contains the prescriber's 10-digit NPI number. The prescriber ID allows the payer to verify that the prescribing provider is licensed and eligible to prescribe the medication. |
| DR | 427 | Prescriber Last Name | The last name of the prescriber. Used for identification verification and claim adjudication. |
| PM | 498 | Prescriber Phone Number | The prescriber's phone number. Used by the pharmacy and payer for verification, prior authorization requests, and follow-up communications. |
| 2E | 468 | Primary Care Provider ID Qualifier | A qualifier for the primary care provider ID (field DL). |
| DL | 421 | Primary Care Provider ID | The primary care provider's identifier. |
| 4E | 470 | Primary Care Provider Last Name | The primary care provider's last name. |
| 2J | 364 | Prescriber First Name | The prescriber's first name. |
| 2K | 365 | Prescriber Street Address | The prescriber's street address. |
| 2M | 366 | Prescriber City Address | The prescriber's city. |
| 2N | 367 | Prescriber State/Province Address | The prescriber's state or province. |
| 2P | 368 | Prescriber ZIP/Postal Zone | The prescriber's ZIP or postal code. |

## Batch Header Fields (00T)

The batch header appears only in batch files (not in the telecom single-transaction format). It wraps the entire batch of transactions.

> **Note:** The batch header uses `&lt;STX&gt;`/`&lt;ETX&gt;` separators and does not use the field separator `&lt;FS&gt;`. It consists of fixed-length fields, similar to the transaction header.

| Position | Length | Ref | Name | Description |
|----------|--------|-----|------|-------------|
| 1 | 1 | 880-K4 | STX Separator | The `&lt;STX&gt;` character (ASCII 0x02). Marks the start of the batch header. |
| 2–3 | 2 | 701 | Segment Identifier | Always `00T`. Identifies this record as the batch header. |
| 4 | 1 | 880-K6 | Transmission Type | A code indicating the transmission type (e.g., `T` for test, `P` for production). |
| 5–28 | 24 | 880-K1 | Sender ID | The identifier of the sender of the batch. |
| 29–35 | 7 | 806-5C | Batch Number | A unique number assigned by the sender to identify this batch. Used for tracking and reconciliation. |
| 36–43 | 8 | 880-K2 | Creation Date | The date the batch was created, in `YYYYMMDD` format. |
| 44–47 | 4 | 880-K3 | Creation Time | The time the batch was created, in `HHMM` format. |
| 48 | 1 | 702 | File Type | A code indicating the file type. |
| 49–50 | 2 | 102-A2 | Version/Release Number | The NCPDP standard version (e.g., `D0`). |
| 51–74 | 24 | 880-K7 | Receiver ID | The identifier of the receiver of the batch. |
| 75 | 1 | 880-K4 | ETX Separator | The `&lt;ETX&gt;` character (ASCII 0x03). Marks the end of the batch header. |

## Batch Trailer Fields (99)

The batch trailer appears only in batch files and marks the end of the entire batch.

| Position | Length | Ref | Name | Description |
|----------|--------|-----|------|-------------|
| 1 | 1 | 880-K4 | STX Separator | The `&lt;STX&gt;` character (ASCII 0x02). Marks the start of the batch trailer. |
| 2–3 | 2 | 701 | Segment Identifier | Always `99`. Identifies this record as the batch trailer. |
| 4–10 | 7 | 806-5C | Batch Number | The batch number, matching the batch header. |
| 11–20 | 10 | 751 | Record Count | The number of records (transactions) in the batch. Used for validation and reconciliation. |
| 21–55 | 35 | 504-F4 | Message | A free-text message associated with the batch. |
| 56 | 1 | 880-K4 | ETX Separator | The `&lt;ETX&gt;` character (ASCII 0x03). Marks the end of the batch trailer. |

## See Also

- [Fields](fields.md) — How field identifiers work
- [Segments](segments.md) — How fields are grouped into segments
- [Segment Reference](segments-reference.md) — Every segment type and its fields
- [Response](response.md) — Response segment fields
- [Repeating Fields](repeating-fields.md) — Count fields and repeating groups
- [Examples: B1 Claim](examples/b1-claim.md) — Full decoded example

---

*Source: [Healthcare Data Insight — NCPDP Telecom Format for Mere Mortals](https://datainsight.health/ncpdp/intro/), [NCPDP Transaction Headers](https://datainsight.health/edi/ncpdp/ncpdp-headers/), and the [higher-pixels/ncpdp](https://github.com/higher-pixels/ncpdp) reference implementation (official NCPDP field reference numbers).*