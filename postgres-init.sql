CREATE TABLE IF NOT EXISTS employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100),
    department VARCHAR(50),
    salary INT
);

INSERT INTO employees (name, department, salary) VALUES
('Alice', 'IT', 6000),
('Bob', 'Finance', 5500),
('Charlie', 'HR', 5000);