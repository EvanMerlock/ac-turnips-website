--initial script run--
--run only once, and only run when creating the tables needed for the database--


BEGIN;

--drops all tables being created to make sure there are no conflicts--
DROP TABLE turnips_week;
DROP TABLE turnips_buy;
DROP TABLE turnips_sell;
DROP TABLE dodo_code;
DROP TABLE member;



--what goes into a user table?
CREATE TABLE member (
	id INTEGER PRIMARY KEY,
	--thinking about using aws cognito to handle users and authentication to the API
	--GUID from IDP?
	token_guid VARCHAR(50),
	--connect with people with discord?--
	discord_name VARCHAR(50),
	online BOOLEAN,
	time_zone VARCHAR(3),
	dodo_code VARCHAR(5)

);


CREATE TABLE dodo_code (
    member_id VARCHAR(50),
    dodo_code VARCHAR(5),
    FOREIGN KEY (member_id) REFERENCES member (id)
);

--all data for the week in a single table?
--would be nice to collect info on this to do modeling if possible
CREATE TABLE turnips_week (
    id INTEGER PRIMARY KEY,
    member_id INTEGER,
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
    FOREIGN KEY (member_id) REFERENCES member (id)

);

--specific turnip sell entry with timestamp
CREATE TABLE turnips_sell (
    id INTEGER PRIMARY KEY,
    member_id INTEGER,
    price INTEGER,
    posted TIMESTAMP,
    --if posted in morning, expires at noon, likewise if posted at night, expires at 10PM local time
    --does timestamp store time zone related info?
    --timezone stored with user
    expire TIMESTAMP,
    dodo_code VARCHAR(5),
    FOREIGN KEY (member_id) REFERENCES member (id)
);

--thought it might be good to allow option to input buy price, maybe for personal tracking?
CREATE TABLE turnips_buy (
    id INTEGER PRIMARY KEY,
    member_id INTEGER,
    sunday_date DATE,
    price INTEGER,
    FOREIGN KEY (member_id) REFERENCES member (id)
);


COMMIT;
