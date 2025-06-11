SELECT
    e1.employee_id,
    CONCAT (e1.employee_id, ',', e1.manager_id) as employee_loop
FROM
    memory.default.employees e1
    JOIN memory.default.employees e2 ON e1.manager_id = e2.employee_id
WHERE
    e2.manager_id = e1.employee_id
    AND e1.employee_id < e2.employee_id;