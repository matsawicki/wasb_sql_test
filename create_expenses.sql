DROP TABLE IF EXISTS memory.default.expense;

CREATE TABLE
    memory.default.expense (
        employee_id tinyint,
        unit_price decimal(8, 2),
        quantity tinyint
    );

INSERT INTO
    memory.default.expense
VALUES
    (3, 6.50, 14),
    (3, 11.00, 20),
    (3, 22.00, 18),
    (3, 13.00, 75),
    (9, 300.00, 1),
    (4, 40.00, 9),
    (2, 17.50, 4);