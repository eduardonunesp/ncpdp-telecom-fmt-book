# Fields

A **field** is the smallest unit of data in an NCPDP transaction. Each field contains a single piece of data — a name, an identifier, a code, a quantity, etc.

## Field Structure

A field starts with the `&lt;FS&gt;` (FS — Field Start) separator followed by a **two-character field identifier**, then the field's value immediately follows.

```
&lt;FS&gt;CNWASHINGTON
```

Breaking this down:

| Component | Value | Description |
|-----------|-------|-------------|
| Separator | `&lt;FS&gt;` | Marks the start of a field |
| Field ID | `CN` | Two-character identifier for "Patient City Address" |
| Field value | `WASHINGTON` | The actual data |

## Field Identifiers

Field identifiers are exactly **two alphanumeric characters**. They are not particularly mnemonic — you need to consult the NCPDP telecom standard to look up what each identifier means.

> **Note:** The decision to use only two characters was likely driven by the desire to minimize the size of NCPDP transactions/messages.

### Common Field Identifiers (B1 Claim)

Here are some frequently encountered field identifiers in a B1 (pharmacy claim) transaction:

| Field ID | Description | Segment |
|----------|-------------|---------|
| `AM` | Segment identifier | All segments |
| `C2` | Cardholder ID | Insurance |
| `CC` | Cardholder First Name | Insurance |
| `CD` | Cardholder Last Name | Insurance |
| `FO` | Plan ID | Insurance |
| `C9` | Eligibility Clarification Code | Insurance |
| `C1` | Group ID | Insurance |
| `C3` | Person Code | Insurance |
| `C6` | Patient Relationship Code | Insurance |
| `C4` | Date of Birth | Patient |
| `C5` | Patient Gender Code | Patient |
| `CA` | Patient First Name | Patient |
| `CB` | Patient Last Name | Patient |
| `CM` | Patient Street Address | Patient |
| `CN` | Patient City | Patient |
| `CO` | Patient State/Province | Patient |
| `CP` | Patient ZIP/Postal Code | Patient |
| `CQ` | Patient Phone Number | Patient |
| `EM` | Prescription Service Reference Number Qualifier | Claim |
| `D2` | Prescription Service Reference Number | Claim |
| `E1` | Product/Service ID Qualifier | Claim |
| `D7` | Product/Service ID (NDC) | Claim |
| `E7` | Quantity Dispensed | Claim |
| `D3` | Fill Number | Claim |
| `D5` | Days Supply | Claim |
| `D8` | Dispense As Written | Claim |
| `DE` | Date Prescription Written | Claim |
| `DJ` | Prescription Origin Code | Claim |
| `C8` | Other Coverage Code | Claim |
| `DT` | Special Packaging Indicator | Claim |
| `28` | Unit of Measure | Claim |
| `D9` | Ingredient Cost Submitted | Pricing |
| `DC` | Dispensing Fee Submitted | Pricing |
| `DX` | Patient Paid Amount Submitted | Pricing |
| `DQ` | Usual and Customary Charge | Pricing |
| `DU` | Gross Amount Due | Pricing |
| `DN` | Basis of Cost Determination | Pricing |
| `EZ` | Prescriber ID Qualifier | Prescriber |
| `DB` | Prescriber ID | Prescriber |
| `DR` | Prescriber Last Name | Prescriber |
| `PM` | Prescriber Phone Number | Prescriber |

## Field Value Encoding

Field values in NCPDP are encoded differently depending on the data type:

- **Strings** — plain text, no special encoding
- **Dates** — `YYYYMMDD` format (e.g., `20210701` for July 1, 2021)
- **Integers** — left-padded with zeros (e.g., `030` for 30)
- **Decimals** — no decimal point; the standard specifies the precision (e.g., `0000030000` might represent 30.00)

See [Data Types](data-types.md) for details on numeric encoding, including signed overpunch.

## JSON Equivalent

If we were to translate an NCPDP field into JSON:

```json
{
  "patient_city_address": "WASHINGTON"
}
```

## See Also

- [Field Reference](field-reference.md) — Complete descriptions of every B1 claim field
- [Segment Reference](segments-reference.md) — Every segment type and its fields
- [Separators](separators.md) — The delimiters that mark field boundaries
- [Segments](segments.md) — How fields are grouped into logical units
- [Data Types](data-types.md) — How field values are encoded

---

*Source: [Healthcare Data Insight — NCPDP Telecom Format for Mere Mortals](https://datainsight.health/ncpdp/intro/)*