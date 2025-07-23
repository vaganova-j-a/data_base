SELECT 
    CONCAT(p.surname, ' ', p.name, ' ', p.patronymic) AS professor_name,
    COUNT(DISTINCT gb.discipline_id_dis) AS 'Количество дисциплин',
    COUNT(DISTINCT gb.group_id_g) AS 'Количество групп'
FROM 
    professor p
LEFT JOIN 
    grade_book gb ON p.id_prof = gb.prof_id_man
GROUP BY 
    p.id_prof, p.surname, p.name, p.patronymic
ORDER BY 
    'Количество дисциплин' DESC;