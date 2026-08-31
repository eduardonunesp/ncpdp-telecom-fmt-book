# Data Types

NCPDP supports all the usual data types for fields: **string**, **date**, **integer**, and **decimal**. However, the encoding of numeric values has some unique characteristics that are important to understand.

## String Fields

String fields contain plain text values with no special encoding:

```
&lt;FS&gt;CAJANE       → Patient First Name   = "JANE"
&lt;FS&gt;CNWASHINGTON → Patient City Address = "WASHINGTON"
&lt;FS&gt;CODC         → Patient State        = "DC"
```

## Date Fields

Date fields use the `YYYYMMDD` format with no separators:

```
&lt;FS&gt;C419800225 → Date of Birth             = "1980-02-25"  (19800225)
&lt;FS&gt;DE20210701 → Date Prescription Written = "2021-07-01"  (20210701)
```

## Integer Fields

Integer fields are **left-padded with zeros** to fill the field's fixed length:

```
&lt;FS&gt;D5030 → Days Supply = 30 (030, padded to 3 characters)
&lt;FS&gt;D301  → Fill Number = 1  (01, padded to 2 characters)
```

## Decimal Fields

Decimal numbers **do not contain a decimal point**. Instead, the NCPDP standard specifies the precision (number of decimal places) for each field. You must consult the standard to determine where the implied decimal point goes.

```
&lt;FS&gt;E70000030000  → Quantity Dispensed = 30.00 (implied 2 decimal places)
```

> **Warning:** Without consulting the NCPDP standard, you cannot determine the precision of a decimal field just by looking at the raw data. The value `0000030000` could mean 30.00, 300.0, or 3000, depending on the field's specified precision.

## Signed Overpunch

NCPDP uses **signed overpunch** (also known as **zone punch**) to encode the sign of a number using the last digit. This encoding was widely used on mainframes and persists in the NCPDP standard today.

### How It Works

The idea is simple: the last digit of a number is converted to a letter that encodes both the digit value and the sign (positive or negative).

#### Positive Numbers

| Last Digit | Overpunch | | Last Digit | Overpunch |
|------------|-----------|-|------------|-----------|
| 0 | `{` | | 5 | `E` |
| 1 | `A` | | 6 | `F` |
| 2 | `B` | | 7 | `G` |
| 3 | `C` | | 8 | `H` |
| 4 | `D` | | 9 | `I` |

#### Negative Numbers

| Last Digit | Overpunch | | Last Digit | Overpunch |
|------------|-----------|-|------------|-----------|
| 0 | `}` | | 5 | `N` |
| 1 | `J` | | 6 | `O` |
| 2 | `K` | | 7 | `P` |
| 3 | `L` | | 8 | `Q` |
| 4 | `M` | | 9 | `R` |

### Examples

| Field | Raw Value | Decoded Value | Explanation |
|-------|-----------|---------------|-------------|
| Days Supply | `030` | 30 | Simple integer, zero-padded |
| Quantity Dispensed | `0000030000` | 30.00 | Decimal, no decimal point, implied 2 decimal places |
| Gross Amount Due | `0000084F` | 8.46 | Positive: `F` = `6` → last digit is 6 → 8.46 |
| Negative Amount | `0000084J` | -8.41 | Negative: `J` = `1` → last digit is 1, negative → -8.41 |
| Zero Amount | `0000000000{` | 0.00 | Positive zero: `{` = `0` → 0.00 |
| Ingredient Cost | `0000057A` | 5.71 | Positive: `A` = `1` → last digit is 1 → 5.71 |
| Dispensing Fee | `0000027E` | 2.75 | Positive: `E` = `5` → last digit is 5 → 2.75 |

### Decoding Step by Step

Let's decode `0000084F`:

1. The raw value is `0000084F`
2. The last character is `F`
3. Look up `F` in the positive overpunch table → `F` represents digit `6`, sign positive
4. Replace `F` with `6` → `00000846`
5. Apply implied decimal (2 places) → `8.46`
6. Apply sign (positive) → **8.46**

Now decode `0000084J`:

1. The raw value is `0000084J`
2. The last character is `J`
3. Look up `J` in the negative overpunch table → `J` represents digit `1`, sign negative
4. Replace `J` with `1` → `00000841`
5. Apply implied decimal (2 places) → `8.41`
6. Apply sign (negative) → **-8.41**

## Data Type Summary

| Type | Format | Example Raw | Example Decoded |
|------|--------|-------------|-----------------|
| String | Plain text | `JANE` | `JANE` |
| Date | `YYYYMMDD` | `19800225` | `1980-02-25` |
| Integer | Zero-padded | `030` | `30` |
| Decimal | No decimal point | `0000030000` | `30.00` |
| Decimal (signed) | Signed overpunch | `0000084F` | `8.46` |
| Decimal (negative) | Signed overpunch | `0000084J` | `-8.41` |
| Decimal (zero) | Signed overpunch | `0000000000{` | `0.00` |

## See Also

- [Fields](fields.md) — How data types relate to field identifiers
- [Field Reference](field-reference.md) — Complete descriptions of every B1 claim field
- [Segments](segments.md) — Where data types appear in practice
- [Response](response.md) — Signed overpunch in response pricing
- [Examples: B1 Claim](examples/b1-claim.md) — Full decoded example

---

*Source: [Healthcare Data Insight — NCPDP Telecom Format for Mere Mortals](https://datainsight.health/ncpdp/intro/)*