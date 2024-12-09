DELIMITER $$

CREATE PROCEDURE login(
    IN input_user VARCHAR(50),
    IN input_password VARCHAR(64)
)
BEGIN
    DECLARE user_exists INT;

    SELECT COUNT(*)
    INTO user_exists
    FROM ClientesLogins
    WHERE client_user = input_user
      AND client_password = input_password;

    IF user_exists > 0 THEN
        SELECT 'Login successful' AS Message;
    ELSE
        SELECT 'Login failed: Invalid credentials' AS Message;
    END IF;
END$$

DELIMITER ;


---------------- SIGN UP PROCEDURE ----------------

DELIMITER $$

CREATE PROCEDURE signup(
    IN nombre VARCHAR(25),
    IN apellido VARCHAR(25),
    IN input_correo VARCHAR(50),
    IN telefono VARCHAR(20),
    IN usr VARCHAR(50),
    IN input_pswrd VARCHAR(64)
)
BEGIN
    DECLARE user_exists INT;

    SELECT COUNT(*)
    INTO user_exists
    FROM ClientesLogins
    WHERE client_user = usr;

    IF user_exists > 0 THEN
        SELECT 'Sign up failed: User already exists' AS Message;
    ELSE
        INSERT INTO Clientes(client_fname, client_lname, client_email, client_phone)
        VALUES (nombre, apellido, input_correo, telefono);

        INSERT INTO ClientesLogins(client_ID, client_user, client_password)
        VALUES (LAST_INSERT_ID(), usr, input_pswrd);

        SELECT 'Sign up successful' AS Message;
    END IF;
END$$

DELIMITER ;