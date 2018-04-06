/*Все выводимые данные представляются на сайте в табличном виде*/
/*id каждой сущности сохраняется в каждом тэге tr в data атрибуте типа data-id */
/*Переменные берём из $_POST*/
/*Редактируемые данные для простоты тянем из БД*/

/*Вывод списка олимпиад из БД*/
SELECT og_id, og_start_date, og_country, og_city, summerWinter
FROM olympic_games;

/*Добавление олимпиады в БД*/
INSERT INTO olympic_games (og_name, og_start_date, og_contry, og_city, summerWinter)
VALUES ($og_name, $og_start_date, $og_country, $og_city, $og_season);

/*Изменение данных олимпиад*/
UPDATE olympic_games
SET og_name = $og_name,
    og_start_date = $og_start_date,
    og_contry = $og_contry,
    og_city = $og_city,
    summerWinter = $og_season
WHERE og_id = $og_id;

/*Удаление олимпиад*/
DELETE FROM olympic_games
WHERE og_id = $og_id;

/*Вывод списка стран из БД*/
SELECT country_id, country_name
FROM country;

/*Добавление страны в БД*/
INSERT INTO country (country_name)
VALUES ($country_name);

/*Изменение страны*/
UPDATE country
SET country_name = $country_name
WHERE country_id = $country_id;

/*Удаление страны из БД*/
DELETE FROM country
WHERE country_id = $country_id;

/*Вывод списка основных дисциплин*/
SELECT sport_id, sport_name
FROM sport;

/*Добавление основной дисциплины в БД*/
INSERT INTO sport (sport_name)
VALUES ($sport_name);

/*Изменение основной дисциплины*/
UPDATE sport
SET sport_name = $sport_name
WHERE sport_id = $sport_name;

/*Удаление основной дисциплины из БД*/
DELETE FROM sport
WHERE sport_id = $sport_id;

/*Вывод дополнительных дисциплин из БД*/
/*Для вывода объединяем таблицы event и sport*/
SELECT e.event_id, e.sport_id, e.event_name, e.gender, e.unit_id, s.sport_name
FROM events e
JOIN sport s ON e.sport_id = s.sport_id;

/*Добавление доп. дисциплины в БД*/
INSERT INTO events (sport_id, event_name, gender, unit_id)
VALUES ($sport_id, $event_id, $gender, $unit_id);

/*Изменение доп. дисциплины*/
UPDATE events
SET sport_id = $sport_id,
    event_name = $event_name,
    gender = $gender,
    unit_id = $unit_id
WHERE event_id = $event_id;

/*Удаление доп. дисциплины*/
DELETE FROM events
WHERE event_id = $event_id;

/*Вывод списка спортсменов из БД*/
/*Для вывода объединяем таблицы athlete, country и sport*/
SELECT a.athlete_id, a.f_name, a.l_name, a.gender, a.DOB, a.country_id, c.country_name,
       a.sport_id, s.sport_name
FROM athlete a
JOIN sport s ON a.sport_id = s.sport_id
JOIN country c ON a.country_id = c.country_id;

/*Добавление спортсмена в БД*/
INSERT INTO athlete (f_name, l_name, gender, DOB, country_id, sport_id)
VALUES ($f_name, $l_name, $gender, $dob, $country_id, $sport_id);

/*Изменение данных спортсмена*/
UPDATE athlete
SET f_name = $f_name,
    l_name = $l_name,
    gender = $gender,
    country_id = $country_id,
    sport_id = $sport_id
WHERE athlete_id = $athlete_id;

/*Удаление данных спортсмена из БД*/
DELETE FROM athlete
WHERE athlete_id = $athlete_id;

/*Выбор списка соревнований*/
SELECT c.competition_id, c.og_id, og.og_name, c.event_id, s.sport_name, e.event_name, e.gender, c.round,
       c.start_date_time, c.end_date_time
FROM competition c
JOIN olympic_games og ON c.og_id = og.og_id
JOIN events e ON c.event_id = e.event_id
JOIN sport s ON e.sport_id = s.sport_id;

/*Добавление соревнования в БД*/
INSERT INTO competition (og_id, event_id, start_date_time, end_date_time, round)
VALUES ($og_id, $event_id, $start_date_time, $end_date_time, $round);

/*Изменение данных соревнования*/
UPDATE competition
SET og_id = $og_id,
    event_id = $og_id,
    start_date_time = $start_date_time,
    end_date_time = $end_date_time,
    round = $round
WHERE competition_id = $competition_id;

/*Удаление соревнования из БД*/
DELETE FROM competition
WHERE competition_id = $competition_id;

/*Зарегистрировать спортсмена на соревнование*/
INSERT INTO registration (athlete_id, competition_id)
VALUES ($athlete_id, $competition_id);

/*Выбор зарегистрированных спортсменов на соревнования*/
SELECT reg.registration_id, reg.competition_id, c.og_id, og.og_name,
       c.event_id, e.sport_id, s.sport_name, e.event_name, e.gender, c.round,
       r.athlete_id, a.f_name, a.l_name, a.country_id, ctr.country_name
FROM registration reg
JOIN competition c ON reg.competition_id = c.competition_id
JOIN athlete a ON reg.athlete_id = a.athlete_id
JOIN events e ON c.event_id = e.event_id
JOIN country ctr ON a.country_id = ctr.country_id
JOIN sport s ON e.sport_id = s.sport_id
JOIN olympic_games og ON c.og_id = og.og_id;

/*Удаление спортсмена из списка регистраций*/
DELETE FROM registration
WHERE athlete_id = $athlete_id AND competition_id = $competition_id;

/*Выбор результатов соревнований из БД*/
SELECT r.result_id, r.competition_id, c.og_id, og.og_name,
       c.event_id, e.sport_id, s.sport_name, e.event_name, e.gender, c.round,
       r.athlete_id, a.f_name, a.l_name, a.country_id, ctr.country_name,
       r.result, e.unit_id, u.unit_short_name, u.unit_type
FROM result r
JOIN competition c ON r.competition_id = c.competition_id
JOIN athlete a ON r.athlete_id = a.athlete_id
JOIN events e ON c.event_id = e.event_id
JOIN unit u ON e.unit_id = u.unit_id
JOIN country ctr ON a.country_id = ctr.country_id
JOIN sport s ON e.sport_id = s.sport_id
JOIN olympic_games og ON c.og_id = og.og_id;

/*Добавление результата в БД*/
/*id участников берутся только из таблицы регистраций registration*/
INSERT INTO result (competition_id, athlete_id, result)
VALUES ($competition_id, $athlete_id, $result);

/*Изменение результата соревнования*/
UPDATE result
SET competition_id = $competition_id,
    athlete_id = $athlete_id
WHERE result_id = $result_id;

/*Удаление результата участника соревнования*/
/*Физического удаления из БД не происходит, id результата просто добавляется в таблицу remote_result*/
INSERT INTO remote_result (remote_result_id)
VALUES ($remote_result_id);