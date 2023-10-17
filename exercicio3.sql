--livro

DELIMITER //

CREATE FUNCTION atualizar_resumos()
BEGIN
    DECLARE done INT DEFAULT 0;
    DECLARE livro_id INT;
    
    DECLARE cur CURSOR FOR 
        SELECT id FROM Livro;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    update_loop: LOOP
        FETCH cur INTO livro_id;
        IF done THEN
            LEAVE update_loop;
        END IF;
        
        UPDATE Livro SET resumo = CONCAT(resumo, ' Este é um excelente livro!') WHERE id = livro_id;
    END LOOP;
    
    CLOSE cur;
END;
//

DELIMITER ;

