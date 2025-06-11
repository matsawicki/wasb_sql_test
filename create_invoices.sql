drop table if exists memory.default.supplier;

create table memory.default.supplier (
    supplier_id tinyint,
    name varchar
)

insert into memory.default.supplier (name) values
('Party Animals'),
('Catering Plus'),
("Dave''s Discos"),
('Entertainment tonight'),
('Ice Ice Baby')

update memory.default.supplier set supplier_id = row_number() over(partition by name order by (select null))

drop table if exists memory.default.invoice;

create table if not exists memory.defaul.invoices (
    id UUID default uuid(),
    id_supplier_id tinyint,
    invoice_items ARRAY(VARCHAR),
    invoice_amount DECIMAL(10,2),
    due_date_months INTEGER,
    created_date TIMESTAMP default CURRENT_TIMESTAMP
);

insert into memory.defaul.invoices (id, id_supplier_id, invoice_items, invoice_amount, due_date_months) values
(1, 5, ARRAY['Zebra', 'Lion', 'Giraffe', 'Hippo'], 6000.00, 3),
(2, 2, ARRAY['Champagne', 'Whiskey', 'Vodka', 'Gin', 'Rum', 'Beer', 'Wine'], 2000.00, 2),
(3, 2, ARRAY['Pizzas', 'Burgers', 'Hotdogs', 'Cauliflour Wings', 'Caviar'], 1500.00, 3),
(4, 1, ARRAY['Dave', 'Dave Equipment'], 500.00, 1),
(5, 3, ARRAY['Portable Lazer tag', 'go carts', 'virtual darts', 'virtual shooting', 'puppies'], 6000.00, 3),
(6, 4, ARRAY['Ice Luge', 'Lifesize ice sculpture of Umberto'], 4000.00, 6);