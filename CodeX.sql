USE fandb_database;

SHOW TABLES;

SELECT * FROM dim_cities;
DESCRIBE dim_cities;
SELECT * FROM dim_repondents;
SELECT * FROM fact_survey_responses;


-- 1. Demographic Insights (examples)

-- a. Who prefers energy drink more? (male/female/non-binary?)

SELECT COUNT(Respondent_ID), Gender
FROM dim_repondents
GROUP BY Gender
ORDER BY COUNT(Respondent_ID) DESC LIMIT 1;

-- b. Which age group prefers energy drinks more?

SELECT COUNT(Respondent_ID), Age
FROM dim_repondents
GROUP BY Age
ORDER BY COUNT(Respondent_ID) DESC LIMIT 1;

-- c. Which type of marketing reaches the most Youth (15-30)?

SELECT f.Marketing_channels, COUNT(*) AS COUNT 
FROM fact_survey_responses AS f 
INNER JOIN dim_repondents AS r 
ON r.Respondent_ID = f.Respondent_ID
WHERE r.age IN ('15-18', '19-30')
GROUP BY f.Marketing_channels
ORDER BY COUNT DESC;

-- 2. Consumer Preferences:

-- a. What are the preferred ingredients of energy drinks among respondents?

SELECT Ingredients_expected, COUNT(Respondent_ID) AS COUNT
FROM fact_survey_responses
GROUP BY Ingredients_expected
ORDER BY COUNT DESC;

-- b. What packaging preferences do respondents have for energy drinks?

SELECT Packaging_preference, COUNT(Respondent_ID) AS COUNT, count(*) * 100.0 / sum(count(*)) OVER() AS perc
FROM fact_survey_responses
GROUP BY Packaging_preference
ORDER BY COUNT DESC;

-- 3. Competition Analysis:

-- a. Who are the current market leaders?

SELECT Current_brands, COUNT(Respondent_ID) AS COUNT
FROM fact_survey_responses
GROUP BY Current_brands
ORDER BY COUNT DESC;

-- b. What are the primary reasons consumers prefer those brands over ours?

SELECT Reasons_for_choosing_brands, COUNT(Respondent_ID) AS COUNT
FROM fact_survey_responses
GROUP BY Reasons_for_choosing_brands
ORDER BY COUNT DESC;

-- 4. Marketing Channels and Brand Awareness:

-- a. Which marketing channel can be used to reach more customers?

SELECT Marketing_channels, COUNT(Respondent_ID) AS COUNT
FROM fact_survey_responses 
GROUP BY Marketing_channels
ORDER BY COUNT DESC;


-- b. How effective are different marketing strategies and channels in reaching our customers?

SELECT COUNT(*) AS COUNT, f.Marketing_channels
FROM fact_survey_responses AS f 
INNER JOIN dim_repondents AS r 
ON r.Respondent_ID = f.Respondent_ID
WHERE f.current_brands = 'CodeX'
GROUP BY f.Marketing_channels;

-- 5. Brand Penetration:

SELECT  * FROM fact_survey_responses;

-- a. What do people think about our brand? (overall rating)

SELECT COUNT(Respondent_ID) AS COUNT, Taste_experience
FROM fact_survey_responses
WHERE Current_brands = 'codeX'
GROUP BY Taste_experience;

-- b. Which cities do we need to focus more on?

SELECT count(*) AS 'total' , c.City, c.Tier FROM fact_survey_responses AS f 
INNER JOIN dim_repondents AS r ON r.Respondent_ID = f.Respondent_ID
INNER JOIN dim_cities AS c ON c.City_ID = r.City_ID
WHERE f.Current_brands = 'codeX'
GROUP BY c.city,c.Tier
ORDER BY total;

-- 6. Purchase Behavior:

-- a. Where do respondents prefer to purchase energy drinks?


SELECT * FROM fact_survey_responses;

SELECT COUNT(*) AS COUNT, Purchase_location
FROM fact_survey_responses
INNER JOIN dim_repondents
ON dim_repondents.Respondent_ID = fact_survey_responses.Respondent_ID
GROUP BY Purchase_location
ORDER BY COUNT DESC;

-- b. What are the typical consumption situations for energy drinks among respondents?

SELECT * FROM fact_survey_responses;

SELECT COUNT(Respondent_ID) AS COUNT, Typical_consumption_situations
FROM fact_survey_responses
GROUP BY Typical_consumption_situations;


-- c. What factors influence respondents' purchase decisions, such as price range and limited edition packaging?

SELECT * FROM fact_survey_responses;

-- Price range

SELECT COUNT(Respondent_ID) AS COUNT, Price_range, count(*) * 100.0 / sum(count(*)) OVER() AS perc
FROM fact_survey_responses
GROUP BY Price_range;

-- limited edition packaging

SELECT * FROM fact_survey_responses;

SELECT COUNT(Respondent_ID) AS COUNT, Limited_edition_packaging, count(*) * 100.0 / sum(count(*)) OVER() AS perc
FROM fact_survey_responses
GROUP BY Limited_edition_packaging;

-- 7. Product Development

SELECT * FROM fact_survey_responses;
-- a. Which area of business should we focus more on our product development? (Branding/taste/availability)

SELECT Brand_perception, COUNT(Respondent_ID) AS Responses
FROM fact_survey_responses
WHERE current_brands = "codeX"
GROUP BY Brand_perception;

SELECT Taste_experience, COUNT(Respondent_ID) AS Responses
FROM fact_survey_responses
WHERE current_brands = "codeX"
GROUP BY Taste_experience;

SELECT count(*) AS 'total' , c.City, c.Tier FROM fact_survey_responses AS f 
INNER JOIN dim_repondents AS r ON r.Respondent_ID = f.Respondent_ID
INNER JOIN dim_cities AS c ON c.City_ID = r.City_ID
WHERE f.Current_brands = 'codeX'
GROUP BY c.city,c.Tier
ORDER BY total;



















