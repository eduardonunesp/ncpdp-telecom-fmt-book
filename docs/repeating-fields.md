# Repeating Fields

NCPDP supports **repeating fields** or **groups of fields** to express one-to-many relationships within a transaction. This page explains the pattern and shows real examples from the standard.

## How Repeating Works

A repeating group is always preceded by a **count field** that indicates how many times the group repeats. The count field tells the parser how many iterations of the group to expect.

```
&lt;FS&gt;[count_field]&lt;FS&gt;[repeat_group_1]&lt;FS&gt;[repeat_group_2]&lt;FS&gt;...
```

The count field is a regular NCPDP field whose value is the number of repetitions. The group of fields that follows repeats that many times, each repetition containing the same set of field identifiers.

## Count Fields

Every repeating group has a dedicated count field. The count field's identifier is defined in the NCPDP standard for each group. Some common examples:

| Segment | Count Field | Repeating Group |
|---------|-------------|-----------------|
| Claim (07) | `NX` Submission Clarification Code Count | `DK` Submission Clarification Code |
| Clinical (13) | `VE` Diagnosis Code Count | `DO` Diagnosis Code |
| Clinical (13) | `XE` Clinical Information Counter | `ZE`/`H1`/`H2`/`H3`/`H4` measurement group |
| DUR/PPS (08) | `7E` DUR/PPS Code Counter | `E4`/`E5`/`E6`/`8E` DUR/PPS group |
| Compound (10) | `EC` Compound Ingredient Component Count | `RE`/`TE`/`ED`/`EE`/`UE` ingredient group |
| Pricing (11) | `H7` Other Amount Claimed Submitted Count | `H8`/`H9` Other Amount Claimed group |
| Response Status (21) | `FA` Reject Count | `FB` Reject Code |
| Response Status (21) | `5F` Approved Message Code Count | `6F` Approved Message Code |
| Response Pricing (23) | `J2` Other Amount Paid Count | `J3`/`J4` Other Amount Paid group |
| Coordination of Benefits (05) | `4C` COB Other Payments Count | `5C`/`6C`/`7C`/`E8` other payer group |
| Coordination of Benefits (05) | `HB` Other Payer Amount Paid Count | `HC`/`DV` Other Payer Amount Paid group |

## Example 1: Reject Codes (Response Status)

The most common repeating group is the **reject code** list in the Response Status segment. A count field (`FA`) is followed by that many reject codes (`FB`):

```
&lt;RS&gt;&lt;FS&gt;AM21&lt;FS&gt;ANR&lt;FS&gt;FA2&lt;FS&gt;FB77&lt;FS&gt;FB88
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM | 21 | Segment ID: Response Status |
| AN | R | Rejected |
| FA | 2 | Two reject codes follow |
| FB | 77 | Reject code 1 |
| FB | 88 | Reject code 2 |

## Example 2: Diagnosis Codes (Clinical)

The Clinical segment uses a count field (`VE`) followed by diagnosis codes (`DO`), each with a qualifier (`WE`):

```
&lt;RS&gt;&lt;FS&gt;AM13&lt;FS&gt;VE2&lt;FS&gt;WE01&lt;FS&gt;DOJ449&lt;FS&gt;WE01&lt;FS&gt;DOI10
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM | 13 | Segment ID: Clinical |
| VE | 2 | Two diagnosis codes follow |
| WE | 01 | Diagnosis code qualifier (ICD-10) |
| DO | J449 | Diagnosis code 1 |
| WE | 01 | Diagnosis code qualifier |
| DO | I10 | Diagnosis code 2 |

## Example 3: Compound Ingredients (Compound)

The Compound segment uses a count field (`EC`) followed by a group of ingredient fields that repeats:

```
&lt;RS&gt;&lt;FS&gt;AM10&lt;FS&gt;EF1&lt;FS&gt;EG1&lt;FS&gt;EC2&lt;FS&gt;RE03&lt;FS&gt;TE00003089421&lt;FS&gt;ED0000003000&lt;FS&gt;EE00000057A&lt;FS&gt;UE07&lt;FS&gt;RE03&lt;FS&gt;TE00003123456&lt;FS&gt;ED0000002000&lt;FS&gt;EE00000027E&lt;FS&gt;UE07
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM | 10 | Segment ID: Compound |
| EF | 1 | Compound dosage form description code |
| EG | 1 | Compound dispensing unit form indicator |
| EC | 2 | Two ingredients follow |
| RE | 03 | Ingredient 1 product ID qualifier (NDC) |
| TE | 00003089421 | Ingredient 1 product ID |
| ED | 0000003000 | Ingredient 1 quantity |
| EE | 00000057A | Ingredient 1 drug cost |
| UE | 07 | Ingredient 1 basis of cost determination |
| RE | 03 | Ingredient 2 product ID qualifier |
| TE | 00003123456 | Ingredient 2 product ID |
| ED | 0000002000 | Ingredient 2 quantity |
| EE | 00000027E | Ingredient 2 drug cost |
| UE | 07 | Ingredient 2 basis of cost determination |

## See Also

- [Fields](fields.md) — Individual field structure and identifiers
- [Segments](segments.md) — How fields are grouped into segments
- [Segment Reference](segments-reference.md) — Count fields and repeating groups for every segment
- [Response](response.md) — Reject codes as a repeating group
- [Transactions](transactions.md) — How segments combine into transactions

---

*Count-field and repeating-group mappings sourced from the [dzero](https://github.com/apiv/dzero) NCPDP Telecom Standard D.0 reference implementation.*
