# Transaction Headers

A transaction **header** must precede every NCPDP transaction. It contains metadata about the transaction itself — the transaction code, version, provider ID, date of service, and other control information.

## Two Flavors: Telecom vs. Batch

The NCPDP telecom standard and the batch standard define slightly different header formats.

### Telecom Header

The telecom standard assumes a single transaction per transmission. The header has **no separators** and starts at the beginning of the request:

```
123456D1B101        1234567890123     202108210000000100
```

### Batch Header

The batch standard adds a few extra fields at the beginning and wraps the header with `&lt;STX&gt;` (STX) and `&lt;ETX&gt;` (ETX) separators. It also includes the `G1` segment identifier:

```
&lt;STX&gt;G11234567890123456D1B101        1234567890123     202108210000000100
```

> **Note:** The batch header is essentially the telecom header with three additions prepended:
> 1. `&lt;STX&gt;` (STX) separator
> 2. `G1` segment identifier
> 3. Transaction reference number (10 characters)

## Header Field Reference

### Batch-Only Fields (Prepended to Telecom Header)

| Field | Length | Description |
|-------|--------|-------------|
| &lt;STX&gt; (STX) Separator | 1 | Start-of-text character (batch only) |
| G1 Segment Identifier | 2 | Identifies this as a transaction header (batch only) |
| Transaction Reference Number | 10 | Payer-defined number to match the facilitator's response |

### Common Fields (Telecom and Batch)

| Field | Length | Description |
|-------|--------|-------------|
| BIN Number | 6 | Processor identification number |
| Version/Release Number | 2 | NCPDP standard version (e.g., `D1`) |
| Transaction Code | 2 | Transaction type (e.g., `B1` for claim) |
| Processor Control Number | 10 | Control number for the transaction |
| Transaction Count | 1 | Number of transactions (typically `1`) |
| Service Provider ID Qualifier | 2 | Qualifier for the service provider ID |
| Service Provider ID | 15 | Pharmacy or provider identifier |
| Date of Service | 8 | Service date in `YYYYMMDD` format |
| Software Vendor/Certification ID | 10 | ID of the pharmacy system software |

## Decoding the Header

Let's decode the batch header from our example:

```
&lt;STX&gt;G11234567890123456D1B101        1234567890123     202108210000000100
```

Breaking it down by position:

| Position | Length | Value | Field |
|----------|--------|-------|-------|
| 1 | 1 | `&lt;STX&gt;` | STX Separator (batch) |
| 2–3 | 2 | `G1` | Segment Identifier (batch) |
| 4–13 | 10 | `1234567890` | Transaction Reference Number (batch) |
| 14–19 | 6 | `123456` | BIN Number |
| 20–21 | 2 | `D1` | Version/Release Number |
| 22–23 | 2 | `B1` | Transaction Code |
| 24–33 | 10 | `01        ` | Processor Control Number |
| 34 | 1 | `1` | Transaction Count |
| 35–36 | 2 | `23` | Service Provider ID Qualifier |
| 37–51 | 15 | `4567890123     ` | Service Provider ID |
| 52–59 | 8 | `20210821` | Date of Service |
| 60–69 | 10 | `0000000100` | Software Vendor/Certification ID |

### JSON Equivalent

```json
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
  }
}
```

## Key Differences Summary

| Feature | Telecom Header | Batch Header |
|---------|---------------|--------------|
| Separators | None | `&lt;STX&gt;` (STX) prefix, `&lt;ETX&gt;` (ETX) suffix |
| Segment identifier | None | `G1` |
| Transaction reference number | Not present | First 10 characters after `G1` |
| Position of BIN number | Starts at position 1 | Starts after `G1` + reference number |
| Use case | Single transaction per request | Multiple transactions per file |

## Batch Headers and Trailers

In addition to the transaction header, the batch standard defines:

- **Batch header** (`&lt;STX&gt;00T...&lt;ETX&gt;`) — appears at the start of the batch file, contains batch-level metadata
- **Batch trailer** (`&lt;STX&gt;99...&lt;ETX&gt;`) — appears at the end of the batch file, contains batch-level counts and totals

Example batch header:

```
&lt;STX&gt;00T123456789               2021123456789123456P1234567WPS0000000         &lt;ETX&gt;
```

Example batch trailer:

```
&lt;STX&gt;9920211840000005162END Dyl B1                         &lt;ETX&gt;
```

### Batch Header Layout

The batch header uses fixed-length fields (no `&lt;FS&gt;` separators), wrapped in `&lt;STX&gt;`/`&lt;ETX&gt;`:

| Position | Length | Ref | Field | Description |
|----------|--------|-----|-------|-------------|
| 1 | 1 | 880-K4 | STX Separator | The `&lt;STX&gt;` character (ASCII 0x02). |
| 2–3 | 2 | 701 | Segment Identifier | Always `00T`. |
| 4 | 1 | 880-K6 | Transmission Type | A code indicating the transmission type (e.g., `T` = test, `P` = production). |
| 5–28 | 24 | 880-K1 | Sender ID | The identifier of the sender of the batch. |
| 29–35 | 7 | 806-5C | Batch Number | A unique number assigned by the sender to identify this batch. |
| 36–43 | 8 | 880-K2 | Creation Date | The date the batch was created, in `YYYYMMDD` format. |
| 44–47 | 4 | 880-K3 | Creation Time | The time the batch was created, in `HHMM` format. |
| 48 | 1 | 702 | File Type | A code indicating the file type. |
| 49–50 | 2 | 102-A2 | Version/Release Number | The NCPDP standard version (e.g., `D0`). |
| 51–74 | 24 | 880-K7 | Receiver ID | The identifier of the receiver of the batch. |
| 75 | 1 | 880-K4 | ETX Separator | The `&lt;ETX&gt;` character (ASCII 0x03). |

### Batch Trailer Layout

| Position | Length | Ref | Field | Description |
|----------|--------|-----|-------|-------------|
| 1 | 1 | 880-K4 | STX Separator | The `&lt;STX&gt;` character (ASCII 0x02). |
| 2–3 | 2 | 701 | Segment Identifier | Always `99`. |
| 4–10 | 7 | 806-5C | Batch Number | The batch number, matching the batch header. |
| 11–20 | 10 | 751 | Record Count | The number of records (transactions) in the batch. |
| 21–55 | 35 | 504-F4 | Message | A free-text message associated with the batch. |
| 56 | 1 | 880-K4 | ETX Separator | The `&lt;ETX&gt;` character (ASCII 0x03). |

## See Also

- [Separators](separators.md) — The delimiter characters used in headers and segments
- [Transactions](transactions.md) — How headers relate to the full transaction
- [Field Reference](field-reference.md) — Detailed descriptions of header and segment fields
- [Response](response.md) — The response header and response segments
- [Examples: B1 Claim](examples/b1-claim.md) — Full example with headers

---

*Source: [Healthcare Data Insight — NCPDP Transaction Headers](https://datainsight.health/edi/ncpdp/ncpdp-headers/)*