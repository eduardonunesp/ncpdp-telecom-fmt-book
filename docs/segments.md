# Segments

A **segment** is a group of logically related fields representing a business entity, such as a patient, a claim, or a provider.

## Segment Structure

A segment starts with the `&lt;RS&gt;` (RS — Record Start) separator. The segment's fields follow, each preceded by the `&lt;FS&gt;` (FS — Field Start) separator.

```
&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C419800225&lt;FS&gt;C52&lt;FS&gt;CAJANE&lt;FS&gt;CBDOE&lt;FS&gt;CM100 MAIN STR&lt;FS&gt;CNWASHINGTON&lt;FS&gt;CODC&lt;FS&gt;CP100010000&lt;FS&gt;CQ5551234567
```

### Segment Identifier

The first field in every segment is the **segment identifier**, which uses the `AM` field code. The value of this field (e.g., `01`, `04`, `07`, `11`, `03`) indicates what type of segment it is.

```
&lt;RS&gt;&lt;FS&gt;AM01...
```

Here, `AM01` means this is a **Patient** segment (segment ID = `01`).

## Segment Types (B1 Claim)

The NCPDP standard defines which segments are required or optional for each transaction type. For the B1 (pharmacy claim) transaction, the following segments are commonly used:

| Segment ID | Name | Description |
|------------|------|-------------|
| `01` | Patient | Patient demographics: name, address, date of birth, gender |
| `03` | Prescriber | Prescribing provider: ID, name, phone |
| `04` | Insurance | Insurance/cardholder information: ID, name, group, plan |
| `07` | Claim | Prescription details: drug code (NDC), quantity, fill number, dates |
| `11` | Pricing | Financial details: ingredient cost, dispensing fee, amounts |

## Segment Examples

### Insurance Segment (AM04)

```
&lt;RS&gt;&lt;FS&gt;AM04&lt;FS&gt;C2123456789&lt;FS&gt;CCJANE&lt;FS&gt;CDDOE&lt;FS&gt;FOMYPLAN&lt;FS&gt;C90&lt;FS&gt;C1GR1&lt;FS&gt;C3001&lt;FS&gt;C62
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM04 | `04` | Segment identifier (Insurance) |
| C2 | `123456789` | Cardholder ID |
| CC | `JANE` | Cardholder First Name |
| CD | `DOE` | Cardholder Last Name |
| FO | `MYPLAN` | Plan ID |
| C9 | `0` | Eligibility Clarification Code |
| C1 | `GR1` | Group ID |
| C3 | `001` | Person Code |
| C6 | `2` | Patient Relationship Code |

### Patient Segment (AM01)

```
&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C419800225&lt;FS&gt;C52&lt;FS&gt;CAJANE&lt;FS&gt;CBDOE&lt;FS&gt;CM100 MAIN STR&lt;FS&gt;CNWASHINGTON&lt;FS&gt;CODC&lt;FS&gt;CP100010000&lt;FS&gt;CQ5551234567
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM01 | `01` | Segment identifier (Patient) |
| C4 | `19800225` | Date of Birth |
| C5 | `2` | Patient Gender Code (Female) |
| CA | `JANE` | Patient First Name |
| CB | `DOE` | Patient Last Name |
| CM | `100 MAIN STR` | Patient Street Address |
| CN | `WASHINGTON` | Patient City Address |
| CO | `DC` | Patient State/Province |
| CP | `100010000` | Patient ZIP/Postal Zone |
| CQ | `5551234567` | Patient Phone Number |

### Claim Segment (AM07)

```
&lt;RS&gt;&lt;FS&gt;AM07&lt;FS&gt;EM1&lt;FS&gt;D2000000123456&lt;FS&gt;E103&lt;FS&gt;D700003089421&lt;FS&gt;E70000030000&lt;FS&gt;D301&lt;FS&gt;D5030&lt;FS&gt;D80&lt;FS&gt;DE20210701&lt;FS&gt;DJ3&lt;FS&gt;C800&lt;FS&gt;DT3&lt;FS&gt;28EA
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM07 | `07` | Segment identifier (Claim) |
| EM | `1` | Prescription Service Reference Number Qualifier |
| D2 | `000000123456` | Prescription Service Reference Number |
| E1 | `03` | Product/Service ID Qualifier (NDC) |
| D7 | `00003089421` | Product/Service ID (NDC code) |
| E7 | `0000030000` | Quantity Dispensed |
| D3 | `01` | Fill Number |
| D5 | `030` | Days Supply |
| D8 | `0` | Dispense As Written |
| DE | `20210701` | Date Prescription Written |
| DJ | `3` | Prescription Origin Code |
| C8 | `00` | Other Coverage Code |
| DT | `3` | Special Packaging Indicator |
| 28 | `EA` | Unit of Measure |

### Pricing Segment (AM11)

```
&lt;RS&gt;&lt;FS&gt;AM11&lt;FS&gt;D90000057A&lt;FS&gt;DC0000027E&lt;FS&gt;DX0000016B&lt;FS&gt;DQ00000000&lt;FS&gt;DU0000084F&lt;FS&gt;DN07
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM11 | `11` | Segment identifier (Pricing) |
| D9 | `0000057A` | Ingredient Cost Submitted (5.71) |
| DC | `0000027E` | Dispensing Fee Submitted (2.75) |
| DX | `0000016B` | Patient Paid Amount Submitted (1.62) |
| DQ | `00000000` | Usual and Customary Charge (0.00) |
| DU | `0000084F` | Gross Amount Due (8.46) |
| DN | `07` | Basis of Cost Determination |

### Prescriber Segment (AM03)

```
&lt;RS&gt;&lt;FS&gt;AM03&lt;FS&gt;EZ01&lt;FS&gt;DB1234567890&lt;FS&gt;DREVIL&lt;FS&gt;PM5557654321
```

| Field | Value | Meaning |
|-------|-------|---------|
| AM03 | `03` | Segment identifier (Prescriber) |
| EZ | `01` | Prescriber ID Qualifier |
| DB | `1234567890` | Prescriber ID |
| DR | `EVIL` | Prescriber Last Name |
| PM | `5557654321` | Prescriber Phone Number |

## Segment Termination

A segment ends when one of the following is encountered:

- Another `&lt;RS&gt;` (RS) separator — starting a new segment
- `&lt;STX&gt;` (STX) or `&lt;ETX&gt;` (ETX) — in batch mode, these mark batch boundaries
- End of the file/transmission

> **Note:** Segments **do not repeat** within a transaction. There can be only one segment with a given ID per transaction.

## JSON Equivalent

Translating the Patient segment to JSON:

```json
{
  "patient": {
    "date_of_birth": "1980-02-25",
    "patient_gender_code": "Female",
    "patient_first_name": "JANE",
    "patient_last_name": "DOE",
    "patient_street_address": "100 MAIN STR",
    "patient_city_address": "WASHINGTON",
    "patient_state_province_address": "DC",
    "patient_zip_postal_zone": "100010000",
    "patient_phone_number": "5551234567"
  }
}
```

## See Also

- [Fields](fields.md) — The individual data units within segments
- [Field Reference](field-reference.md) — Complete descriptions of every B1 claim field
- [Segment Reference](segments-reference.md) — Every segment type and its fields
- [Transactions](transactions.md) — How segments combine to form transactions
- [Separators](separators.md) — The delimiters that mark segment boundaries

---

*Source: [Healthcare Data Insight — NCPDP Telecom Format for Mere Mortals](https://datainsight.health/ncpdp/intro/)*