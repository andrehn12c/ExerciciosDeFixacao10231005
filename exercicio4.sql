--Livro e Editora

DELIMITER //

CREATE FUNCTION media_livros_por_editora() RETURNS DECIMAL(10, 2)
BEGIN
    DECLARE total_livros INT;
    DECLARE total_editoras INT;
    DECLARE media DECIMAL(10, 2);
    
    SELECT COUNT(*) INTO total_editoras FROM Editora;
    
    DECLARE done INT DEFAULT 0;
    DECLARE editora_id INT;
    
    DECLARE cur CURSOR FOR 
        SELECT id FROM Editora;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    media_loop: LOOP
        FETCH cur INTO editora_id;
        IF done THEN
            LEAVE media_loop;
        END IF;
        
        SELECT COUNT(*) INTO total_livros FROM Livro WHERE id_editora = editora_id;
        SET media = media + (total_livros / total_editoras);
    END LOOP;
    
    CLOSE cur;
    
    RETURN media;
END;
//

DELIMITER ;
