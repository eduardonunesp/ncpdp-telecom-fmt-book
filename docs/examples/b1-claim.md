# Pharmacy Claim (B1 Transaction)

This example shows a complete **B1 (Claim Billing)** transaction in NCPDP telecom format, including batch headers and trailers as per the NCPDP batch standard.

## Raw NCPDP Data

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

> **Note:** NCPDP transactions rely on non-printable separators. See [Separators](../separators.md) for the explanation of `&lt;STX&gt;`, `&lt;ETX&gt;`, `&lt;RS&gt;`, and `&lt;FS&gt;` symbols.

## Line-by-Line Breakdown

### Line 1: Batch Header

```
&lt;STX&gt;00T123456789               2021123456789123456P1234567WPS0000000         &lt;ETX&gt;
```

This is the batch header (defined by the batch standard, not the telecom standard). It contains batch-level metadata like the sender/receiver IDs.

### Line 2: Transaction Header

```
&lt;STX&gt;G11234567890123456D1B101        1234567890123     202108210000000100
```

| Position | Length | Value | Field |
|----------|--------|-------|-------|
| 1 | 1 | `&lt;STX&gt;` | STX Separator |
| 2–3 | 2 | `G1` | Segment Identifier |
| 4–13 | 10 | `1234567890` | Transaction Reference Number |
| 14–19 | 6 | `123456` | BIN Number |
| 20–21 | 2 | `D1` | Version/Release Number |
| 22–23 | 2 | `B1` | Transaction Code (Claim Billing) |
| 24–33 | 10 | `01        ` | Processor Control Number |
| 34 | 1 | `1` | Transaction Count |
| 35–36 | 2 | `23` | Service Provider ID Qualifier |
| 37–51 | 15 | `4567890123     ` | Service Provider ID |
| 52–59 | 8 | `20210821` | Date of Service |
| 60–69 | 10 | `0000000100` | Software Vendor/Certification ID |

Note the `B1` transaction code — this tells us to expect claim-related segments.

### Line 3: Insurance Segment (AM04)

```
&lt;RS&gt;&lt;FS&gt;AM04&lt;FS&gt;C2123456789&lt;FS&gt;CCJANE&lt;FS&gt;CDDOE&lt;FS&gt;FOMYPLAN&lt;FS&gt;C90&lt;FS&gt;C1GR1&lt;FS&gt;C3001&lt;FS&gt;C62
```

| Field | Value | Decoded |
|-------|-------|---------|
| AM | 04 | Segment ID: Insurance |
| C2 | 123456789 | Cardholder ID |
| CC | JANE | Cardholder First Name |
| CD | DOE | Cardholder Last Name |
| FO | MYPLAN | Plan ID |
| C9 | 0 | Eligibility Clarification Code |
| C1 | GR1 | Group ID |
| C3 | 001 | Person Code |
| C6 | 2 | Patient Relationship Code |

### Line 4: Patient Segment (AM01)

```
&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C419800225&lt;FS&gt;C52&lt;FS&gt;CAJANE&lt;FS&gt;CBDOE&lt;FS&gt;CM100 MAIN STR&lt;FS&gt;CNWASHINGTON&lt;FS&gt;CODC&lt;FS&gt;CP100010000&lt;FS&gt;CQ5551234567
```

| Field | Value | Decoded |
|-------|-------|---------|
| AM | 01 | Segment ID: Patient |
| C4 | 19800225 | Date of Birth → 1980-02-25 |
| C5 | 2 | Patient Gender Code → Female |
| CA | JANE | Patient First Name |
| CB | DOE | Patient Last Name |
| CM | 100 MAIN STR | Patient Street Address |
| CN | WASHINGTON | Patient City |
| CO | DC | Patient State |
| CP | 100010000 | Patient ZIP Code |
| CQ | 5551234567 | Patient Phone Number |

### Line 5: Claim Segment (AM07)

```
&lt;RS&gt;&lt;FS&gt;AM07&lt;FS&gt;EM1&lt;FS&gt;D2000000123456&lt;FS&gt;E103&lt;FS&gt;D700003089421&lt;FS&gt;E70000030000&lt;FS&gt;D301&lt;FS&gt;D5030&lt;FS&gt;D80&lt;FS&gt;DE20210701&lt;FS&gt;DJ3&lt;FS&gt;C800&lt;FS&gt;DT3&lt;FS&gt;28EA
```

| Field | Value | Decoded |
|-------|-------|---------|
| AM | 07 | Segment ID: Claim |
| EM | 1 | Rx Service Reference Number Qualifier |
| D2 | 000000123456 | Prescription Service Reference Number |
| E1 | 03 | Product/Service ID Qualifier → Drug Info - NDC |
| D7 | 00003089421 | Product/Service ID (NDC code) |
| E7 | 0000030000 | Quantity Dispensed → 30.00 |
| D3 | 01 | Fill Number |
| D5 | 030 | Days Supply → 30 |
| D8 | 0 | Dispense As Written |
| DE | 20210701 | Date Prescription Written → 2021-07-01 |
| DJ | 3 | Prescription Origin Code |
| C8 | 00 | Other Coverage Code |
| DT | 3 | Special Packaging Indicator |
| 28 | EA | Unit of Measure |

### Line 6: Pricing Segment (AM11)

```
&lt;RS&gt;&lt;FS&gt;AM11&lt;FS&gt;D90000057A&lt;FS&gt;DC0000027E&lt;FS&gt;DX0000016B&lt;FS&gt;DQ00000000&lt;FS&gt;DU0000084F&lt;FS&gt;DN07
```

| Field | Value | Decoded | Overpunch |
|-------|-------|---------|-----------|
| AM | 11 | Segment ID: Pricing | — |
| D9 | 0000057A | Ingredient Cost = 5.71 | A → 1, positive |
| DC | 0000027E | Dispensing Fee = 2.75 | E → 5, positive |
| DX | 0000016B | Patient Paid = 1.62 | B → 2, positive |
| DQ | 00000000 | Usual & Customary = 0.00 | — |
| DU | 0000084F | Gross Amount Due = 8.46 | F → 6, positive |
| DN | 07 | Basis of Cost Determination | — |

> **Note:** The pricing segment uses [signed overpunch](../data-types.md) encoding for monetary amounts. For example, `0000084F` decodes to 8.46 (F represents digit 6, positive sign).

### Line 7: Prescriber Segment (AM03)

```
&lt;RS&gt;&lt;FS&gt;AM03&lt;FS&gt;EZ01&lt;FS&gt;DB1234567890&lt;FS&gt;DREVIL&lt;FS&gt;PM5557654321
```

| Field | Value | Decoded |
|-------|-------|---------|
| AM | 03 | Segment ID: Prescriber |
| EZ | 01 | Prescriber ID Qualifier |
| DB | 1234567890 | Prescriber ID |
| DR | EVIL | Prescriber Last Name |
| PM | 5557654321 | Prescriber Phone Number |

### Line 8: Batch Trailer

```
&lt;STX&gt;9920211840000005162END Dyl B1                         &lt;ETX&gt;
```

The batch trailer marks the end of the batch file and contains summary information.

## Complete JSON

Here is the same B1 claim fully decoded into JSON:

```json
{
  "transactions": [
    {
      "transaction_header": {
        "transaction_reference_number": "1234567890",
        "bin_number": 123456,
        "version_release_number": "D1",
        "transaction_code": "B1",
        "process_or_control_number": "01",
        "transaction_count": "1",
        "service_provider_id_qualifier": "23",
        "service_provider_id": "4567890123",
        "date_of_service": "2021-08-21",
        "software_vendor_certification_id": "0000000100"
      },
      "insurance": {
        "cardholder_id": "123456789",
        "cardholder_first_name": "JANE",
        "cardholder_last_name": "DOE",
        "plan_id": "MYPLAN",
        "eligibility_clarification_code": "0",
        "group_id": "GR1",
        "person_code": "001",
        "patient_relationship_code": "2"
      },
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
      },
      "claim": {
        "prescription_service_reference_number_qualifier": "1",
        "prescription_service_reference_number": "000000123456",
        "product_service_id_qualifier": "Drug Info - NDC",
        "product_service_id": "00003089421",
        "quantity_dispensed": 30,
        "fill_number": "01",
        "days_supply": 30,
        "dispense_as_written": "0",
        "date_prescription_written": "2021-07-01",
        "prescription_origin_code": "3",
        "other_coverage_code": "00",
        "special_packaging_indicator": "3",
        "unit_of_measure": "EA"
      },
      "pricing": {
        "ingredient_cost_submitted": 5.71,
        "dispensing_fee_submitted": 2.75,
        "patient_paid_amount_submitted": 1.62,
        "usual_and_customary_charge": 0,
        "gross_amount_due": 8.46,
        "basis_of_cost_determination": "07"
      },
      "prescriber": {
        "prescriber_id_qualifier": "01",
        "prescriber_id": "1234567890",
        "prescriber_last_name": "EVIL",
        "prescriber_phone_number": "5557654321"
      }
    }
  ]
}
```

## See Also

- [Separators](../separators.md) — The non-printable characters used in NCPDP
- [Fields](../fields.md) — How field identifiers work
- [Field Reference](../field-reference.md) — Complete descriptions of every B1 claim field
- [Segment Reference](../segments-reference.md) — Every segment type and its fields
- [Segments](../segments.md) — How fields are grouped into segments
- [Headers](../headers.md) — Transaction header format
- [Data Types](../data-types.md) — Signed overpunch and other encodings
- [Response](../response.md) — The response to this claim

---

*Source: [Healthcare Data Insight — B1 Pharmacy Claim Example](https://datainsight.health/ncpdp/claim-b1/)*