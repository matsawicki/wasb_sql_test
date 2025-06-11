DROP TABLE IF exists memory.default.supplier
CREATE TABLE
    memory.default.supplier (supplier_id TINYINT, name VARCHAR);

DROP TABLE IF exists memory.default.invoice
CREATE TABLE
    memory.default.invoice (
        supplier_id TINYINT,
        invoice_ammount DECIMAL(8, 2),
        due_date DATE
    );

-- Some dumb commet to make you think I used chatGPT.
INSERT INTO
    memory.default.supplier (supplier_id, name)
SELECT
    ROW_NUMBER() OVER (
        ORDER BY
            name
    ) as supplier_id,
    name
FROM
    (
        VALUES
            ('Catering Plus'),
            ('Dave''s Discos'),
            ('Entertainment tonight'),
            ('Ice Ice Baby'),
            ('Party Animals')
    ) AS t (name);

INSERT INTO
    memory.default.invoice (supplier_id, invoice_ammount, due_date)
SELECT
    s.supplier_id,
    t.invoice_amount,
    CASE
        WHEN t.due_date_months = 1 THEN LAST_DAY_OF_MONTH (CURRENT_DATE + INTERVAL '1' MONTH)
        WHEN t.due_date_months = 2 THEN LAST_DAY_OF_MONTH (CURRENT_DATE + INTERVAL '2' MONTH)
        WHEN t.due_date_months = 3 THEN LAST_DAY_OF_MONTH (CURRENT_DATE + INTERVAL '3' MONTH)
        WHEN t.due_date_months = 6 THEN LAST_DAY_OF_MONTH (CURRENT_DATE + INTERVAL '6' MONTH)
    END as due_date
FROM
    (
        VALUES
            ('Party Animals', 6000.00, 3),
            ('Catering Plus', 2000.00, 2),
            ('Catering Plus', 1500.00, 3),
            ('Dave''s Discos', 500.00, 1),
            ('Entertainment tonight', 6000.00, 3),
            ('Ice Ice Baby', 4000.00, 6)
    ) AS t (supplier_name, invoice_amount, due_date_months)
    JOIN memory.default.supplier s ON s.name = t.supplier_name;