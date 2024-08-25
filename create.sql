--create listing table
CREATE TABLE public.listings_detailed (
    id BIGINT PRIMARY KEY,
    name text,
    neighborhood_overview text,
    host_id BIGINT,
    host_name text,
    host_since date,
    host_location text,
    host_about text,
    host_response_time text,
    host_response_rate text,
    host_acceptance_rate text,
    host_is_superhost boolean,
    host_neighbourhood text,
    host_has_profile_pic boolean,
    host_identity_verified boolean,
    neighbourhood text,
    neighbourhood_cleansed text,
    latitude decimal(10,7),
    longitude decimal(10,7),
    property_type text,
    room_type text,
    accommodates smallint,
    bathrooms decimal(3,1),
    beds smallint,
    price int,
    minimum_nights int,
    maximum_nights int,
    has_availability boolean,
    availability_30 smallint CHECK (availability_30 <= 30),
    availability_60 smallint CHECK (availability_60 <= 60),
    availability_90 smallint CHECK (availability_90 <= 90),
    availability_365 smallint CHECK (availability_365 <= 365),
    number_of_reviews smallint,
    number_of_reviews_ltm smallint,
    number_of_reviews_l30d smallint,
    first_review date,
    last_review date,
    review_scores_rating decimal(3,2),
    review_scores_accuracy decimal(3,2),
    review_scores_cleanliness decimal(3,2),
    review_scores_checkin decimal(3,2),
    review_scores_communication decimal(3,2),
    review_scores_location decimal(3,2),
    review_scores_value decimal(3,2),
    instant_bookable boolean,
    reviews_per_month decimal(4,2)
);

-- create calendar table
CREATE TABLE public.calendar (
    listing_id BIGINT,
    date date,
    available boolean,
    price text,
    adjusted_price text NULL,
    minimum_nights smallint,
    maximum_nights int,
    FOREIGN KEY (listing_id) REFERENCES public.listings_detailed(id)
);

-- create review table
CREATE TABLE public.reviews (
    listing_id BIGINT,
    date date,
    FOREIGN KEY (listing_id) REFERENCES public.listings_detailed(id)
);

-- create neighbourhood table
CREATE TABLE public.neighbourhoods (
    neighbourhood text
);

-- Set ownership of the tables to the postgres user
ALTER TABLE public.listings_detailed OWNER to postgres;
ALTER TABLE public.calendar OWNER to postgres;
ALTER TABLE public.reviews OWNER to postgres;
ALTER TABLE public.neighbourhoods OWNER to postgres;

DROP TABLE public.listings_detailed,public.calendar,public.reviews,public.neighbourhoods;

DROP TABLE calendar;


\copy calendar FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\calendar.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy listings_detailed FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\listings_detailed.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy neighbourhoods FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\neighbourhoods.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

\copy reviews FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\reviews.csv' WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY calendar
FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\calendar.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY listings_detailed
FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\listings_detailed.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY neighbourhoods
FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\neighbourhoods.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');

COPY reviews
FROM 'C:\Users\tamla_f1yewqh\OneDrive\Desktop\SQL\Projects\Airbnb\dataload\reviews.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', ENCODING 'UTF8');