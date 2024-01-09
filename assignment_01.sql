use assignment_work;
select * from wfp_food_prices_pakistan;
-- _______________________________________________________
--- question_01
select  date ,cmname ,  mktname from wfp_food_prices_pakistan where mktname in ('Quetta', 'karachi' , 'peshawar') and price <=50; 
-- _______________________________________________________

--- question_02
select mktname, count(*) as observation
from wfp_food_prices_pakistan where country = 'PK'
group by mktname ;
-- ________________________________________________________

--- second method of question_02

SELECT mktname, COUNT(*) as observation_count
FROM wfp_food_prices_pakistan
GROUP BY mktname;
-- ________________________________________________________

-- question_03
select count(distinct mktname) as new_mktname from wfp_food_prices_pakistan;
-- _________________________________________________________

-- question_04
select mktname from wfp_food_prices_pakistan;
-- _________________________________________________________

-- question_05
select cmname from wfp_food_prices_pakistan;
-- _________________________________________________________

-- question_06
SELECT mktname, round(avg(price),2) as average_price
FROM wfp_food_prices_pakistan
WHERE cmname = 'Wheat flour - Retail'
GROUP BY mktname;
-- _________________________________________________________
-- question_07
select mktname,cmname, round(avg(price),2) as avg_price , max(price) as max_price from wfp_food_prices_pakistan
where mktname <> 'karachi' and cmname like 'wheat%'
group by mktname , cmname
order by mktname asc , cmname asc;
-- _____________________________________________________________
-- question_08
select mktname , cmname , round(avg(price),2) as avg_price 
from wfp_food_prices_pakistan where  cmname= 'wheat - retail' 
group by mktname having avg_price < 30;
-- _____________________________________________________________
-- question_09
SELECT price,
       CASE
           WHEN price < 30 THEN 'LOW'
           WHEN price > 250 THEN 'HIGH'
           ELSE 'FAIR'
       END AS price_category
FROM wfp_food_prices_pakistan;
-- ____________________________________________________________
-- question_10
SELECT date, cmname, category, mktname, price,
    CASE
        WHEN mktname IN ('Karachi', 'Lahore') THEN 'Big City'
        WHEN mktname IN ('Multan', 'Peshawar') THEN 'Medium-sized city'
        WHEN mktname = 'Quetta' THEN 'Small City'
        ELSE 'Unknown'
    END AS city_category
FROM wfp_food_prices_pakistan ;
-- ___________________________________________________________
-- question_11
 SELECT date, cmname, mktname, price,
    CASE
        WHEN price < 100 THEN 'Fair'
        WHEN price >= 100 AND price <= 300 THEN 'Unfair'
        WHEN price > 300 THEN 'Speculative'
        ELSE 'Unknown'
    END AS price_fairness
FROM wfp_food_prices_pakistan ;
-- __________________________________________________________
-- question_11
select * from wfp_food_prices_pakistan ;
select * from commodity  ; 
SELECT wfp_food_prices_pakistan.date, wfp_food_prices_pakistan.cmname, wfp_food_prices_pakistan.mktname, wfp_food_prices_pakistan.price, commodity.cmname
FROM  wfp_food_prices_pakistan
left JOIN  commodity ON wfp_food_prices_pakistan.cmname = commodity.cmname;
-- _____________________________________________________________
-- question_12
select * from wfp_food_prices_pakistan ;
select * from commodity  ; 
SELECT wfp_food_prices_pakistan.date, wfp_food_prices_pakistan.cmname, wfp_food_prices_pakistan.mktname, wfp_food_prices_pakistan.price, commodity.cmname
FROM  wfp_food_prices_pakistan
INNER JOIN  commodity ON wfp_food_prices_pakistan.cmname = commodity.cmname;
-- _____________________________________________________________________
