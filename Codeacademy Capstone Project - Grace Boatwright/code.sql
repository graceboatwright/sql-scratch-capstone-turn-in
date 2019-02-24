SELECT *
FROM surveys
LIMIT 10;

SELECT question,
 COUNT(DISTINCT user_id) AS ‘distinct_answers’
FROM survey
GROUP BY question;

SELECT *
FROM quiz
LIMIT 5;
SELECT *
FROM home_try_on
LIMIT 5;
SELECT * 
FROM purchase
LIMIT 5;

SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS ‘is_home_try_on’,
   h.number_of_pairs,
   p.user_id IS NOT NULL AS ‘is purchase’
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p 
   ON p.user_id = q.user_id
LIMIT 10;
 
SELECT 
  DISTINCT q.user_id, 
  CASE WHEN h.user_id IS NOT NULL
  THEN 'True'
    ELSE 'False'
  END AS 'home_try_on', 
  h.number_of_pairs, 
 CASE WHEN p.user_id IS NOT NULL
  THEN 'True'
    ELSE 'False'
  END AS 'purchase' 
FROM 
  quiz q 
  LEFT JOIN home_try_on AS h USING (user_id)
  LEFT JOIN purchase AS p USING (user_id)
LIMIT 10;

WITH conversions AS 
 (SELECT DISTINCT q.user_id,
   h.user_id IS NOT NULL AS 'is_home_try_on',
   h.number_of_pairs,
   p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
   ON q.user_id = h.user_id
LEFT JOIN purchase p
   ON p.user_id = q.user_id)
SELECT
 SUM(is_home_try_on = 1)*1.0/COUNT(*)
   AS 'quiz_conversion_rate',
 SUM(is_purchase = 1)*1.0/
 SUM(is_home_try_on = 1)
   AS 'home_try_on_conversion_rate',
 SUM(is_purchase = 1)*1.0/COUNT(*)
   AS 'overall_conversion_rate',
 (SUM(is_purchase = 1 AND
   number_of_pairs = '3 pairs')*1.0/
 SUM(is_home_try_on = 1 AND
   number_of_pairs = '3 pairs’))
   AS  '3_conversion_rate',
 (SUM(is_purchase = 1 AND
   number_of_pairs = '5 pairs')*1.0/
 SUM(is_home_try_on = 1 AND
   number_of_pairs = '5 pairs')) 
   AS  '5_conversion_rate' 
FROM conversions;

SELECT
style,
fit,
shape,
color,
COUNT (*) AS 'num'
FROM quiz
GROUP BY style, fit, shape, color
ORDER BY num DESC;

SELECT
style,
COUNT (*) AS 'num'
FROM quiz
GROUP BY style
ORDER BY num DESC;

SELECT 
fit, 
COUNT (*) AS ‘num'
FROM quiz
GROUP BY fit
ORDER BY num DESC;

SELECT 
shape, 
COUNT (*) AS ‘num'
FROM quiz
GROUP BY shape
ORDER BY num DESC;

SELECT 
color, 
COUNT (*) AS ‘num'
FROM quiz
GROUP BY color
ORDER BY num DESC;

SELECT
style,
model_name,
color,
price,
COUNT (*) AS 'num'
FROM purchase
GROUP BY style, model_name, color, price
ORDER BY num DESC;

SELECT
style,
COUNT (*) AS 'num'
FROM purchase
GROUP BY style
ORDER BY num DESC;

SELECT 
model_name, 
COUNT (*) AS ‘num'
FROM quiz
GROUP BY model_name
ORDER BY num DESC;

SELECT 
color, 
COUNT (*) AS ‘num'
FROM quiz
GROUP BY color
ORDER BY num DESC;

SELECT 
price, 
COUNT (*) AS ‘num'
FROM quiz
GROUP BY price
ORDER BY num DESC;

SELECT
price,
COUNT (*) AS 'num'
FROM purchase
GROUP BY price
ORDER BY num ASC;
