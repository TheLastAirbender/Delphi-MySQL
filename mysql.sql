
CREATE TABLE Trip_Type
(
	Trip_Number  INTEGER UNIQUE,
	Starting_Point  VARCHAR(20) NULL,
	Destination  VARCHAR(20) NULL,
	Distance  INTEGER NULL,
	 PRIMARY KEY (Trip_Number)
)
;



CREATE TABLE Car
(
	License_Plate_N  INTEGER UNIQUE,
	Car_Truck  VARCHAR(20) NULL,
	Trademark  VARCHAR(20) NULL,
	Color  VARCHAR(20) NULL,
	 PRIMARY KEY (License_Plate_N)
)
;



CREATE TABLE Car_Trip
(
	Start_Date  DATE NULL,
	Start_Time  DATE NULL,
	Finish_Date  DATE NULL,
	Finish_Time  DATE NULL,
	Cargo_Weight  INTEGER NULL,
	Trip_Number  INTEGER NOT NULL,
	License_Plate_N  INTEGER NOT NULL,
	 PRIMARY KEY (License_Plate_N,Trip_Number)FOREIGN KEY (Trip_Number) REFERENCES Trip_Type(Trip_Number),
	FOREIGN KEY (License_Plate_N) REFERENCES Car(License_Plate_N)
)
;



CREATE TABLE Repair_Type
(
	Type  VARCHAR(20) UNIQUE,
	Duration  INTEGER NULL,
	 PRIMARY KEY (Type)
)
;



CREATE TABLE Car_Repair
(
	Start_Date  DATE NULL,
	Start_Time  DATE NULL,
	License_Plate_N  INTEGER NOT NULL,
	Type  VARCHAR(20) NOT NULL,
	 PRIMARY KEY (Type,License_Plate_N): FOREIGN KEY (License_Plate_N) REFERENCES Car(License_Plate_N),
	FOREIGN KEY (Type) REFERENCES Repair_Type(Type)
)
;


