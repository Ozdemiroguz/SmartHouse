
-- User Table
CREATE TABLE User (
    UserID INT(10) NOT NULL AUTO_INCREMENT,
    Mail VARCHAR(50) NOT NULL,
    Name VARCHAR(50),
    Surname VARCHAR(50),
    Password VARCHAR(50),
    Phone VARCHAR(10),
    NumberOfRooms INT(10),
    Active TINYINT(1),
    PRIMARY KEY (UserID)
);

-- Room Table
CREATE TABLE Room (
    RoomID INT(10) NOT NULL AUTO_INCREMENT,
    UserID INT(10),
    RoomName VARCHAR(50),
    OptimumTemperature FLOAT(10),
    OptimumHumidity FLOAT(10),
    OptimumGase FLOAT(10),
    RoomType VARCHAR(50),
    PRIMARY KEY (RoomID),
    FOREIGN KEY (UserID) REFERENCES User(UserID) ON DELETE CASCADE
);

-- Pot Table
CREATE TABLE Pot (
    RoomID INT(10),
    PotID INT(10) NOT NULL AUTO_INCREMENT,
    PlantType VARCHAR(50),
    Time TIMESTAMP,
    PRIMARY KEY (PotID),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);

-- Temp_Hum Table
CREATE TABLE Temp_Hum (
    RoomID INT(10),
    Temperature FLOAT(10),
    Humidity FLOAT(10),
    Time TIMESTAMP,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);

-- Gas Table
CREATE TABLE Gas (
    RoomID INT(10),
    Gas FLOAT(10),
    Time TIMESTAMP,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);

-- Fire Table
CREATE TABLE Fire (
    RoomID INT(10),
    Fire TINYINT(1),
    Time TIMESTAMP,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);

-- Move Table
CREATE TABLE Move (
    RoomID INT(10),
    Move INT(1),
    Time TIMESTAMP,
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);

-- Pot_Humidity Table
CREATE TABLE Pot_Humidity (
    PotID INT(10),
    Humidity FLOAT(10),
    Time TIMESTAMP,
    RoomID INT(10),
    FOREIGN KEY (PotID) REFERENCES Pot(PotID) ON DELETE CASCADE,
	FOREIGN KEY (RoomID) REFERENCES Room(RoomID) ON DELETE CASCADE
);



-- Average Temperature and Humidity per Hour Table
CREATE TABLE AVG_Temp_Hum_Hr (
    RoomID INT(10),
    AvgTemperature FLOAT(10),
    AvgHumidity FLOAT(10),
    Time TIMESTAMP,
    PRIMARY KEY (RoomID, Time),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- Average Gas per Hour Table
CREATE TABLE AVG_Gas_Hr (
    RoomID INT(10),
    AvgGas FLOAT(10),
    Time TIMESTAMP,
    PRIMARY KEY (RoomID, Time),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- Average Pot Humidity per Hour Table
CREATE TABLE AVG_Pot_Humidity_Hr (
    PotID INT(10),
    AvgHumidity FLOAT(10),
    Time TIMESTAMP,
    PRIMARY KEY (PotID, Time),
    FOREIGN KEY (PotID) REFERENCES Pot(PotID)
);

-- Average Temperature and Humidity per Day Table
CREATE TABLE AVG_Temp_Hum_Day (
    RoomID INT(10),
    AvgTemperature FLOAT(10),
    AvgHumidity FLOAT(10),
    Date DATE,
    PRIMARY KEY (RoomID, Date),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- Average Gas per Day Table
CREATE TABLE AVG_Gas_Day (
    RoomID INT(10),
    AvgGas FLOAT(10),
    Date DATE,
    PRIMARY KEY (RoomID, Date),
    FOREIGN KEY (RoomID) REFERENCES Room(RoomID)
);

-- Average Pot Humidity per Day Table
CREATE TABLE AVG_Pot_Humidity_Day (
    PotID INT(10),
    AvgHumidity FLOAT(10),
    Date DATE,
    PRIMARY KEY (PotID, Date),
    FOREIGN KEY (PotID) REFERENCES Pot(PotID)
);

-- Stored Procedure for AVG_Gas_Hr
DELIMITER //
CREATE DEFINER=`u3mi6cucuf4vh59u`@`%` PROCEDURE `CalculateAvgGasHourly`()
BEGIN
    DECLARE room_id INT;
    DECLARE avg_gas FLOAT;
    
    DECLARE room_cursor CURSOR FOR
        SELECT RoomID FROM Gas
        GROUP BY RoomID
        HAVING MAX(Time) > NOW() - INTERVAL 1 HOUR;
    
    OPEN room_cursor;
    
    read_loop: LOOP
        FETCH room_cursor INTO room_id;
        IF room_id IS NULL THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate average gas level for the room for the last hour
        SELECT AVG(Gas) INTO avg_gas
        FROM Gas
        WHERE RoomID = room_id AND Time > NOW() - INTERVAL 1 HOUR;
        
        -- Check if the room_id already exists in AVG_Gas_Hr for the current hour
        IF NOT EXISTS (SELECT 1 FROM AVG_Gas_Hr WHERE RoomID = room_id AND Time = NOW()) THEN
            -- Insert the calculated values into AVG_Gas_Hr
            INSERT INTO AVG_Gas_Hr (RoomID, AvgGas, Time)
            VALUES (room_id, avg_gas, NOW());
        END IF;
    END LOOP;
    
    CLOSE room_cursor;
    
END
//
DELIMITER ;



-- Stored Procedure for AVG_Pot_Humidity_Hr
DELIMITER //
CREATE DEFINER=`u3mi6cucuf4vh59u`@`%` PROCEDURE `CalculateAvgPotHumidityHourly`()
BEGIN
    DECLARE pot_id INT;
    DECLARE avg_humidity FLOAT;
    
    DECLARE pot_cursor CURSOR FOR
        SELECT PotID FROM Pot_Humidity
        GROUP BY PotID
        HAVING MAX(Time) > NOW() - INTERVAL 1 HOUR;
    
    OPEN pot_cursor;
    
    read_loop: LOOP
        FETCH pot_cursor INTO pot_id;
        IF pot_id IS NULL THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate average humidity for the pot for the last hour
        SELECT AVG(Humidity) INTO avg_humidity
        FROM Pot_Humidity
        WHERE PotID = pot_id AND Time > NOW() - INTERVAL 1 HOUR;
        
        -- Check if the pot_id already exists in AVG_Pot_Humidity_Hr for the current hour
        IF NOT EXISTS (SELECT 1 FROM AVG_Pot_Humidity_Hr WHERE PotID = pot_id AND Time = NOW()) THEN
            -- Insert the calculated values into AVG_Pot_Humidity_Hr
            INSERT INTO AVG_Pot_Humidity_Hr (PotID, AvgHumidity, Time)
            VALUES (pot_id, avg_humidity, NOW());
        END IF;
    END LOOP;
    
    CLOSE pot_cursor;
    
END
//
DELIMITER ;

-- Stored Procedure for AVG_Temp_Hum_Hr
DELIMITER //
CREATE DEFINER=`u3mi6cucuf4vh59u`@`%` PROCEDURE `CalculateAvgTempHumidityHourly`()
BEGIN
    DECLARE room_id INT;
    DECLARE avg_temp FLOAT;
    DECLARE avg_humidity FLOAT;
    
    DECLARE room_cursor CURSOR FOR
        SELECT RoomID FROM Temp_Hum
        GROUP BY RoomID
        HAVING MAX(Time) > NOW() - INTERVAL 1 HOUR;
    
    OPEN room_cursor;
    
    read_loop: LOOP
        FETCH room_cursor INTO room_id;
        IF room_id IS NULL THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate average temperature and humidity for the room for the last hour
        SELECT AVG(Temperature), AVG(Humidity) INTO avg_temp, avg_humidity
        FROM Temp_Hum
        WHERE RoomID = room_id AND Time > NOW() - INTERVAL 1 HOUR;
        
        -- Check if the room_id already exists in AVG_Temp_Hum_Hr for the current hour
        IF NOT EXISTS (SELECT 1 FROM AVG_Temp_Hum_Hr WHERE RoomID = room_id AND Time = NOW()) THEN
            -- Insert the calculated values into AVG_Temp_Hum_Hr
            INSERT INTO AVG_Temp_Hum_Hr (RoomID, AvgTemperature, AvgHumidity, Time)
            VALUES (room_id, avg_temp, avg_humidity, NOW());
        END IF;
    END LOOP;
    
    CLOSE room_cursor;
    
END
//
DELIMITER ;


-- Stored Procedure for AVG_Pot_Humidity_Day
DELIMITER //
CREATE DEFINER=`u3mi6cucuf4vh59u`@`%` PROCEDURE `CalculateAvgPotHumidityDaily`()
BEGIN
    DECLARE pot_id INT;
    DECLARE avg_humidity FLOAT;
    DECLARE calc_date DATE;
    
    DECLARE pot_cursor CURSOR FOR
        SELECT PotID FROM AVG_Pot_Humidity_Hr
        GROUP BY PotID;
    
    OPEN pot_cursor;
    
    read_loop: LOOP
        FETCH pot_cursor INTO pot_id;
        IF pot_id IS NULL THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate average humidity for the pot for the current day
        SELECT DATE(Time), AVG(AvgHumidity) INTO calc_date, avg_humidity
        FROM AVG_Pot_Humidity_Hr
        WHERE PotID = pot_id AND DATE(Time) = CURDATE();
        
        -- Check if the pot_id already exists in AVG_Pot_Humidity_Day for the current day
        IF NOT EXISTS (SELECT 1 FROM AVG_Pot_Humidity_Day WHERE PotID = pot_id AND Date = CURDATE()) THEN
            -- Insert the calculated values into AVG_Pot_Humidity_Day
            INSERT INTO AVG_Pot_Humidity_Day (PotID, AvgHumidity, Date)
            VALUES (pot_id, avg_humidity, calc_date);
        END IF;
    END LOOP;
    
    CLOSE pot_cursor;
    
END
//
DELIMITER ;

-- Stored Procedure for AVG_Gas_Day
DELIMITER //
CREATE DEFINER=`u3mi6cucuf4vh59u`@`%` PROCEDURE `CalculateAvgGasDaily`()
BEGIN
    DECLARE room_id INT;
    DECLARE avg_gas FLOAT;
    DECLARE calc_date DATE;
    
    DECLARE room_cursor CURSOR FOR
        SELECT RoomID FROM AVG_Gas_Hr
        GROUP BY RoomID;
    
    OPEN room_cursor;
    
    read_loop: LOOP
        FETCH room_cursor INTO room_id;
        IF room_id IS NULL THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate average gas level for the room for the current day
        SELECT DATE(Time), AVG(AvgGas) INTO calc_date, avg_gas
        FROM AVG_Gas_Hr
        WHERE RoomID = room_id AND DATE(Time) = CURDATE();
        
        -- Check if the room_id already exists in AVG_Gas_Day for the current day
        IF NOT EXISTS (SELECT 1 FROM AVG_Gas_Day WHERE RoomID = room_id AND Date = CURDATE()) THEN
            -- Insert the calculated values into AVG_Gas_Day
            INSERT INTO AVG_Gas_Day (RoomID, AvgGas, Date)
            VALUES (room_id, avg_gas, calc_date);
        END IF;
    END LOOP;
    
    CLOSE room_cursor;
    
END
//
DELIMITER ;

-- Stored Procedure for AVG_Temp_Hum_Day
DELIMITER //
CREATE DEFINER=`u3mi6cucuf4vh59u`@`%` PROCEDURE `CalculateAvgTempHumidityDaily`()
BEGIN
    DECLARE room_id INT;
    DECLARE avg_temp FLOAT;
    DECLARE avg_humidity FLOAT;
    DECLARE calc_date DATE;
    
    DECLARE room_cursor CURSOR FOR
        SELECT RoomID FROM AVG_Temp_Hum_Hr
        GROUP BY RoomID;
    
    OPEN room_cursor;
    
    read_loop: LOOP
        FETCH room_cursor INTO room_id;
        IF room_id IS NULL THEN
            LEAVE read_loop;
        END IF;
        
        -- Calculate average temperature and humidity for the room for the current day
        SELECT DATE(Time), AVG(AvgTemperature), AVG(AvgHumidity) INTO calc_date, avg_temp, avg_humidity
        FROM AVG_Temp_Hum_Hr
        WHERE RoomID = room_id AND DATE(Time) = CURDATE();
        
        -- Check if the room_id already exists in AVG_Temp_Hum_Day for the current day
        IF NOT EXISTS (SELECT 1 FROM AVG_Temp_Hum_Day WHERE RoomID = room_id AND Date = CURDATE()) THEN
            -- Insert the calculated values into AVG_Temp_Hum_Day
            INSERT INTO AVG_Temp_Hum_Day (RoomID, AvgTemperature, AvgHumidity, Date)
            VALUES (room_id, avg_temp, avg_humidity, calc_date);
        END IF;
    END LOOP;
    
    CLOSE room_cursor;
    
END
//
DELIMITER ;


-- Event for AVG_Temp_Hum_Day

DELIMITER //
CREATE EVENT CalculateAvgTempHumidityDailyEvent
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    CALL CalculateAvgTempHumidityDaily();
END;
//
DELIMITER ;

-- Event for AVG_Gas_Day

DELIMITER //
CREATE EVENT CalculateAvgGasDailyEvent
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    CALL CalculateAvgGasDaily();
END;
//
DELIMITER ;


-- Event for AVG_Pot_Humidity_Day

DELIMITER //
CREATE EVENT CalculateAvgPotHumidityDailyEvent
ON SCHEDULE EVERY 1 DAY
DO
BEGIN
    CALL CalculateAvgPotHumidityDaily();
END;
//
DELIMITER ;


-- Event for AVG_Temp_Hum_Hr

DELIMITER //
CREATE EVENT CalculateAvgTempHumidityHourlyEvent
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    CALL CalculateAvgTempHumidityHourly();
END;
//
DELIMITER ;


-- Event for AVG_Gas_Hr


DELIMITER //
CREATE EVENT CalculateAvgGasHourlyEvent
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    CALL CalculateAvgGasHourly();
END;
//
DELIMITER ;

-- Event for AVG_Pot_Humidity_Hr


DELIMITER //
CREATE EVENT CalculateAvgPotHumidityHourlyEvent
ON SCHEDULE EVERY 1 HOUR
DO
BEGIN
    CALL CalculateAvgPotHumidityHourly();
END;
//
DELIMITER ;


-- SET TIMEZONE

SET global time_zone = '+03:00';
