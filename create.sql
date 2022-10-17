ALTER SESSION SET NLS_DATE_FORMAT='DD-MM-YYYY';

CREATE TABLE Vaccine_Companies(
Brand_id NUMBER(2),
Company_name VARCHAR(80),
Vaccine_name VARCHAR(60),
Vaccine_code VARCHAR(60),
CONSTRAINT pk_Vaccine_Companies PRIMARY KEY (Brand_id)
);





CREATE TABLE COUNTRIES(
Country_code NUMBER(3),
Country_name VARCHAR(60),
CONSTRAINT pk_Countries PRIMARY KEY (Country_code)
);


CREATE TABLE Population(
 puid VARCHAR(45),
 ID_number VARCHAR(10),
 First_name VARCHAR(45),
 Last_name VARCHAR(45),
 Birthdate DATE,
 Phone VARCHAR(15),
 Street VARCHAR(45),
 Zip_code NUMBER(7),
 City VARCHAR(25),
 State VARCHAR(3),
 Country NUMBER(3),
 CONSTRAINT pk_Population PRIMARY KEY (puid),
 CONSTRAINT fk_Population_to_Countries foreign key (Country) references countries (country_code)
);



CREATE TABLE Vaccination_Centers(
Object_id NUMBER(6),
Fac_id NUMBER(10),
Facility_name VARCHAR(150),
Address VARCHAR(150),
City VARCHAR(25),
State VARCHAR(3),
Zip_code NUMBER(7),
Phone_number VARCHAR(15),
County VARCHAR(50),
Country NUMBER(3),
Latitude NUMBER(10),
Longtitude NUMBER(10),
Website VARCHAR(300),
Helipad CHAR(1),
CONSTRAINT pk_Vaccination_Centers PRIMARY KEY (Fac_id),
constraint fk_VCto_Countries foreign key (Country) references Countries (Country_code)
);


CREATE TABLE Vaccinations(
VaccID NUMBER(15),
vuid VARCHAR(45),
Vaccine_type NUMBER(2),
First_dose VARCHAR(5),
First_dose_date DATE,
Second_dose VARCHAR(5),
Second_dose_date DATE,
Vaccination_center NUMBER(10),
CONSTRAINT pk_Vaccinations PRIMARY KEY (VaccID),
constraint fk_Vaccinations_to_Population foreign key (vuid) references POPULATION (puid),
constraint fk_Vacc_to_VCO foreign key (Vaccine_type) references Vaccine_Companies(Brand_id),
constraint fk_Vacc_to_VCenters foreign key (Vaccination_center) references Vaccination_Centers(Fac_id)
);



COMMIT;












