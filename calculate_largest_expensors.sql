SELECT
    e.employee_id,
    CONCAT (e.first_name, ' ', e.last_name) AS employee_name,
    e.manager_id,
    CONCAT (m.first_name, ' ', m.last_name) AS manager_name,
    expense_totals.total_expensed_amount
FROM
    (
        SELECT
            employee_id,
            SUM(unit_price * quantity) AS total_expensed_amount
        FROM
            memory.default.expense
        GROUP BY
            employee_id
        HAVING
            SUM(unit_price * quantity) > 1000
    ) expense_totals
    JOIN memory.default.employees e ON expense_totals.employee_id = e.employee_id
    LEFT JOIN memory.default.employees m ON e.manager_id = m.employee_id
ORDER BY
    expense_totals.total_expensed_amount DESC;