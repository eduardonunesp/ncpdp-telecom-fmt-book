# Separators

NCPDP transactions use **non-printable ASCII characters** as delimiters. In a raw NCPDP file, these characters appear as invisible bytes. Throughout this documentation, we use angle-bracket notation (e.g., `&lt;RS&gt;`, `&lt;FS&gt;`) to represent them clearly.

## Separator Characters

| Notation | ASCII | Hex | Name | Usage |
|----------|-------|-----|------|-------|
| `&lt;FS&gt;` | 28 | 0x1C | FS — Field Separator (Unit Separator) | Marks the start of a field |
| `&lt;GS&gt;` | 29 | 0x1D | GS — Group Separator | Separates repeating groups within a segment |
| `&lt;RS&gt;` | 30 | 0x1E | RS — Record Separator (Segment Start) | Marks the start of a segment |
| `&lt;STX&gt;` | 2 | 0x02 | STX — Start of Text | Marks the start of a batch header/trailer (batch standard only) |
| `&lt;ETX&gt;` | 3 | 0x03 | ETX — End of Text | Marks the end of a batch header/trailer (batch standard only) |

## How Separators Work

### Segment Separator (`&lt;RS&gt;` — RS)

The `&lt;RS&gt;` character indicates the beginning of a new segment. When the parser encounters `&lt;RS&gt;`, it knows that a new group of related fields (a segment) is starting.

```
&lt;RS&gt;&lt;FS&gt;AM04&lt;FS&gt;C2123456789&lt;FS&gt;CCJANE&lt;FS&gt;CDDOE&lt;FS&gt;FOMYPLAN&lt;FS&gt;C90&lt;FS&gt;C1GR1&lt;FS&gt;C3001&lt;FS&gt;C62
&lt;RS&gt;&lt;FS&gt;AM01&lt;FS&gt;C419800225&lt;FS&gt;C52&lt;FS&gt;CAJANE&lt;FS&gt;CBDOE&lt;FS&gt;CM100 MAIN STR&lt;FS&gt;CNWASHINGTON&lt;FS&gt;CODC&lt;FS&gt;CP100010000&lt;FS&gt;CQ5551234567
```

Each line above is a segment, and each starts with `&lt;RS&gt;`.

### Field Separator (`&lt;FS&gt;` — US)

The `&lt;FS&gt;` character indicates the beginning of a new field. A field starts with `&lt;FS&gt;` followed by a two-character field identifier, then the field's value:

```
&lt;FS&gt;CNWASHINGTON
```

- `&lt;FS&gt;` — field separator
- `CN` — field identifier (Patient City Address)
- `WASHINGTON` — field value

### No End Separators

> **Note:** There are **no end separators** in NCPDP. A segment or field ends when the next separator or the end of the file is encountered.

### Batch Separators (`&lt;STX&gt;` — STX, `&lt;ETX&gt;` — ETX)

The `&lt;STX&gt;` and `&lt;ETX&gt;` separators are defined in the NCPDP **batch standard**. They mark the start and end of batch headers and trailers, and also wrap each transaction within a batch file.

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

> **Warning:** The newline character (`\n`) is **not** a valid NCPDP separator. The segments above are shown on separate lines for readability, but in a real NCPDP file, all segments are concatenated in a single line.

## Telecom vs. Batch

| Feature | Telecom Standard | Batch Standard |
|---------|-----------------|----------------|
| Uses `&lt;RS&gt;` (RS) and `&lt;FS&gt;` (US) | Yes | Yes |
| Uses `&lt;STX&gt;` (STX) and `&lt;ETX&gt;` (ETX) | No | Yes |
| Transaction format | Single transaction per transmission | Multiple transactions per file |
| Header format | Fixed-length, no separators | Preceded by `&lt;STX&gt;`, includes `G1` identifier |

## See Also

- [Fields](fields.md) — How field identifiers work within segments
- [Segments](segments.md) — How fields are grouped into segments
- [Headers](headers.md) — Transaction header formats (batch vs telecom)
- [Response](response.md) — Response segments use the same separators

---

*Source: [Healthcare Data Insight — NCPDP Separators](https://datainsight.health/posts/ncpdp-separators/)*