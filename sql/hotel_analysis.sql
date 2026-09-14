-- ============================================================
-- HOTEL BOOKING ANALYSIS
-- SQL BUSINESS ANALYSIS
-- ============================================================


-- ============================================================
-- 1. OVERALL BOOKING KPIs
-- ============================================================

SELECT
    COUNT(*) AS total_bookings,
    SUM(is_canceled) AS total_cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate,
    ROUND(AVG(adr), 2) AS average_adr,
    ROUND(AVG(total_nights), 2) AS average_length_of_stay
FROM hotel_bookings;


-- ============================================================
-- 2. BOOKINGS AND CANCELLATIONS BY HOTEL
-- ============================================================

SELECT
    hotel,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY hotel
ORDER BY cancellation_rate DESC;


-- ============================================================
-- 3. REVENUE BY HOTEL
-- ============================================================

SELECT
    hotel,
    COUNT(*) AS bookings,
    ROUND(SUM(estimated_revenue), 2) AS estimated_revenue,
    ROUND(AVG(estimated_revenue), 2) AS average_revenue,
    ROUND(AVG(adr), 2) AS average_adr
FROM hotel_bookings
GROUP BY hotel
ORDER BY estimated_revenue DESC;


-- ============================================================
-- 4. REALIZED REVENUE FROM NON-CANCELLED BOOKINGS
-- ============================================================

SELECT
    hotel,
    COUNT(*) AS completed_bookings,
    ROUND(SUM(estimated_revenue), 2) AS realized_revenue,
    ROUND(AVG(estimated_revenue), 2) AS average_revenue
FROM hotel_bookings
WHERE is_canceled = 0
GROUP BY hotel
ORDER BY realized_revenue DESC;


-- ============================================================
-- 5. CANCELLATION BY MARKET SEGMENT
-- ============================================================

SELECT
    market_segment,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY market_segment
HAVING COUNT(*) >= 100
ORDER BY cancellation_rate DESC;


-- ============================================================
-- 6. CANCELLATION BY DISTRIBUTION CHANNEL
-- ============================================================

SELECT
    distribution_channel,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY distribution_channel
HAVING COUNT(*) >= 100
ORDER BY cancellation_rate DESC;


-- ============================================================
-- 7. CANCELLATION BY DEPOSIT TYPE
-- ============================================================

SELECT
    deposit_type,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY deposit_type
ORDER BY cancellation_rate DESC;


-- ============================================================
-- 8. CANCELLATION BY CUSTOMER TYPE
-- ============================================================

SELECT
    customer_type,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY customer_type
ORDER BY cancellation_rate DESC;


-- ============================================================
-- 9. CANCELLATION BY LEAD TIME GROUP
-- ============================================================

SELECT
    CASE
        WHEN lead_time <= 7 THEN '0-7 days'
        WHEN lead_time <= 30 THEN '8-30 days'
        WHEN lead_time <= 90 THEN '31-90 days'
        WHEN lead_time <= 180 THEN '91-180 days'
        WHEN lead_time <= 365 THEN '181-365 days'
        ELSE '365+ days'
    END AS lead_time_group,

    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate

FROM hotel_bookings

GROUP BY lead_time_group

ORDER BY
    CASE
        WHEN lead_time_group = '0-7 days' THEN 1
        WHEN lead_time_group = '8-30 days' THEN 2
        WHEN lead_time_group = '31-90 days' THEN 3
        WHEN lead_time_group = '91-180 days' THEN 4
        WHEN lead_time_group = '181-365 days' THEN 5
        ELSE 6
    END;


-- ============================================================
-- 10. MONTHLY BOOKING DEMAND
-- ============================================================

SELECT
    arrival_date_year AS year,
    arrival_month_number AS month_number,
    arrival_date_month AS month,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY
    arrival_date_year,
    arrival_month_number,
    arrival_date_month
ORDER BY
    year,
    month_number;


-- ============================================================
-- 11. MONTHLY ADR
-- ============================================================

SELECT
    arrival_month_number AS month_number,
    arrival_date_month AS month,
    ROUND(AVG(adr), 2) AS average_adr
FROM hotel_bookings
GROUP BY
    arrival_month_number,
    arrival_date_month
ORDER BY month_number;


-- ============================================================
-- 12. TOP 15 COUNTRIES BY BOOKINGS
-- ============================================================

SELECT
    country,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate,
    ROUND(AVG(adr), 2) AS average_adr
FROM hotel_bookings
WHERE country IS NOT NULL
GROUP BY country
ORDER BY bookings DESC
LIMIT 15;


-- ============================================================
-- 13. LENGTH OF STAY ANALYSIS
-- ============================================================

SELECT
    total_nights,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(adr), 2) AS average_adr,
    ROUND(AVG(estimated_revenue), 2) AS average_revenue,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY total_nights
HAVING COUNT(*) >= 20
ORDER BY total_nights;


-- ============================================================
-- 14. ROOM TYPE DEMAND
-- ============================================================

SELECT
    reserved_room_type,
    COUNT(*) AS bookings
FROM hotel_bookings
GROUP BY reserved_room_type
ORDER BY bookings DESC;


-- ============================================================
-- 15. ROOM CHANGE ANALYSIS
-- ============================================================

SELECT
    reserved_room_type,
    COUNT(*) AS bookings,
    SUM(
        CASE
            WHEN reserved_room_type != assigned_room_type THEN 1
            ELSE 0
        END
    ) AS room_changes,

    ROUND(
        AVG(
            CASE
                WHEN reserved_room_type != assigned_room_type THEN 1.0
                ELSE 0.0
            END
        ) * 100,
        2
    ) AS room_change_rate

FROM hotel_bookings

GROUP BY reserved_room_type

ORDER BY bookings DESC;


-- ============================================================
-- 16. SPECIAL REQUESTS VS CANCELLATION
-- ============================================================

SELECT
    total_of_special_requests AS special_requests,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY total_of_special_requests
ORDER BY special_requests;


-- ============================================================
-- 17. HOTEL + MONTH PERFORMANCE
-- ============================================================

SELECT
    hotel,
    arrival_month_number AS month_number,
    arrival_date_month AS month,
    COUNT(*) AS bookings,
    ROUND(AVG(adr), 2) AS average_adr,
    ROUND(AVG(total_nights), 2) AS average_stay
FROM hotel_bookings
GROUP BY
    hotel,
    arrival_month_number,
    arrival_date_month
ORDER BY
    hotel,
    month_number;


-- ============================================================
-- 18. HOTEL + CUSTOMER TYPE
-- ============================================================

SELECT
    hotel,
    customer_type,
    COUNT(*) AS bookings,
    SUM(is_canceled) AS cancellations,
    ROUND(AVG(is_canceled) * 100, 2) AS cancellation_rate
FROM hotel_bookings
GROUP BY
    hotel,
    customer_type
ORDER BY
    hotel,
    cancellation_rate DESC;


-- ============================================================
-- 19. HIGH-RISK BOOKING PROFILE
-- ============================================================

SELECT
    hotel,
    market_segment,
    deposit_type,
    customer_type,

    COUNT(*) AS bookings,

    SUM(is_canceled) AS cancellations,

    ROUND(
        AVG(is_canceled) * 100,
        2
    ) AS cancellation_rate

FROM hotel_bookings

GROUP BY
    hotel,
    market_segment,
    deposit_type,
    customer_type

HAVING COUNT(*) >= 100

ORDER BY
    cancellation_rate DESC
LIMIT 20;


-- ============================================================
-- 20. FINAL MANAGEMENT KPI
-- ============================================================

SELECT

    COUNT(*) AS total_bookings,

    SUM(is_canceled) AS cancelled_bookings,

    COUNT(*) - SUM(is_canceled) AS completed_bookings,

    ROUND(
        AVG(is_canceled) * 100,
        2
    ) AS cancellation_rate,

    ROUND(
        AVG(adr),
        2
    ) AS average_adr,

    ROUND(
        AVG(total_nights),
        2
    ) AS average_stay,

    ROUND(
        SUM(
            CASE
                WHEN is_canceled = 0
                THEN estimated_revenue
                ELSE 0
            END
        ),
        2
    ) AS realized_revenue

FROM hotel_bookings;