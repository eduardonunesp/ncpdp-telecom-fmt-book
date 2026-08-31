# Health Maintenance Organizations (HMOs)

A **Health Maintenance Organization** (**HMO**) is a managed care organization that provides or arranges health services for a fixed annual fee (premium). HMOs are one of the most common payer types in the U.S. healthcare system, and they sit upstream of Pharmacy Benefit Managers in the pharmacy claims pipeline.

Understanding HMOs is relevant to NCPDP because HMOs are **payers** — they sponsor the health plans whose pharmacy benefits are adjudicated through NCPDP transactions. Many of the fields in an NCPDP claim (plan IDs, group IDs, eligibility codes, prior authorization requirements) exist in part because of how HMOs structure their benefits.

## How HMOs Work

HMOs operate on a **capitation model**: they receive a fixed premium per enrollee and are responsible for providing (or arranging) all covered care, regardless of how much the enrollee actually uses. This contrasts with traditional fee-for-service indemnity insurance, where the insurer pays for each service rendered.

This financial structure creates incentives for HMOs to manage utilization:

- **Gatekeeping** — Most HMOs require members to select a **primary care physician (PCP)** who acts as a gatekeeper. The PCP must authorize referrals to specialists before the HMO will cover the visit. This gatekeeping model is one reason **prior authorization** exists in pharmacy benefits — the HMO requires approval before covering certain drugs, just as it requires PCP referrals for specialist visits.
- **Utilization review** — HMOs monitor provider behavior to identify over-utilization or under-utilization. In pharmacy, this maps to the drug utilization review (DUR) that PBMs perform during claims adjudication.
- **Preventive care** — Because HMOs bear the full cost of illness, they have a financial incentive to invest in preventive care (immunizations, screenings, wellness visits). Many HMO plans cover preventive medications at reduced or zero cost-sharing.

### Cost-Sharing Under HMOs

Even though HMOs are capitated, members typically pay:

- **Copayments** — fixed amounts per service (e.g., $10 per generic prescription)
- **Coinsurance** — a percentage of the cost (less common in HMO pharmacy benefits)
- **Deductibles** — less common in HMOs than in other plan types; many HMO plans have no deductible for pharmacy benefits

These cost-sharing amounts appear in NCPDP response fields (e.g., patient paid amount, copay amounts).

## HMO Types and Their Effect on Pharmacy Claims

HMOs operate in several organizational models. The model affects how pharmacy benefits are managed and, by extension, how NCPDP claims flow.

| Model | How It Works | Pharmacy Claims Impact |
|-------|-------------|----------------------|
| **Staff model** | Physicians are salaried employees of the HMO; practices are HMO-owned | Pharmacy benefits are tightly controlled; formularries are narrow; claims may be processed through a captive PBM or directly by the HMO |
| **Group model** | HMO contracts with a multi-specialty physician group; physicians are employed by the group, not the HMO | Similar to staff model for claims; the group may have its own pharmacy policies aligned with the HMO's formulary |
| **Independent Practice Association (IPA) model** | HMO contracts with an IPA, which in turn contracts with independent physicians | More provider choice; pharmacy benefits are typically outsourced to an external PBM; NCPDP claims follow the standard PBM adjudication path |
| **Network model** | HMO contracts with any combination of groups, IPAs, and individual physicians | Most common model today; pharmacy benefits are almost always managed by a PBM; NCPDP claims are standard B1 transactions submitted to the PBM |

In practice, most HMOs today use the **network model** and outsource pharmacy benefit management to one of the major PBMs. This means the NCPDP transaction flow for an HMO member is:

```
Pharmacy  →  PBM (adjudicates on behalf of the HMO's plan)  →  HMO (sponsors the plan)
```

The HMO itself rarely sees the raw NCPDP transaction — the PBM acts as the intermediary.

## HMOs Compared to Other Payer Types

HMOs are one of several managed care models that serve as payers in the pharmacy claims pipeline. The key distinctions affect which NCPDP fields matter most.

| Payer Type | Key Characteristic | Formulary | Prior Auth | Referrals Required | Typical NCPDP Impact |
|------------|-------------------|-----------|------------|---------------------|----------------------|
| **HMO** | Capitated; gatekeeper PCP | Narrow | Frequent | Yes | More rejections for non-formulary drugs; more prior auth requirements (field `431` or segment `7X`) |
| **PPO** | Broader network; no gatekeeper | Broader | Less frequent | No | Fewer rejections; higher cost-sharing for out-of-network |
| **EPO** | Like HMO but no out-of-network coverage | Moderate | Moderate | No | Similar to HMO for formulary, but without gatekeeper referral step |
| **POS** | Hybrid of HMO and PPO; member chooses at point of service | Varies | Varies | If HMO-style | Member's choice of benefit tier affects copay fields in the response |
| **Medicare Part D** | Federal drug benefit for seniors and disabled | Plan-specific | Plan-specific | N/A | Standard NCPDP; BIN `0` ranges identify Medicare transactions |
| **Medicaid** | State-federal program for low-income | State-specific | State-specific | N/A | State-specific BINs; coordination of benefits fields (`C8`) often relevant |

## The Gatekeeper Model and Prior Authorization

The HMO gatekeeper model — where a PCP must authorize specialist referrals — has a direct analog in pharmacy claims: **prior authorization (PA)**.

When an HMO's formulary requires prior authorization for a drug, the pharmacy's B1 claim will be **rejected** with a reject code indicating that PA is required. The prescriber (acting as the gatekeeper) must then submit a PA request to the PBM. Once approved, the pharmacy resubmits the claim with the PA number in the appropriate NCPDP field.

NCPDP fields related to prior authorization:

| Field ID | Name | Purpose |
|----------|------|---------|
| `431` | Prior Authorization Type Code | Indicates the type of prior authorization |
| `462` | Prior Authorization Number Submitted | The PA number assigned after approval |
| `7X` | Prior Authorization segment | Contains PA-related fields as a group |

This is one of the clearest examples of how an HMO's organizational model shapes the NCPDP transaction: the gatekeeper concept that governs referrals also governs whether a pharmacy can dispense a drug without additional approval.

## Regulation

HMOs are regulated at both the state and federal levels:

- **State regulation** — HMOs are licensed under a **certificate of authority (COA)**, not a traditional insurance license. State regulators also issue mandates requiring HMOs to cover specific benefits, which can include pharmacy benefits.
- **Federal regulation** — The **Health Maintenance Organization Act of 1973** required employers with 25 or more employees to offer federally certified HMO options. This act was a major driver of HMO growth. The dual-choice provision expired in 1995, but the regulatory framework remains.
- **HIPAA** — As health plans, HMOs are covered entities under HIPAA. HIPAA mandates the use of NCPDP telecom and batch standards for pharmacy claims, which is why every pharmacy transaction with an HMO-sponsored plan uses the NCPDP format.
- **ERISA** — The Employee Retirement Income Security Act can preempt state negligence claims against HMOs, depending on whether the harm results from plan administration or provider actions. This affects how claims disputes are resolved.

## History

| Year | Milestone |
|------|-----------|
| 1910 | Western Clinic in Tacoma, WA offers prepaid medical services to lumber mill employees at $0.50/member/month — considered the first HMO-like arrangement |
| 1929 | Ross-Loos Medical Group established in Los Angeles — widely considered the first HMO; initially served DWP employees at $1.50/month |
| 1929 | Dr. Michael Shadid creates a cooperative health plan in Elk City, OK; Baylor Hospital provides prepaid care to 1,500 teachers (origin of Blue Cross) |
| 1970 | Fewer than 40 HMOs remain in operation |
| 1973 | President Nixon signs the Health Maintenance Organization Act — requires employers with 25+ employees to offer federally certified HMO options; provides grants and loans for HMO development |
| 1977 | Federal certification process begins; HMOs start growing rapidly |
| 1995 | Dual-choice provision of the 1973 Act expires |
| 2000s | HMOs increasingly outsource pharmacy benefit management to standalone PBMs; vertical integration with insurers accelerates |
| 2010s | Shift toward network-model HMOs; most HMO pharmacy benefits are now adjudicated by the three largest PBMs |

The historical trend from HMO-managed pharmacy benefits to PBM-managed pharmacy benefits is directly relevant to NCPDP: it explains why NCPDP transactions are sent to PBMs rather than to HMOs themselves.

## Connection to NCPDP

HMOs affect NCPDP transactions in several concrete ways:

- **Plan identification** — HMO-sponsored plans are identified by the BIN number (field `C2`), group ID (field `C1`), and plan ID (field `C9`/`FO`). The BIN routes the claim to the correct PBM, which adjudicates on the HMO's behalf.
- **Eligibility verification** — HMO gatekeeping means that a claim may be rejected if the member's eligibility cannot be verified or if the prescribing provider is not in the HMO's network. The eligibility clarification code (field `C9`) and person code (field `C6`) carry this information.
- **Formulary restrictions** — HMOs tend to have narrower formularies than PPOs. When a drug is not on formulary, the claim is rejected and may require prior authorization. The product/service ID (field `E1`/`D7`, typically the NDC) is checked against the HMO's formulary during adjudication.
- **Prior authorization** — HMOs are more likely than other plan types to require prior authorization for drugs, especially brand-name and specialty medications. This results in PA-related fields being populated more frequently in HMO claims.
- **Cost-sharing** — HMO copayment structures (typically flat copays by tier) are reflected in the patient-paid amount fields in the NCPDP response. The pricing segment (`AM11`) and response pricing fields carry this information back to the pharmacy.
- **Coordination of benefits** — When an HMO member has other coverage (e.g., a spouse's PPO), the other coverage code (field `C8`) must be populated to indicate which plan is primary and which is secondary.

For a detailed explanation of the PBM's role in adjudicating claims on behalf of HMOs and other payers, see [Pharmacy Benefit Managers](pbms.md).

---

*Source: [Health maintenance organization — Wikipedia](https://en.wikipedia.org/wiki/Health_maintenance_organization)*