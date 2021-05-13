SELECT * FROM survey
 LIMIT 10;            /* To get around with the survey table */

SELECT Question, count(user_id) as Total_responses
FROM survey
GROUP BY question;     /* To find total number of responses for each Question */


 /* To find if the user has called for home try on and
 weather he has purchased it or not */

SELECT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', 
h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
ON q.user_id = h.user_id
LEFT JOIN purchase p
ON q.user_id = p.user_id; 

/* To find the purchase conversion rate for different market strategies */
with funnel as (SELECT q.user_id, h.user_id IS NOT NULL AS 'is_home_try_on', 
h.number_of_pairs, p.user_id IS NOT NULL AS 'is_purchase'
FROM quiz q
LEFT JOIN home_try_on h
ON q.user_id = h.user_id
LEFT JOIN purchase p
ON q.user_id = p.user_id)

SELECT '3 pairs' as 'Number of pairs', ROUND((1.0*sum(is_purchase)/sum(is_home_try_on))* 100, 2) as 'Purchase conversion percentage'
FROM funnel
WHERE number_of_pairs = '3 pairs'
UNION ALL
SELECT '5 pairs' as 'Number of pairs', ROUND((1.0*sum(is_purchase)/sum(is_home_try_on))* 100, 2)  as 'Purchase conversion percentage'
FROM funnel
WHERE number_of_pairs = '5 pairs'; 



