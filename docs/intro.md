# NCPDP Telecom Format Overview

An NCPDP **transaction** consists of **segments**; segments consist of **fields**; each field contains a single piece of data, such as a name, an identifier, an NDC drug code, or a quantity.

Fields or a group of fields can repeat to express one-to-many relationships. A repeating group is always preceded by a field containing the count of repetitions.

Fields and segments are separated using [non-printable ASCII characters](separators.md).

These transactions are sent to **Pharmacy Benefit Managers (PBMs)** for adjudication — see [Pharmacy Benefit Managers](pbms.md) for context on how PBMs fit into the pharmacy claims process. The PBMs adjudicate claims on behalf of **payers** such as Health Maintenance Organizations (HMOs) — see [Health Maintenance Organizations](hmos.md) for how HMOs shape pharmacy benefits. For broader context on the pharmaceutical industry and how it shapes NCPDP fields, see [Industry Context](industry-context.md).

NCPDP also defines the **Real-Time Pharmacy Benefit Inquiry (RTPBI)**, a separate standard where a prescriber queries a patient's benefit information at the point of care, before a prescription is written. See [Real-Time Pharmacy Benefit Inquiry](rtpbi.md) for details.

## Request-Response Model

The NCPDP telecom standard assumes a **request-response** model where a request contains a single transaction (e.g., a single pharmacy claim).

NCPDP also provides a related [batch standard](https://www.ncpdp.org/NCPDP/media/pdf/CMSPartDSupplementalInformationReporting(NTransaction)BatchStandard.pdf) that specifies how to transmit multiple transactions in a single file. The batch standard defines the format of headers and trailers used to separate transactions.

> **Warning:** HIPAA mandates the use of the NCPDP telecom standard (and the related batch standard) for pharmacy drug claim submission.

## A Quick Example

Here is a simple claim (a "B1" transaction) in NCPDP telecom format with batch headers added. You can view a line-by-line interactive decoding of this example in the [B1 claim example](examples/b1-claim.md).

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

This looks cryptic, but each piece has a clear purpose. The rest of this documentation will walk you through every part.

## Key Concepts

### Separators

The symbols like `&lt;RS&gt;` and `&lt;FS&gt;` represent non-printable ASCII characters used as separators. See [Separators](separators.md) for the full breakdown.

### Fields

A field starts with the `&lt;FS&gt;` separator followed by a two-character field identifier, then the field's value:

```
&lt;FS&gt;CNWASHINGTON
```

Here, `CN` is the field identifier for "Patient City Address." See [Fields](fields.md).

### Segments

A segment is a group of logically related fields. It starts with `&lt;RS&gt;` and the first field identifies the segment type:

```
&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C419800225&lt;FS&gt;C52&lt;FS&gt;CAJANE&lt;FS&gt;CBDOE&lt;FS&gt;CM100 MAIN STR&lt;FS&gt;CNWASHINGTON&lt;FS&gt;CODC&lt;FS&gt;CP100010000&lt;FS&gt;CQ5551234567
```

`AM01` identifies this as the "Patient" segment. See [Segments](segments.md).

### Transactions

A transaction is a group of segments for a single use case (e.g., claim submission). Each transaction type has a two-character code like `B1` (claim) or `B2` (reversal). See [Transactions](transactions.md).

### Headers

A transaction header uses fixed-length fields (no separators) and contains the transaction code, version, provider ID, date of service, etc. See [Headers](headers.md).

### Data Types

NCPDP uses signed overpunch encoding for numeric fields, zero-padded integers, and decimals without a decimal point. See [Data Types](data-types.md).

## Complete JSON Example

Here's the same B1 claim decoded into JSON:

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

---

*Source: [Healthcare Data Insight — NCPDP Telecom Format for Mere Mortals](https://datainsight.health/ncpdp/intro/)*