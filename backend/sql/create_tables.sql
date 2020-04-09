
BEGIN;

DROP TABLE user;
DROP TABLE turnips_week;
DROP TABLE turnips_buy;

--what goes into a user table?
CREATE TABLE user (
	id INTEGER PRIMARY KEY,
	--thinking about using aws cognito to handle users and authentication to the API
	cognito_id VARCHAR(50),
	--connect with people with discord?--
	discord_name VARCHAR(50),
	online BOOLEAN,
	time_zone VARCHAR(3),
	dodo_code VARCHAR(5)

);

--all data for the week in a single table?
CREATE TABLE turnips_week (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    week_start DATE,
    monday_morning INTEGER,
    monday_evening INTEGER,
    tuesday_morning INTEGER,
    tuesday_evening INTEGER,
    wednesday_morning INTEGER,
    wednesday_evening INTEGER,
    thursday_morning INTEGER,
    thursday_evening INTEGER,
    friday_morning INTEGER,
    friday_evening INTEGER,
    saturday_morning INTEGER,
    saturday_evening INTEGER,
    FOREIGN KEY (user_id) REFERENCES user (id)

);

--specific turnip sell entry with timestamp
CREATE TABLE turnips_sell (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    price INTEGER,
    posted TIMESTAMP,
    --if posted in morning, expires at noon, likewise if posted at night, expires at 10PM local time
    --does timestamp store time zone related info?
    --timezone stored with user
    expire TIMESTAMP,
    dodo_code VARCHAR(5)
);

--thought it might be good to allow option to input buy price, maybe for personal tracking?
CREATE TABLE turnips_buy (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    sunday_date DATE,
    price INTEGER,
    FOREIGN KEY (user_id) REFERENCES user (id)
);


COMMIT;
