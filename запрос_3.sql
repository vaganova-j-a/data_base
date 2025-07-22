SELECT 
    st.id_st AS 'ID студента',
    CONCAT(st.surname, ' ', st.name) AS 'Студент',
    sg.group_name AS 'Группа',
    d.name_discipline AS 'Дисциплина',
    m.mark AS 'Оценка',
    e.name_event AS 'Вид мероприятия',
    CONCAT(p.surname, ' ', p.name) AS 'Преподаватель',
    m.mark_date AS 'Дата оценки'
FROM 
    student st
JOIN 
    study_group sg ON st.group_id_g = sg.id_g
JOIN 
    mark m ON st.id_st = m.student_id_st
JOIN 
    discipline d ON m.discipline_id_dis = d.id_dis
JOIN 
    event e ON m.event_id_event = e.id_event
JOIN 
    professor p ON m.prof_id_man = p.id_prof
WHERE 
    st.id_st IN (
        -- Студенты без двоек и троек по данной дисциплине
        SELECT m1.student_id_st
        FROM mark m1
        WHERE m1.discipline_id_dis = m.discipline_id_dis
        GROUP BY m1.student_id_st
        HAVING SUM(CASE WHEN m1.mark IN (2, 3) THEN 1 ELSE 0 END) = 0
    )
    AND m.mark IN (4, 5)  -- Только положительные оценки
ORDER BY 
    st.id_st ASC,         -- Сортировка по ID студента
    d.name_discipline ASC,
    m.mark_date DESC;