--- 1. Listing overall landscape:

-- Number of listings, host
SELECT COUNT(*) AS List_num FROM listings_detailed;

SELECT COUNT(DISTINCT(host_id)) AS host_num FROM listings_detailed;

-- Number of areas
SELECT COUNT(DISTINCT(neighbourhood_cleansed)) FROM listings_detailed

-- Which areas has the highest number of listings
SELECT DISTINCT neighbourhood_cleansed, COUNT(*) AS Listing_Number 
FROM listings_detailed 
GROUP BY neighbourhood_cleansed 
ORDER BY COUNT(*) DESC;

-- How many listings have their availability 0-90, 0-180, 0-270, 0-365.
WITH Availability AS (
    SELECT id, 
            availability_365,
            CASE
                WHEN availability_365 < 91 THEN 90
                WHEN availability_365 < 181 AND availability_365 > 90 THEN 180
                WHEN availability_365 < 271 AND availability_365 > 180 THEN 270
                WHEN availability_365 > 270 THEN 365
            END AS Num_day_available
    FROM listings_detailed
)
SELECT Num_day_available, COUNT (*) FROM Availability GROUP BY Num_day_available ORDER BY Num_day_available;

-- Average booking days in the next 30 days, 60 days, 90 days.
SELECT ROUND(AVG(30 - availability_30),0) AS booking_next_30, 
       ROUND(AVG(60 - availability_60),0) AS booking_next_60, 
       ROUND(AVG(90 - availability_90),0) AS booking_next_90
FROM listings_detailed

-- Average price in Bangkok
SELECT AVG(price) FROM listings_detailed

-- Price bucket for Airbnb in Bangkok [less than 1000, 1000-1500, 1500-2000, over 2000]
WITH PriceBucket AS (
    SELECT id, 
            CASE
                WHEN price < 1000 THEN 'less than 1000 baht'
                WHEN price < 1500 AND price > 1000 THEN 'from 1000 baht to 1500 baht'
                WHEN price < 2000 AND price > 1500 THEN 'from 1500 baht to 2000 baht'
                WHEN price > 2000 THEN 'over 2000 baht'
            END AS "price_per_night_range"
    FROM listings_detailed
)
SELECT price_per_night_range, COUNT(*) AS Listing_num FROM PriceBucket GROUP BY price_per_night_range;

-- Which areas have the highest price?
SELECT neighbourhood_cleansed, ROUND(AVG(price),2) AS AveragePrice 
FROM listings_detailed 
GROUP BY neighbourhood_cleansed ORDER BY AveragePrice DESC;


--- 2. Reviews:

-- What is the average review score? Which areas has the highest review score
SELECT ROUND(AVG(review_scores_rating),2) FROM listings_detailed;

SELECT neighbourhood_cleansed, ROUND(AVG(review_scores_rating),2) AS AverageRating
FROM listings_detailed
GROUP BY neighbourhood_cleansed
ORDER BY AverageRating DESC;

-- What are the number of reviews last 12 months
SELECT SUM(number_of_reviews_ltm) FROM listings_detailed;

-- Top 10 host have the highest number of reviews? What are their years of experience? And highest review score?
SELECT
    host_id,
    host_name,
    (CURRENT_DATE - host_since)/365 AS Exp_Year,
    SUM(number_of_reviews) AS NumberOfReviews,
    SUM(number_of_reviews_ltm) AS Ltm_Reviews,
    ROUND(AVG(review_scores_rating),2) AS AverageRating
FROM listings_detailed
GROUP BY host_id, host_name, host_since
ORDER BY NumberOfReviews DESC, AverageRating DESC LIMIT 10;

-- Which listing have the lowest review score? How many reviews do these listings have
SELECT id, review_scores_rating, number_of_reviews, number_of_reviews_ltm
FROM listings_detailed 
WHERE number_of_reviews > 50
ORDER BY review_scores_rating ASC;


--- 3. Property:

-- What are the property types? Which type is most popular?
-- What is average price/night for each type?
SELECT property_type, COUNT(*) AS Number_of_listing, ROUND(AVG(price),2) AS Average_price
FROM listings_detailed 
GROUP BY property_type
ORDER BY COUNT(*) DESC;

-- What is the most popular room type? 
SELECT room_type, COUNT(*) AS Number_of_listing, ROUND(AVG(price),2) AS Average_price
FROM listings_detailed 
GROUP BY room_type
ORDER BY COUNT(*) DESC;

-- What is the average price for different capacities type?
SELECT accommodates, COUNT(*) AS Number_of_listing, ROUND(AVG(price),2) AS Average_price
FROM listings_detailed
GROUP BY accommodates
ORDER BY Number_of_listing;

-- On average, how many days a year is a listing available for booking? Which areas have the highest bookable dates?
SELECT neighbourhood_cleansed, COUNT(date)/COUNT(DISTINCT(listing_id)) AS Average_Bookable_date 
FROM calendar 
JOIN listings_detailed ON listings_detailed.id = calendar.listing_id
WHERE available = 'TRUE'
GROUP BY neighbourhood_cleansed;

-- What is the difference in price, booking in the next 30 days for instant and the non-instant bookable listing?
SELECT instant_bookable, 
    COUNT(*) AS Number_of_listing, 
    ROUND(AVG(price),2) AS Average_price, 
    ROUND(AVG(30-availability_30),0) AS Booking_in_30days
FROM listings_detailed
GROUP BY instant_bookable;


--- 4. Host:

-- How many host has their identity verified?
SELECT host_identity_verified, COUNT(DISTINCT(host_id)) FROM listings_detailed GROUP BY host_identity_verified;

-- What is the average response time for host? What is the review_scores_rating, review_scores_communication, 
SELECT 
    host_response_time, 
    COUNT(DISTINCT(host_id)), 
    ROUND(AVG(review_scores_rating),2) AS Average_review_score,
    ROUND(AVG(review_scores_communication),2) AS Average_communication_rating
FROM listings_detailed 
GROUP BY host_response_time;

-- How many host have more than 10 listings? What is the average review score, booking in the next 30 days for their listings?
SELECT 
    DISTINCT host_id, 
    COUNT(id) AS Number_of_listing, 
    SUM(number_of_reviews) AS Total_Reviews,
    ROUND(AVG(review_scores_rating),2) AS Average_review_score,
    ROUND(AVG(30-availability_30),2) AS Average_Booking_in_30days
FROM listings_detailed
GROUP BY host_id
HAVING COUNT(id) > 9
ORDER BY COUNT(id) DESC;

-- What is the acceptance rate? Does acceptance rate affect price, booking dates
SELECT DISTINCT host_acceptance_rate, 
    COUNT(id) AS Number_of_listing, 
    ROUND(AVG(price),2) AS Average_price,
    ROUND(AVG(30-availability_30),2) AS Average_booking_in_30days
FROM listings_detailed
WHERE host_acceptance_rate IS NOT NULL
GROUP BY host_acceptance_rate
ORDER BY host_acceptance_rate DESC;

-- How many host is superhost? Does superhost affect the reviews, booking, and price?
SELECT 
    host_is_superhost, 
    COUNT(DISTINCT(host_id)) AS Number_of_host,
    ROUND(AVG(review_scores_rating),2) AS Average_review_score,
    ROUND(AVG(price),2) AS Average_price,
    ROUND(AVG(30-availability_30),2) AS Average_Booking_in_30days
FROM listings_detailed
GROUP BY host_is_superhost
ORDER BY Number_of_host DESC;