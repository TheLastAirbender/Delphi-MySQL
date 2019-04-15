#select * from Car;
#select * from Trip_Type;
#select * from Repair_Type;
select * from Car_Repair;
#select * from Car_trip;

#SHOW tables from newschema;
/*
INSERT INTO CAR(License_Plate_N, Car_Truck, Trademark, Color)
	VALUES('333','Yes','Toyota','Black')
INSERT INTO Car VALUES('125','No','BMW','Red')

UPDATE CAR
SET Trademark='Mazda'
WHERE License_Plate_N='125'

#DROP PROCEDURE Add_Car

#DELETE FROM Car WHERE Car_Truck='Yes' 

#-----------------------------ПРОЦЕДУРА ДОБАВЛЕНИЯ МАШИНЫ--------------
DELIMITER //
CREATE PROCEDURE Add_Car(Nomer VARCHAR(20), Cargo VARCHAR(20), Marka VARCHAR(20), Cvet VARCHAR(20))
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45002' SET err=TRUE;
    SELECT COUNT(*) FROM Car
    WHERE License_Plate_N=Nomer INTO k;
    IF k=0 THEN
		INSERT INTO CAR VALUES(Nomer, Cargo, Marka, Cvet);
	ELSE
		SIGNAL SQLSTATE '45000' SET message_text='Car Already Exists';
    END IF;
END
//
#DROP PROCEDURE Edit_Car;

#-----------------------------ПРОЦЕДУРА ИЗМЕНЕНИЯ МАШИНЫ--------------
DELIMITER // 
CREATE PROCEDURE Edit_Car(Nomer VARCHAR(20), Cargo VARCHAR(20), Marka VARCHAR(20), Cvet VARCHAR(20))
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45000' SET err=TRUE;
    SELECT COUNT(*) FROM Car
    WHERE License_Plate_N=Nomer INTO k;
    IF k=1 THEN
		UPDATE CAR #VALUES(Nomer, Cargo, Marka, Cvet);
        SET Car_Truck=Cargo,
            Trademark=Marka,
            Color=Cvet
		WHERE License_Plate_N=Nomer;
	ELSE
		SIGNAL SQLSTATE '45000' SET message_text='Car Doesn`t Exist';
    END IF;
END
//

#-----------------------------ПРОЦЕДУРА УДАЛЕНИЯ МАШИНЫ--------------
DELIMITER //
CREATE PROCEDURE Delete_Car(Nomer VARCHAR(20))
BEGIN
	DECLARE k INTEGER;
	DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45001' SET err=TRUE;
	SELECT COUNT(*) FROM Car
    WHERE License_Plate_N=Nomer INTO k;
    IF k=1 THEN
		DELETE FROM Car WHERE License_Plate_N=Nomer;
	ELSE 
		SIGNAL SQLSTATE '45001' SET message_text='Car Doesn`t Exist';
	END IF;
END
// 

#---------------------------ПРОЦЕДУРА ДОБАВЛЕНИЯ РЕЙСА----------------
DELIMITER //
CREATE PROCEDURE Add_Trip(Nomer INTEGER, Start VARCHAR(20), Finish VARCHAR(20), Rasst INTEGER)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45003' SET err=TRUE;
    SELECT COUNT(*) FROM Trip_Type
    WHERE Trip_Number=Nomer INTO k;
    IF k=0 THEN
		INSERT INTO Trip_Type VALUES(Nomer, Start, Finish, Rasst);
	ELSE
		SIGNAL SQLSTATE '45003' SET message_text='Trip Already Exists';
    END IF;
END
//

#---------------------------ПРОЦЕДУРА УДАЛЕНИЯ РЕЙСА----------------
DELIMITER //
CREATE PROCEDURE Delete_Trip(Nomer INTEGER)
BEGIN
	DECLARE k INTEGER;
	DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45004' SET err=TRUE;
	SELECT COUNT(*) FROM Trip_Type
    WHERE Trip_Number=Nomer INTO k;
    IF k=1 THEN
		DELETE FROM Trip_Type WHERE Trip_Number=Nomer;
	ELSE 
		SIGNAL SQLSTATE '45004' SET message_text='Trip Doesn`t Exist';
	END IF;
END
// 

#-------------------------ПРОЦЕДУРА ИЗМЕНЕНИЯ РЕЙСА-----------------
DELIMITER // 
CREATE PROCEDURE Edit_Trip(Nomer INTEGER, Start VARCHAR(20), Finish VARCHAR(20), Rasst INTEGER)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45005' SET err=TRUE;
    SELECT COUNT(*) FROM Trip_Type
    WHERE Trip_Number=Nomer INTO k;
    IF k=1 THEN
		UPDATE Trip_Type #VALUES(Nomer, Start, Finish, Rasst);
        SET Starting_Point=Start,
            Destination=Finish,
            Distance=Rasst
		WHERE Trip_Number=Nomer;
	ELSE
		SIGNAL SQLSTATE '45005' SET message_text='Trip Doesn`t Exist';
    END IF;
END
//

#-------------------------ПРОЦЕДУРА ДОБАВЛЕНИЯ РЕМОНТА-----------------
DELIMITER //
CREATE PROCEDURE Add_Repair(Tip VARCHAR(20), Dlit INTEGER)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45006' SET err=TRUE;
    SELECT COUNT(*) FROM Repair_Type
    WHERE Type=Tip INTO k;
    IF k=0 THEN
		INSERT INTO Repair_Type VALUES(Tip, Dlit);
	ELSE
		SIGNAL SQLSTATE '45006' SET message_text='Repair Already Exists';
    END IF;
END
//

#-------------------------ПРОЦЕДУРА УДАЛЕНИЯ РЕМОНТА-----------------
DELIMITER //
CREATE PROCEDURE Delete_Repair(Tip VARCHAR(20))
BEGIN
	DECLARE k INTEGER;
	DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45007' SET err=TRUE;
	SELECT COUNT(*) FROM Repair_Type
    WHERE Type=Tip INTO k;
    IF k=1 THEN
		DELETE FROM Repair_Type WHERE Type=Tip;
	ELSE 
		SIGNAL SQLSTATE '45007' SET message_text='Trip Doesn`t Exist';
	END IF;
END
// 

#-------------------------ПРОЦЕДУРА ИЗМЕНЕНИЯ РЕМОНТА-----------------
DELIMITER // 
CREATE PROCEDURE Edit_Repair(Tip VARCHAR(20), Dlit INTEGER)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45008' SET err=TRUE;
    SELECT COUNT(*) FROM Repair_Type
    WHERE Type=Tip INTO k;
    IF k=1 THEN
		UPDATE Repair_Type
        SET Duration=Dlit
		WHERE Type=Tip;
	ELSE
		SIGNAL SQLSTATE '45008' SET message_text='Trip Doesn`t Exist';
    END IF;
END
//

#-------------------------ПРОЦЕДУРА ДОБАВЛЕНИЯ РЕЙСА МАШИНЫ-----------------
DELIMITER //
CREATE PROCEDURE Add_CarTrip(Start DATE, Starttime DATE, Finish DATE, Finishtime DATE, Gruz INTEGER, Trip INTEGER, Nomer INTEGER)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45009' SET err=TRUE;
    SELECT COUNT(*) FROM Car_Trip
    WHERE Trip_Number=Trip
		AND License_plate_N=Nomer INTO k;
    IF k=0 THEN
		INSERT INTO Car_Trip VALUES(Start, Starttime, Finish, Finishtime, Gruz, Trip, Nomer);
	ELSE
		SIGNAL SQLSTATE '45009' SET message_text='Car Trip Already Exists';
    END IF;
END
//

#-------------------------ПРОЦЕДУРА УДАЛЕНИЯ РЕЙСА МАШИНЫ-----------------
DELIMITER //
CREATE PROCEDURE Delete_CarTrip(Trip INTEGER, Nomer INTEGER)
BEGIN
	DECLARE k INTEGER;
	DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45010' SET err=TRUE;
	SELECT COUNT(*) FROM Car_Trip
	WHERE Trip_Number=Trip AND License_plate_N=Nomer INTO k;
    IF k=1 THEN
		DELETE FROM Car_Trip WHERE Trip_Number=Trip AND License_plate_N=Nomer;
	ELSE 
		SIGNAL SQLSTATE '45010' SET message_text='Car Trip Doesn`t Exist';
	END IF;
END
// 

#-------------------------ПРОЦЕДУРА ИЗМЕНЕНИЯ РЕЙСА МАШИНЫ-----------------
DELIMITER // 
CREATE PROCEDURE Edit_CarTrip(Start DATE, Starttime DATE, Finish DATE, Finishtime DATE, Gruz INTEGER, Trip INTEGER, Nomer INTEGER)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45011' SET err=TRUE;
    SELECT COUNT(*) FROM Car_Trip
    WHERE Trip_Number=Trip AND License_plate_N=Nomer INTO k;
    IF k=1 THEN
		UPDATE Car_Trip
        SET Start_Date=Start,
			Start_Time=Starttime,
			Finish_Date=Finish,
            Finish_Time=Finishtime,
            Cargo_weight=Gruz
		WHERE Trip_Number=Trip AND License_plate_N=Nomer;
	ELSE
		SIGNAL SQLSTATE '45011' SET message_text='Trip Doesn`t Exist';
    END IF;
END
//

#-------------------------ПРОЦЕДУРА ДОБАВЛЕНИЯ РЕМОНТА МАШИНЫ-----------------
DELIMITER //
CREATE PROCEDURE Add_CarRepair(Number INTEGER, Remont VARCHAR(20), Start DATE, StarTime DATETIME)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45009' SET err=TRUE;
    SELECT COUNT(*) FROM Car_Repair
    WHERE Type=Remont
		AND License_plate_N=Number INTO k;
    IF k=0 THEN
		INSERT INTO Car_Repair VALUES(Start, StarTime, Number, Remont);
	ELSE
		SIGNAL SQLSTATE '45009' SET message_text='Car Repair Already Exists';
    END IF;
END
//

#-------------------------ПРОЦЕДУРА УДАЛЕНИЯ РЕМОНТА МАШИНЫ-----------------
DELIMITER //
CREATE PROCEDURE Delete_CarRepair(Number INTEGER, Remont VARCHAR(20))
BEGIN
	DECLARE k INTEGER;
	DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45010' SET err=TRUE;
	SELECT COUNT(*) FROM Car_Repair
	WHERE Type=Remont AND License_plate_N=Number INTO k;
    IF k=1 THEN
		DELETE FROM Car_Repair WHERE Remont=Type AND License_plate_N=Number;
	ELSE 
		SIGNAL SQLSTATE '45010' SET message_text='Car Repair Doesn`t Exist';
	END IF;
END
// 

drop procedure Edit_CarRepair;
#-------------------------ПРОЦЕДУРА ИЗМЕНЕНИЯ РЕМОНТА МАШИНЫ-----------------
DELIMITER // 
CREATE PROCEDURE Edit_CarRepair(Number INTEGER, Remont VARCHAR(20), Start DATE, StartTime DATETIME)
BEGIN
	DECLARE k INTEGER;
    DECLARE err INTEGER DEFAULT FALSE;
    DECLARE EXIT HANDLER FOR SQLSTATE '45011' SET err=TRUE;
    SELECT COUNT(*) FROM Car_Repair
    WHERE Type=Remont AND License_plate_N=Number INTO k;
    IF k=1 THEN
		UPDATE Car_Repair
        SET Start_Date=Start,
			Start_Time=StartTime
		WHERE Type=Remont AND License_plate_N=Number;
	ELSE
		SIGNAL SQLSTATE '45011' SET message_text='Repair Doesn`t Exist';
    END IF;
END
//

#-------------------------ПРОЦЕДУРА ВЫВОДА ВСЕХ ПЕРЕВЕЗЁННЫХ ГРУЗОВ ГРУЗОВЫХ МАШИН-----------------
DELIMITER // 
CREATE PROCEDURE Return_CargoList
RETURNS (Nomer INTEGER, Data DATE, )
END
//
*/

#drop procedure Delete_CarRepair;
#call Delete_CarRepair(333, 'Engine');
#call Edit_CarRepair(333,'Engine',date(now()), time(now()));
#call Add_CarRepair(333, 'Engine', date(now()), time(now()));

#call Add_CarTrip(date_add(now(), interval 0 day), date_add(now(), interval 14 day), date_add(now(), interval 0 day), date_add(now(), interval 14 day), 254,2,666);
#call Edit_CarTrip(date_add(now(), interval 0 day), date_add(now(), interval 14 day), date_add(now(), interval 0 day), date_add(now(), interval 14 day), 360,2,666);

#call Add_Repair('Body Repair',5)
#call Edit_Repair('Engine',7)
#call Delete_Repair('Body Repair')

#Call Edit_Trip(1,'Irkutsk','Kazan',4750)
#CALL Delete_Trip(1);
#CALL Add_Trip(1,'Irkutsk','Moscow',5120);

#CALL Delete_Car('666');
#CALL Edit_Car('666', 'Yes','Ford','White');*/
#CALL Add_Car('666','No','BMW','Green');