SELECT 
    CONCAT(s.surname, ' ', s.name) AS 'Студент',
    sp.name_specialty AS 'Специализация',
    sg.group_name AS 'Группа',
    d.name_discipline AS 'Дисциплина',
    e.name_event AS 'Вид мероприятия',
    m.mark AS 'Оценка',
    CONCAT(p.surname, ' ', p.name) AS 'Преподаватель',
    m.mark_date AS 'Дата оценки'
FROM 
    mark m
JOIN 
    student s ON m.student_id_st = s.id_st
JOIN 
    study_group sg ON s.group_id_g = sg.id_g
JOIN 
    specialty sp ON sg.specialty_id_spec = sp.id_spec
JOIN 
    professor p ON m.prof_id_man = p.id_prof
JOIN 
    discipline d ON m.discipline_id_dis = d.id_dis
JOIN 
    event e ON m.event_id_event = e.id_event
WHERE 
    m.mark IN (2, 3)
ORDER BY 
    m.mark ASC,  -- Сначала двойки, потом тройки
    sp.name_specialty ASC,
    sg.group_name ASC,
    s.surname ASC;