CREATE TABLE Financial_Services AS(
	SELECT *
FROM investment_subset
WHERE market = 'FinancialServices'
	)
;

UPDATE financial_services
SET market = (
CASE
	WHEN market = 'FincialServices' THEN 'FinancialServices'
	ELSE market
END)
;
-------------------------Data Cleaning-------------------------
SELECT *
FROM financial_services
WHERE funding_total_usd = null
;

DELETE FROM financial_services
WHERE funding_total_usd IS NULL 
;
-------------------------Data Exploration-------------------------
SELECT market, funding_total_usd, country_code, founded_year,seed,venture,equity_crowdfunding,undisclosed,convertible_note,debt_financing,private_equity
FROM financial_services
WHERE market = 'FinancialServices'
;
-------------------------Companies That Received Equity Crowdfunding-------------------------
SELECT *
FROM financial_services
WHERE equity_crowdfunding > 0 AND market = 'FinancialServices'
;
-------------------------Company Funding Total Highest to Lowest-------------------------
SELECT *
FROM financial_services
WHERE market = 'FinancialServices'
ORDER BY funding_total_usd DESC
;
-------------------------Company Funding Total Lowest to Highest-------------------------
SELECT *
FROM financial_services
WHERE market = 'FinancialServices'
ORDER BY founded_year ASC
;
-------------------------Checking Company Country Origin-------------------------
SELECT DISTINCT country_code
FROM financial_services
;
-------------------------Analyzing Company Funding(ALL)-------------------------
SELECT 
AVG(funding_total_usd) AS funding_total_avg,
MAX(funding_total_usd) AS funding_total_max,
MIN(funding_total_usd) AS funding_total_min,
COUNT(funding_total_usd) AS funding_total_count
FROM financial_services
WHERE market = 'FinancialServices'
;
-------------------------Analyzing Company Seed Funding(ALL)-------------------------
SELECT
COUNT(*) AS total_companies,
AVG(seed) AS avg_seed,
MAX(seed) AS max_seed,
MIN(seed) AS min_seed
FROM financial_services
WHERE market = 'FinancialServices'
;
-------------------------Analyzing Company Seed Funding by Country-------------------------
SELECT country_code,
COUNT(*) AS total_companies,
AVG(seed) AS avg_seed,
MAX(seed) AS max_seed,
MIN(seed) AS min_seed
FROM financial_services
WHERE market = 'FinancialServices'
GROUP BY country_code
ORDER BY avg_seed DESC
;
-------------------------Analyzing Company Funding by Country-------------------------
SELECT country_code,
COUNT(*) AS total_companies,
AVG(funding_total_usd) AS funding_total_avg,
MAX(funding_total_usd) AS funding_total_max,
MIN(funding_total_usd) AS funding_total_min
FROM financial_services
WHERE market = 'FinancialServices'
GROUP BY country_code
ORDER BY funding_total_avg DESC
;
-------------------------Analyzing Number of Operating Companies-------------------------
SELECT * FROM financial_services
WHERE status = 'operating'
;
SELECT *
FROM financial_services

;
-------------------------Excluding the Outlier from Analysis-------------------------
SELECT
AVG(equity_crowdfunding) AS avg_equity,
AVG(undisclosed) AS avg_undisclosed,
AVG(convertible_note) AS avg_convertible,
AVG(debt_financing) AS avg_debt,
AVG(private_equity) AS avg_private
FROM financial_services
WHERE funding_total_usd < 725000000
;