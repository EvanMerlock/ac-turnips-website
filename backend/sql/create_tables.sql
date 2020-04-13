--initial script run--
--run only once, and only run when creating the tables needed for the database--


BEGIN;

--drops all tables being created to make sure there are no conflicts--
DROP SCHEMA turnips CASCADE;

CREATE SCHEMA turnips;

--what goes into a user table?
CREATE TABLE turnips.member (
	id UUID PRIMARY KEY,
	--thinking about using aws cognito to handle users and authentication to the API
	--GUID from IDP?
	token_guid TEXT,
	--connect with people with discord?--
	discord_name TEXT,
	online BOOLEAN,
	time_zone TEXT,
	friend_code TEXT

);

CREATE TABLE turnips.member_settings (
    member_id UUID PRIMARY KEY,
    set_friend_code_private BOOLEAN,
    FOREIGN KEY (member_id) REFERENCES turnips.member (id)

);


CREATE TABLE turnips.dodo_code (
    dodo_code_id UUID PRIMARY KEY,
    dodo_code TEXT
);

--all data for the week in a single table?
--would be nice to collect info on this to do modeling if possible
CREATE TABLE turnips.turnips_week (
    member_id UUID PRIMARY KEY,
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
    FOREIGN KEY (member_id) REFERENCES turnips.member (id)

);

--specific turnip sell entry with timestamp
CREATE TABLE turnips.turnips_sell (
    member_id UUID PRIMARY KEY,
    price INTEGER,
    posted TIMESTAMP,
    --if posted in morning, expires at noon, likewise if posted at night, expires at 10PM local time
    --STORE AS UTC
    --timezone stored with user
    expire TIMESTAMP,
    dodo_code UUID,
    FOREIGN KEY (dodo_code) REFERENCES turnips.dodo_code(dodo_code_id),
    FOREIGN KEY (member_id) REFERENCES turnips.member (id)
);

--thought it might be good to allow option to input buy price, maybe for personal tracking?
CREATE TABLE turnips.turnips_buy (
    member_id UUID PRIMARY KEY,
    sunday_date DATE,
    -- NOON ON SUNDAY EXPIRE (BE AWARE OF TIME ZONE)
    expire TIMESTAMP,
    price INTEGER,
    dodo_code UUID,
    FOREIGN KEY (dodo_code) REFERENCES turnips.dodo_code(dodo_code_id),
    FOREIGN KEY (member_id) REFERENCES turnips.member (id)
);


COMMIT;
