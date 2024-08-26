# SQL data exploration project

Airbnb landscape in Bangkok

## Data description:
The data is collected through Inside Airbnb website which is a web-scraping data for Airbnb listings in many cities around the world.

The dataset include 3 main csv files and is collected as of June'2024 for Bangkok Airbnb:

1. **Listing data:** contains all scraped data about listings in Sydney with listing_id as primary key
2. **Reviews data**: contains all scraped available comments about listing_id with comment id as primary key and listing_id as foreign key referencing to listing table
3. **Calendar data:** contains data about the price and availability of listing in the next 365 days with listing_id as foreign key referencing to listing table

Purpose of this project: Apply SQL queries for data exploratory analysis of Airbnb landscape in Bangkok.

## Data analysis process:

### A. Create data tables: 
1. Define relationship of tables within dataset
2. SQL queries to define data schema
3. Load data from source to SQL connections
Full process for creating tables with SQL queries: [create.sql](https://github.com/tamlai-portfolio/Bangkok-Airbnb-landscape-with-SQL/blob/main/create.sql)
   
### B. Data exploratory questions:
Full SQL queries for analysis : [Airbnb landscape Bangkok.sql](https://github.com/tamlai-portfolio/Bangkok-Airbnb-landscape-with-SQL/blob/main/Airbnb%20landscape%20Bangkok.sql)

1. Listing overall landscape:

- Number of listings, host
- Number of areas
- Which areas has the highest number of listings
- How many listings have their availability 0-90, 91-180, 181-270, 270-365.
- Average booking days in the next 30 days, 60 days, 90 days.
- Price bucket for Airbnb in Bangkok [less than 1000, 1000-1500, 1500-2000, over 2000]
- What is the average price per night in Bangkok? Which areas have the highest price?

2. Reviews:

- What is the average review score? Which areas has the highest review score
- What are the number of reviews last 12 months
- Which host have the highest number of reviews? And highest review score?
- How many listings that have at least 30 reviews in the last 3 months?
- Which listing have the lowest review score? What does these reviews say about the listing?

3. Property:

- What are the property types? Which type is most popular?
- What is average price/night for each type?
- What is the most popular room type? 
- On average, how many days a year is a listing available for booking?
- What is the difference in price, booking in the next 30 days for instant and the non-instant bookable listing?

4. Host:

- How many host has their identity verified?
- What is the average response time for host?
- How many host have more than 3 listings? What is the average review score for 
- What is the acceptance rate?
- How many host is superhost? Does superhost affect the reviews, booking, and price?
