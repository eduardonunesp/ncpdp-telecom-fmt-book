# Pharmacy Benefit Managers (PBMs)

A **Pharmacy Benefit Manager** (**PBM**) is a third-party administrator of prescription drug programs for commercial health plans, self-insured employer plans, Medicare Part D plans, the Federal Employees Health Benefits Program, and state government employee plans.

PBMs are the primary recipients of NCPDP telecom transactions. When a pharmacy submits a claim (a B1 transaction), it is transmitted to a PBM — or to a payer that uses a PBM as its claims processor — for adjudication. Understanding what PBMs do and how they fit into the pharmacy supply chain is essential context for anyone working with NCPDP data.

## Role in the Pharmacy Supply Chain

PBMs act as intermediaries between four key parties:

| Party | Relationship to PBM |
|-------|---------------------|
| **Drug manufacturers** | PBMs negotiate rebates and discounts from manufacturers in exchange for favorable formulary placement |
| **Health plan sponsors** | PBMs manage the pharmacy benefit on behalf of employers, insurers, and government programs |
| **Pharmacies** | PBMs maintain pharmacy networks, set reimbursement rates, and adjudicate claims submitted via NCPDP |
| **Patients / enrollees** | PBMs determine patient cost-sharing (copays, coinsurance) through formulary tier design |

When a pharmacy submits an NCPDP B1 claim, the PBM receives it, applies its formulary and pricing rules, and returns an NCPDP response (see [Response](response.md)) indicating whether the claim is paid, rejected, or requires additional information.

## Core Functions

### Claims Adjudication

PBMs process pharmacy claims submitted via the NCPDP telecom standard. This is the most direct connection between PBMs and the NCPDP format covered in this documentation. The PBM:

1. Receives the B1 claim transaction from the pharmacy
2. Verifies patient eligibility and plan coverage
3. Applies formulary rules (e.g., prior authorization, step therapy)
4. Calculates reimbursement to the pharmacy and patient cost-sharing
5. Returns an NCPDP response with the adjudication result

### Formulary Management

PBMs construct and maintain **formularies** — lists of drugs covered under a health plan, typically organized into tiers:

| Tier | Typical Cost | Example |
|------|-------------|---------|
| Tier 1 (Preferred Generic) | Lowest copay | Generic metformin |
| Tier 2 (Non-preferred Generic) | Moderate copay | Generic alternatives |
| Tier 3 (Preferred Brand) | Higher copay | Brand-name drugs with rebates |
| Tier 4 (Non-preferred Brand) | Highest copay | Brand-name drugs without rebates |

Drugs not on the formulary may require the patient to pay the full list price. Manufacturers often pay rebates to PBMs to secure favorable formulary placement.

### Pharmacy Network Management

PBMs establish networks of pharmacies that agree to their reimbursement terms. Pharmacies in the network accept the PBM's reimbursement rates in exchange for patient volume. PBMs may also operate their own mail-order or specialty pharmacies.

### Rebate Negotiation

PBMs negotiate rebates from drug manufacturers. A rebate is a payment from the manufacturer to the PBM (or plan sponsor) in exchange for the PBM placing the manufacturer's drug on its formulary. The extent to which these rebates are passed through to plan sponsors or patients has been a significant source of controversy.

### Drug Utilization Review

PBMs perform **prospective** (at point of sale), **concurrent** (during therapy), and **retrospective** (after the fact) drug utilization reviews to check for drug interactions, therapeutic duplications, and appropriate dosing.

## History

| Year | Milestone |
|------|-----------|
| 1968 | Pharmaceutical Card System Inc. (PCS, later AdvancePCS) founded — the first PBM — invents the plastic benefit card |
| 1970s | PBMs serve as fiscal intermediaries, adjudicating prescription drug claims by paper |
| 1980s | Claims adjudication moves to electronic transmission, the precursor to today's NCPDP telecom standard |
| Late 1980s | PBMs become a major force as health care and prescription costs escalate |
| 2007 | CVS acquires Caremark; PBMs shift from processing transactions to managing the full pharmacy benefit |
| 2012 | Express Scripts and CVS Caremark introduce formularies that exclude drugs entirely (not just tier them) |
| 2018 | Cigna acquires Express Scripts for $67 billion |
| 2024 | FTC releases interim report on PBM practices; sues the three largest PBMs |

## Market Structure

As of 2023, PBMs managed pharmacy benefits for approximately 275 million Americans. The three largest PBMs control roughly 80% of the market:

| PBM | Parent Company | Key Acquisition |
|-----|---------------|-----------------|
| **Express Scripts** | Cigna | Acquired Medco Health Solutions (2012); acquired by Cigna (2018) |
| **CVS Caremark** | CVS Health | CVS acquired Caremark (2007); CVS merged with Aetna (2018) |
| **OptumRx** | UnitedHealth Group | Acquired Catamaran (2015) |

Together these three PBMs manage benefits covering approximately 270 million people, with a combined market of nearly $600 billion (2024).

The remaining market share is held by smaller PBMs including Humana Pharmacy Solutions, Prime Therapeutics, and MedImpact Healthcare Systems.

## Vertical Integration

Each of the three largest PBMs is vertically integrated with a health insurer and a pharmacy operation:

- **CVS Health** owns CVS Caremark (PBM), Aetna (insurer), and CVS Pharmacy (retail pharmacy)
- **Cigna** owns Express Scripts (PBM) and merged with Evernorth (health services)
- **UnitedHealth Group** owns OptumRx (PBM), UnitedHealthcare (insurer), and OptumRx mail-order pharmacy

This vertical integration has drawn scrutiny because it creates potential conflicts of interest: the same entity that adjudicates claims also owns the pharmacies that fill them.

## Business Model and Controversies

### Spread Pricing

PBMs may charge a plan sponsor a higher price for a drug than the amount they reimburse the pharmacy, keeping the difference (the "spread"). This practice, known as **spread pricing**, reduces transparency in drug pricing.

### Clawbacks

When a patient's insurance copayment exceeds the actual cash price of a drug, the PBM may collect the higher copayment and retain the difference. This is known as a **clawback**. As of 2018, federal legislation banned "gag clauses" that prevented pharmacists from informing patients about cheaper cash prices.

### Gag Clauses

Historically, PBM contracts prohibited pharmacists from voluntarily telling patients when a drug's cash price was lower than the insurance copayment. Federal law now prohibits such gag clauses for both private insurance (effective October 2018) and Medicare (effective January 2020).

### PBM-Affiliated GPOs

Starting in 2019, each of the three major PBMs established affiliated Group Purchasing Organizations (GPOs):

| PBM | Affiliated GPO | Year Established | Headquarters |
|-----|---------------|-----------------|-------------|
| Express Scripts | Ascent Health Services | 2019 | Switzerland |
| CVS Health | Zinc Health Services | 2020 | United States |
| OptumRx | Emisar Pharma Services | 2021 | Ireland |

Critics argue these GPOs allow PBMs to avoid regulations and audits, create additional fee-capture outlets, and serve as safe harbors from anti-kickback statutes.

### Effect on Independent Pharmacies

PBMs set reimbursement rates for community pharmacies. Because PBMs are not required to disclose how rebate rates are calculated, independent pharmacies may be reimbursed at rates at or below the acquisition cost of drugs. Additionally, vertically integrated PBMs may steer patients toward their own affiliated pharmacies, creating competitive disadvantages for unaffiliated independent pharmacies.

## PBM Regulation

### State-Level Regulation

As of 2025, all 50 U.S. states have enacted some form of PBM-related legislation, totaling 229 laws (44 enacted in 2025 alone). State regulations address:

- **Pharmacy operations** (45 states)
- **Pricing and reimbursement** (41 states)
- **Licensure and registration** (36 states)
- **Reporting requirements** (26 states)
- **Pharmacy networks** (25 states)

### Federal Regulation

Key federal legislation affecting PBMs:

| Law | Year | Key Provision |
|-----|------|---------------|
| Know the Lowest Price Act | 2018 | Prohibits Medicare/Medicare Advantage plans from restricting pharmacists from disclosing cash prices |
| Patient Right to Know Drug Prices Act | 2018 | Prohibits private insurance plans and PBMs from gag clauses |
| Consolidated Appropriations Act | 2026 | Requires PBMs to pass through 100% of rebates to employer plans; adds transparency and reporting requirements; shifts Medicare PBM reimbursement to a flat-fee model (starting 2028) |

In January 2026, the U.S. Department of Labor's Employee Benefits Security Administration (EBSA) proposed a regulation requiring PBMs to disclose to employers: the net cost of every drug on the formulary, manufacturer compensation and rebates, recouped payments from pharmacies, and therapeutically equivalent alternatives.

## Connection to NCPDP

The NCPDP telecom standard exists primarily to enable pharmacies to communicate with PBMs (and the payers they represent). Every B1 claim submitted by a pharmacy is adjudicated by a PBM, which returns an NCPDP response. Key fields in the claim that PBMs directly use include:

- **BIN number** (field `C2`) — identifies the PBM/payer
- **Group ID** (field `C1`) — identifies the employer group within the PBM
- **Plan ID** (field `C9` / `FO`) — identifies the specific benefit plan
- **Product/service ID** (field `E1`/`D7`) — the NDC code, used by the PBM to apply formulary rules
- **Other coverage code** (field `C8`) — tells the PBM about coordination of benefits
- **Prior authorization number** (if applicable) — required when the PBM has mandated prior authorization

Understanding the PBM's role helps explain why certain NCPDP fields exist: many of them are there specifically for the PBM to make coverage, pricing, and reimbursement decisions during adjudication.

## Drug Pricing and Formulary Tiers

PBM reimbursement and formulary design are driven by the brand-to-generic lifecycle. When a drug is under patent, the manufacturer sets a list price (Wholesale Acquisition Cost, or WAC) and may pay rebates to PBMs for favorable formulary placement. When patents expire, generic manufacturers enter the market and prices drop dramatically — generics typically cost 80–85% less than their brand-name counterparts.

This lifecycle shapes the four-tier formulary structure:

- **Tier 1 (Preferred Generic)** — Off-patent drugs with multiple generic manufacturers; lowest cost to patients
- **Tier 2 (Non-preferred Generic)** — Generic drugs where fewer manufacturers compete; moderate cost
- **Tier 3 (Preferred Brand)** — Brand-name drugs still under patent where the manufacturer pays rebates to the PBM for formulary placement
- **Tier 4 (Non-preferred Brand)** — Brand-name drugs without rebate agreements; highest cost to patients

The **Dispense as Written (DAW)** code in NCPDP (field `D8`) is the mechanism by which a prescriber or patient can override the PBM's default generic substitution. When a DAW code is present, the PBM must reimburse at the brand price rather than the generic benchmark.

For a deeper explanation of drug pricing benchmarks (WAC, AMP, 340B, NADAC) and how they flow into NCPDP pricing fields, see [Industry Context](industry-context.md#drug-pricing).

## Real-Time Pharmacy Benefit Inquiry (RTPBI)

PBMs also participate in the **Real-Time Pharmacy Benefit Inquiry (RTPBI)** — a separate NCPDP standard where a prescriber queries the PBM for patient-specific benefit information before a prescription is written. Unlike the B1 claim (which is pharmacy-initiated at the point of sale), RTPBI is prescriber-initiated at the point of care. The PBM responds in real time with information about formulary status, coverage restrictions, and estimated patient cost share.

See [Real-Time Pharmacy Benefit Inquiry](rtpbi.md) for the full documentation of this transaction.

---

*Source: [Pharmacy benefit management — Wikipedia](https://en.wikipedia.org/wiki/Pharmacy_benefit_management)*