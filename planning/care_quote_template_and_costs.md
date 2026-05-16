# Care Quote Template + Current Cost Calculations

Use this sheet to compare provider quotes consistently. Figures below use only currently available data from `planning/response-asana.txt` and `planning/response-active-global.txt`.

## 1) Quote comparison template (fill this once quotes arrive)

| Provider | Service type | Shift pattern | Base rate | Night/Sun/PH surcharge | GST included? | Min booking | Upfront payment | Cancellation | Est total (4 weeks) | Notes |
|---|---|---|---|---|---|---|---|---|---|---|
| Aseana | Adhoc caregiver | | | Sun +$50, PH +$90 | No (add 9%) | 6 continuous days | Yes | $100 + GST admin fee after confirmation | | Subject to availability |
| Active Global | Private nursing | | | +$5.50/hr at night, Sundays, PH (5h+) | Unclear | Not stated | Not stated | Not stated | | No house chores/cooking |
| Homage | Caregiver / night care / nurse | | | | | | | | | Ask for package vs hourly night pricing |
| Jaga-Me | Home personal care / nurse | | | | | | | | | Ask night package vs hourly + surcharge |
| Live-in option | Agency/live-in caregiver | | | | | Usually long contract structure | High upfront | Depends on agency terms | | Best only if support likely >3 months |

## 2) Aseana calculated costs (from currently available rates)

Source: `planning/response-asana.txt:56`

- Rates given:
  - Full shift: $300 + GST (day 8am-8pm, night 10pm-8am)
  - 8h (or less): $270 + GST
  - Sunday surcharge: +$50
  - Public holiday surcharge: +$90
  - 10% discount for continuous service 20+ days
  - Minimum service: 6 continuous days

Estimated totals (including 9% GST, before Sunday/PH surcharge):

| Aseana adhoc scenario | Formula | Estimated total |
|---|---|---|
| 6 days, full shift | 6 x 300 x 1.09 | $1,962.00 |
| 6 days, 8h shift | 6 x 270 x 1.09 | $1,765.80 |
| 14 days, full shift | 14 x 300 x 1.09 | $4,578.00 |
| 14 days, 8h shift | 14 x 270 x 1.09 | $4,120.20 |
| 28 days, full shift | 28 x 300 x 1.09 | $9,156.00 |
| 28 days, 8h shift | 28 x 270 x 1.09 | $8,240.40 |
| 28 days, full shift with 10% discount | 28 x 300 x 0.9 x 1.09 | $8,240.40 |

Add-ons:

- Add ~$218.00 for 4 Sundays (4 x 50 x 1.09)
- Add ~$98.10 per public holiday (90 x 1.09)
- Cancellation after confirmation: $109.00 admin fee ($100 + GST)

## 3) Active Global calculated costs (from currently available rates)

Source: `planning/response-active-global.txt:10`

- Rates given:
  - 10h or more: $27.50/hr
  - 5h to 9h: $29.00/hr
  - 2h to 4h: $62.60/hr
  - Surcharge: +$5.50/hr at night, Sundays, PH for 5h+ service
  - Note: this is private nursing (not chores/cooking support)

Estimated totals (before GST, because GST handling not explicitly stated in the response):

| Active Global nursing scenario | Formula | Estimated total |
|---|---|---|
| 14 days, 5h/day daytime | 14 x 5 x 29.00 | $2,030.00 |
| 14 days, 8h/day daytime | 14 x 8 x 29.00 | $3,248.00 |
| 28 days, 8h/day daytime | 28 x 8 x 29.00 | $6,496.00 |
| 14 nights, 8h/night | 14 x 8 x (29.00 + 5.50) | $3,864.00 |
| 14 days, 12h/day daytime | 14 x 12 x 27.50 | $4,620.00 |

High-support 4-week example (for planning only):

- Weeks 1-2: 12h daytime + 8h night daily
- Weeks 3-4: 8h daytime daily
- Estimated total = (14 x 12 x 27.50) + (14 x 8 x 34.50) + (14 x 8 x 29.00) = **$11,732.00** (before GST, before extra Sunday/PH assumptions)

## 4) Live-in caregiver costs (currently available info)

### Aseana live-in (explicit numbers available)

Source: `planning/response-asana.txt:7`

- One-time agency fee: $3,688 + GST = **$4,019.92**
- Third-party costs listed: **$1,170.20** (MOM + SIP + medical + embassy + OWWA + airfare + insurance/security bond)
- Salary starts from: **$800/month**

Estimated live-in totals:

| Aseana live-in scenario | Formula | Estimated total |
|---|---|---|
| Month 1 (excluding insurance not listed separately beyond above line items) | 4,019.92 + 1,170.20 + 800 | **$5,990.12** |
| Month 2 cumulative | 4,019.92 + 1,170.20 + (2 x 800) | **$6,790.12** |

Important notes:

- Contract structure is typically 2 years, though early termination is stated as allowed without penalty.
- Processing lead time was stated as roughly 2-5 weeks depending source country.
- Replacement requests can still incur replacement/third-party costs.

### Active Global live-in

- No explicit live-in fee breakdown was provided in the current Active Global response file.
- Current response only provides private nursing rates, so a live-in total cannot be reliably computed yet from that file alone.

## 5) Quick decision signal

- If your needed support is 4-10 weeks, short-term shift care usually stays cleaner operationally than initiating a live-in contract flow.
- If you expect >3 months of heavy daily support, live-in starts becoming more cost-competitive despite higher setup overhead.
