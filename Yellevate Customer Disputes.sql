CREATE TABLE IF NOT EXISTS yellevate_invoices(

country varchar,
customer_id varchar,
invoice_number numeric,
invoice_date date,
due_date date,
invoice_amount_usd numeric,
disputed numeric,
dispute_lost numeric,
settled_date date,
days_settled integer,
days_late integer
);

SELECT customer_id, country
FROM yellevate_invoices
WHERE country = 'France'
ORDER BY customer_id DESC
;

SELECT * FROM yellevate_invoices
;

SELECT DISTINCT country 
FROM yellevate_invoices;

--GLOBAL AVG DAYS SETTLED
SELECT ROUND(AVG(days_settled))
FROM yellevate_invoices;

--BY COUNTRY DAYS SETTLED
SELECT country,ROUND(AVG(days_settled))
FROM yellevate_invoices
GROUP BY country;

--GLOBAL AVG DISPUTE DAYS
SELECT ROUND(AVG(days_settled))
FROM yellevate_invoices
WHERE disputed = 1;

--BY COUNTRY AVG DISPUTE DAYS
SELECT country,ROUND(AVG(days_settled)),disputed
FROM yellevate_invoices
GROUP BY country,disputed
HAVING disputed = 1;

--SUM AMOUNT LOST
SELECT country,SUM(invoice_amount_usd),disputed,dispute_lost
FROM yellevate_invoices
GROUP BY country,disputed,dispute_lost
HAVING disputed = 1 AND dispute_lost = 1;

--PERCENTAGE OF DISPUTE LOST
SELECT 
SUM(
CASE
	WHEN disputed = 1 
	THEN 1 ELSE 0
	END
) AS total_disputes, 
SUM(
CASE
	WHEN disputed = 1 AND dispute_lost = 0
	THEN 1 ELSE 0
	END 
) AS won_disputes,
SUM(
CASE
	WHEN disputed = 1 AND dispute_lost = 1
	THEN 1 ELSE 0
	END 
) AS lost_disputes
FROM yellevate_invoices;

--PERCENT LOST TO DISPUTES
SELECT SUM(invoice_amount_usd) AS total_revenue,
ROUND(SUM(
CASE
	WHEN disputed = 1 AND dispute_lost = 1
	THEN invoice_amount_usd
	END
),2) AS revenue_lost
FROM yellevate_invoices
;

--GLOBAL TOTAL LOSSES TO DISPUTES
SELECT SUM(invoice_amount_usd) AS invoice_amount_usd,
ROUND(SUM(
CASE
	WHEN disputed = 1 AND dispute_lost = 1
	THEN invoice_amount_usd
	END
),2) AS revenue_lost
FROM yellevate_invoices
;

--COUNTRY WITH HIGHEST LOSSES TO DISPUTES
SELECT country, SUM(invoice_amount_usd) AS invoice_amount_usd,
ROUND(SUM(
CASE
	WHEN disputed = 1 AND dispute_lost = 1
	THEN invoice_amount_usd
	END
),2) AS revenue_lost
FROM yellevate_invoices
GROUP BY country
ORDER BY revenue_lost DESC
;

