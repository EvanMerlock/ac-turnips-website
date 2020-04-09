
BEGIN;

DROP TABLE user;
DROP TABLE turnips_week;
DROP TABLE turnips_buy;

--what goes into a user table?
CREATE TABLE user (
	id INTEGER PRIMARY KEY,
	--thinking about using aws cognito to handle users and authentication to the API
	congnito_id VARCHAR(50)
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

--thought it might be good to allow option to input buy price, maybe for personal tracking?
CREATE TABLE turnips_buy (
    id INTEGER PRIMARY KEY,
    user_id INTEGER,
    sunday_date DATE,
    price INTEGER,
    FOREIGN KEY (user_id) REFERENCES user (id)
);


COMMIT;
