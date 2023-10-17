--Livro e Livro_Autor

DELIMITER //

CREATE FUNCTION listar_livros_por_autor(primeiro_nome_param VARCHAR(255), ultimo_nome_param VARCHAR(255)) RETURNS VARCHAR(255)
BEGIN
    DECLARE livros_autor VARCHAR(2000);
    SET livros_autor = '';
    
    DECLARE done INT DEFAULT 0;
    DECLARE autor_id INT;
    
    DECLARE cur CURSOR FOR 
        SELECT id FROM Autor WHERE primeiro_nome = primeiro_nome_param AND ultimo_nome = ultimo_nome_param;
    
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = 1;
    
    OPEN cur;
    
    read_loop: LOOP
        FETCH cur INTO autor_id;
        IF done THEN
            LEAVE read_loop;
        END IF;
        
        SELECT GROUP_CONCAT(Livro.titulo) INTO livros_autor
        FROM Livro
        INNER JOIN Livro_Autor ON Livro.id = Livro_Autor.id_livro
        WHERE Livro_Autor.id_autor = autor_id;
    END LOOP;
    
    CLOSE cur;
    
    RETURN livros_autor;
END;
//

DELIMITER ;

