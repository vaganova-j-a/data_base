-- Сначала создаём таблицы, на которые будут ссылаться другие таблицы
CREATE TABLE specialty (
    id_spec          INT NOT NULL PRIMARY KEY,
    name_specialty   VARCHAR(50) NOT NULL
);

CREATE TABLE discipline (
    id_dis            INT NOT NULL PRIMARY KEY,
    name_discipline   VARCHAR(50) NOT NULL,
    number_of_hours   INT NOT NULL,
    type_of_control   VARCHAR(50) NOT NULL
);

CREATE TABLE event (
    id_event     INT NOT NULL PRIMARY KEY,
    name_event   VARCHAR(50) NOT NULL
);

CREATE TABLE professor (
    id_prof      INT NOT NULL PRIMARY KEY,
    name         VARCHAR(50) NOT NULL,
    surname      VARCHAR(50) NOT NULL,
    patronymic   VARCHAR(50),
    position     VARCHAR(50)
);

-- Затем создаём таблицы с внешними ключами
CREATE TABLE study_group (
    id_g                INT NOT NULL PRIMARY KEY,
    group_name          VARCHAR(50) NOT NULL,
    specialty_id_spec   INT NOT NULL,
    CONSTRAINT fk_specialty FOREIGN KEY (specialty_id_spec) REFERENCES specialty(id_spec)
);

CREATE TABLE student (
    id_st        INT NOT NULL PRIMARY KEY,
    name         VARCHAR(50) NOT NULL,
    surname      VARCHAR(50) NOT NULL,
    patronymic   VARCHAR(50),
    group_id_g   INT NOT NULL,
    CONSTRAINT student_group_fk FOREIGN KEY (group_id_g) REFERENCES study_group(id_g)
);

-- grade_book должна быть после всех связанных таблиц
CREATE TABLE grade_book (
    group_id_g          INT NOT NULL,
    discipline_id_dis   INT NOT NULL,
    prof_id_man        INT NOT NULL,
    event_id_event     INT NOT NULL,
    number_semester    INT,
    PRIMARY KEY (group_id_g, discipline_id_dis),
    CONSTRAINT gb_group_fk FOREIGN KEY (group_id_g) REFERENCES study_group(id_g),
    CONSTRAINT gb_discipline_fk FOREIGN KEY (discipline_id_dis) REFERENCES discipline(id_dis),
    CONSTRAINT gb_professor_fk FOREIGN KEY (prof_id_man) REFERENCES professor(id_prof),
    CONSTRAINT gb_event_fk FOREIGN KEY (event_id_event) REFERENCES event(id_event)
);

CREATE TABLE mark (
    id_m             INT NOT NULL PRIMARY KEY,
    mark             INT,
    mark_date        DATE,
    weight           INT,
    student_id_st    INT NOT NULL,
    event_id_event   INT NOT NULL,
    prof_id_man      INT NOT NULL,
    discipline_id_dis INT NOT NULL,
    CONSTRAINT mark_student_fk FOREIGN KEY (student_id_st) REFERENCES student(id_st),
    CONSTRAINT mark_event_fk FOREIGN KEY (event_id_event) REFERENCES event(id_event),
    CONSTRAINT mark_professor_fk FOREIGN KEY (prof_id_man) REFERENCES professor(id_prof),
    CONSTRAINT mark_discipline_fk FOREIGN KEY (discipline_id_dis) REFERENCES discipline(id_dis)
);


