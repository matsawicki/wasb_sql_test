-- Task: Generate payment plans for suppliers with monthly payments until due dates
WITH
    supplier_invoices AS (
        SELECT
            s.supplier_id,
            s.name as supplier_name,
            i.invoice_ammount,
            i.due_date,
            CAST(
                YEAR (i.due_date) - YEAR (LAST_DAY_OF_MONTH (CURRENT_DATE)) AS INT
            ) * 12 + CAST(
                MONTH (i.due_date) - MONTH (LAST_DAY_OF_MONTH (CURRENT_DATE)) AS INT
            ) + 1 as months_to_pay
        FROM
            memory.default.supplier s
            JOIN memory.default.invoice i ON s.supplier_id = i.supplier_id
    ),
    supplier_totals AS (
        SELECT
            supplier_id,
            supplier_name,
            SUM(invoice_ammount) as total_amount,
            MIN(months_to_pay) as min_months_to_pay,
            MAX(due_date) as latest_due_date
        FROM
            supplier_invoices
        GROUP BY
            supplier_id,
            supplier_name
    ),
    payment_schedule AS (
        SELECT
            st.supplier_id,
            st.supplier_name,
            st.total_amount / st.min_months_to_pay as payment_amount,
            st.total_amount as balance_outstanding,
            LAST_DAY_OF_MONTH (CURRENT_DATE + INTERVAL '1' MONTH * month_num) as payment_date,
            month_num
        FROM
            supplier_totals st
            CROSS JOIN UNNEST (SEQUENCE (1, st.min_months_to_pay)) AS t (month_num)
    )
SELECT
    supplier_id,
    supplier_name,
    ROUND(payment_amount, 2) as payment_amount,
    ROUND(balance_outstanding, 2) as balance_outstanding,
    payment_date
FROM
    payment_schedule
ORDER BY
    supplier_id,
    payment_date;