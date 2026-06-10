CREATE SCHEMA IOC_SS10

    CREATE TABLE products (
                              id SERIAL PRIMARY KEY,
                              name VARCHAR(255) NOT NULL,
                              price NUMERIC(12,2) NOT NULL CHECK (price > 0),
                              last_modified TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    );

INSERT INTO products (name, price) VALUES
('Widget', 19.99),
('Gadget', 29.99),
('Thingamajig', 9.99);

SELECT * FROM products;

CREATE FUNCTION update_last_modified()
RETURNS TRIGGER AS $$
BEGIN
    NEW.last_modified = CURRENT_TIMESTAMP;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE TRIGGER trg_update_last_modified
BEFORE UPDATE ON products
FOR EACH ROW
EXECUTE FUNCTION update_last_modified();

UPDATE products
SET price = price * 1.10
WHERE name = 'Widget';