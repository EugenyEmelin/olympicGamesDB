CREATE TABLE olympic_games (
  og_id SMALLINT UNSIGNED AUTO_INCREMENT,
  og_name VARCHAR(45) NOT NULL,
  og_start_date DATE NOT NULL,
  og_location VARCHAR(45) NOT NULL,
  summerWinter ENUM('summer', 'winter') NOT NULL,
  PRIMARY KEY (og_id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE unit (
  unit_id TINYINT UNSIGNED AUTO_INCREMENT,
  unit_name VARCHAR(45) NOT NULL,
  unit_short_name VARCHAR(10) NOT NULL,
  unit_type ENUM('value', 'time') NOT NULL,
  PRIMARY KEY (unit_id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE country (
  country_id SMALLINT UNSIGNED AUTO_INCREMENT,
  country_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (country_id),
  INDEX country_index (country_name ASC)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE sport (
  sport_id SMALLINT UNSIGNED AUTO_INCREMENT,
  sport_name VARCHAR(45) NOT NULL,
  PRIMARY KEY (sport_id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE athlete (
  athlete_id INT UNSIGNED AUTO_INCREMENT,
  first_name VARCHAR(45) NOT NULL,
  last_name VARCHAR(45) NOT NULL,
  gender ENUM('male', 'female') NOT NULL,
  DOB DATE NOT NULL,
  country_id SMALLINT UNSIGNED NOT NULL,
  sport_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (athlete_id),
  INDEX country_id (country_id ASC),
  CONSTRAINT fk_country_id FOREIGN KEY (country_id)
    REFERENCES country (country_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_sport_id FOREIGN KEY (sport_id)
    REFERENCES sport (sport_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE events (
  event_id SMALLINT UNSIGNED AUTO_INCREMENT,
  sport_id SMALLINT UNSIGNED NOT NULL,
  event_name VARCHAR(45) NOT NULL,
  gender ENUM('male', 'female') NOT NULL,
  unit_id TINYINT UNSIGNED NOT NULL,
  PRIMARY KEY (event_id),
  INDEX competition_name (event_name ASC),
  CONSTRAINT fk_sport_id_comp FOREIGN KEY (sport_id)
    REFERENCES sport (sport_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  FOREIGN KEY (unit_id) REFERENCES unit (unit_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE competition (
  competition_id SMALLINT UNSIGNED AUTO_INCREMENT,
  og_id SMALLINT UNSIGNED NOT NULL,
  event_id SMALLINT UNSIGNED NOT NULL,
  start_date_time DATETIME NOT NULL,
  end_date_time DATETIME NOT NULL,
  round VARCHAR(45) NOT NULL,
  PRIMARY KEY (competition_id),
  INDEX event_id (competition_id ASC),
  INDEX start_date (start_date_time ASC),
  INDEX end_date (end_date_time ASC),
  CONSTRAINT fk_og_id FOREIGN KEY (og_id)
    REFERENCES olympic_games (og_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_event_id FOREIGN KEY (event_id)
    REFERENCES events (event_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE registration (
  registration_id SMALLINT UNSIGNED AUTO_INCREMENT,
  athlete_id INT UNSIGNED NOT NULL,
  event_id SMALLINT UNSIGNED NOT NULL,
  PRIMARY KEY (registration_id),
  INDEX athlete_id (athlete_id ASC),
  INDEX event_id (event_id ASC),
  CONSTRAINT fk_athlete_id FOREIGN KEY (athlete_id)
    REFERENCES athlete (athlete_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_event_id FOREIGN KEY (event_id)
    REFERENCES events (event_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE result (
  result_id INT UNSIGNED AUTO_INCREMENT,
  event_id SMALLINT UNSIGNED NOT NULL,
  athlete_id INT UNSIGNED NOT NULL,
  result FLOAT UNSIGNED NOT NULL,
  PRIMARY KEY (result_id),
  INDEX event_id (event_id ASC),
  INDEX athlete_id (athlete_id ASC),
  INDEX result (result ASC),
  CONSTRAINT fk_event_id_result FOREIGN KEY (event_id)
  REFERENCES events (event_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT fk_athlete_id_result FOREIGN KEY (athlete_id)
  REFERENCES athlete (athlete_id)
    ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET=utf8;
CREATE TABLE remote_result (
  remote_id SMALLINT UNSIGNED AUTO_INCREMENT,
  remote_result_id INT UNSIGNED NOT NULL,
  PRIMARY KEY (remote_id),
  FOREIGN KEY (remote_result_id) REFERENCES result (result_id)
) ENGINE = InnoDB DEFAULT CHARSET=utf8;