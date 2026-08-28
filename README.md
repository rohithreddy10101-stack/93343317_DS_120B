# Hotel Booking Performance, Cancellation and Revenue Analysis Using Power BI

## 📌 Project Overview

This project develops an interactive **Power BI dashboard** for analysing hotel booking performance, cancellation behaviour and revenue generation.

The analysis uses historical hotel booking data covering **City Hotel and Resort Hotel**. The project follows an end-to-end data analytics workflow including data cleaning, transformation, calculated columns, DAX measures and interactive dashboard development.

The final dashboard consists of two pages:

- **Executive Overview**
- **Cancellation & Revenue**

---

## 🎯 Problem Statement

Hotel booking data contains valuable information about booking volumes, cancellations, revenue, lead time, deposit types, market segments and hotel performance.

However, analysing these variables through raw data or static reports can make it difficult to identify important patterns and compare hotel performance.

This project aims to provide an interactive business intelligence solution that helps analyse:

- Booking performance
- Cancellation behaviour
- Revenue generation
- Average Daily Rate (ADR)
- Hotel-level performance
- Lead-time cancellation patterns
- Deposit-type cancellation patterns
- Market-segment performance
- Monthly booking trends

---

## 🎯 Project Objectives

- Develop an interactive Power BI dashboard for hotel booking analysis.
- Analyse total, completed and cancelled bookings.
- Calculate and visualise cancellation rates.
- Compare City Hotel and Resort Hotel performance.
- Analyse the relationship between lead time and cancellations.
- Analyse cancellation rates by deposit type.
- Analyse cancellation rates by market segment.
- Analyse realised revenue by hotel and market segment.
- Analyse monthly booking and ADR trends.
- Provide interactive filtering through a Hotel slicer.

---

## 📊 Dataset

The cleaned analytical dataset contains:

**87,229 booking records**

The dataset includes information related to:

| Category | Examples |
|---|---|
| Hotel | City Hotel, Resort Hotel |
| Booking | Lead Time, Reservation Status |
| Revenue | Estimated Revenue, ADR |
| Cancellation | Is Canceled |
| Deposit | No Deposit, Non Refund, Refundable |
| Market | Market Segment |
| Stay | Total Nights |
| Guests | Total Guests |
| Date | Arrival Date, Arrival Month |

---

## 🧹 Data Cleaning & Transformation

The raw dataset was prepared before dashboard development.

The cleaning process included:

- Removing duplicate records
- Removing zero-guest records
- Removing invalid negative ADR records
- Handling data quality issues
- Creating total-night calculations
- Creating total-guest calculations
- Creating cancellation indicators
- Creating revenue-related fields
- Creating arrival-date fields
- Creating lead-time groups
- Creating a Lead Time Sort column

### Data Cleaning Summary

| Metric | Records |
|---|---:|
| Original records | 119,390 |
| Duplicate records removed | 31,994 |
| Zero-guest records removed | 166 |
| Negative ADR records removed | 1 |
| Final records | 87,229 |

---

## 📐 DAX Measures

The project uses DAX measures to calculate key business metrics.

### Total Bookings

```DAX
Total Bookings =
COUNTROWS('hotel_bookings_clean')
