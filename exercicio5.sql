--Autor e Livro_Autor

DELIMITER //

CREATE FUNCTION autores_sem_livros() RETURNS VARCHAR(2000)
BEGIN
    DECLARE autores_sem_livros VARCHAR(2000);
    SET autores_sem_livros = '';
    
    DECLARE done INT DEFAULT 0;
    DECLARE autor_id INT;
    
    DECLARE cur CURSOR FOR 
        SELECT id FROM Autor;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    autor_loop: LOOP
        FETCH cur INTO autor_id;
        IF done THEN
            LEAVE autor_loop;
        END IF;
        
        IF NOT EXISTS (SELECT 1 FROM Livro_Autor WHERE id_autor = autor_id) THEN
            SELECT CONCAT(primeiro_nome, ' ', ultimo_nome) INTO autores_sem_livros
            FROM Autor WHERE id = autor_id;
        END IF;
    END LOOP;
    
    CLOSE cur;
    
    RETURN autores_sem_livros;
END;
//

DELIMITER ;
