drop table if exists SAP;

create table SAP(
    student_id         SERIAL PRIMARY KEY,
    gender             text,              -- «Male» / «Female»
    hours_studied_week numeric(5,2),      -- 0‑16 hours
    tutoring           text,              -- «Yes» / «No»
    region             text,              -- «Urban» / «Rural»
    attendance         numeric(5,2),      -- 50‑100 %
    parent_education   text,              -- «None», «Primary», «Secondary», «Tertiary»
    exam_score         numeric(5,2)       -- 0‑100 баллов
);

COPY SAP(gender, hours_studied_week, tutoring, region, attendance, parent_education, exam_score)
From 'data/SAP-4000.csv'
WITH (FORMAT csv, HEADER true, DELIMITER ',', NULL '', ENCODING 'UTF8');
