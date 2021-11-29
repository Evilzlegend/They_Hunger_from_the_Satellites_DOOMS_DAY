CREATE DATABASE moonBase
GO

use moonBase
GO

CREATE TABLE Locations (
LocationID varchar(8) NOT NULL,
LocationName varchar(25) NULL,
LocationDescription varchar(100) NULL,
LocationStatus int DEFAULT 5 NULL,
PRIMARY KEY(LocationID),
CONSTRAINT LocationIDCheck CHECK (LocationID LIKE 'LO%'),
CONSTRAINT LocationStatusCheck CHECK (LocationStatus >=1 AND LocationStatus <=5)
)
GO

CREATE TABLE Skills (
SkillsID varchar(8) NOT NULL,
SkillName varchar(30) NOT NULL,
SkillDescription varchar(100) NOT NULL,
SkillRanking int NULL,
PRIMARY KEY (SkillsID),
CONSTRAINT SkillsIDCheck CHECK (SkillsID LIKE 'SK%'),
)
GO

CREATE TABLE Residents (
ResidentID varchar(8) NOT NULL,
ResFirstName varchar(20) NOT NULL,
ResLastName varchar(25) NOT NULL,
Gender varchar(10) NULL,
Age float NOT NULL,
Communicator varchar(10) NOT NULL,
SkillsID varchar(8) NULL,
LocationID varchar(8) NULL,
PRIMARY KEY (ResidentID),
CONSTRAINT ResidentIDCheck CHECK (LocationID LIKE 'RE%'),
CONSTRAINT GenderCheck CHECK (Gender like 'Male' OR Gender like 'Female' OR Gender like 'Other' 
OR Gender like 'PNTS'),
CONSTRAINT FK_SkillsID FOREIGN KEY (SkillsID) REFERENCES Skills(SkillsID),
CONSTRAINT FK_LocationID FOREIGN KEY (LocationID) REFERENCES Locations(LocationID)
)
GO

CREATE TABLE Patients (
PatientID varchar(8) NOT NULL,
ResidentID varchar(8) NOT NULL,
LocationID varchar(8) NOT NULL,
BodyTemp float DEFAULT 98.6 NULL,
BloodType varchar(3) NULL,
WhiteBloodCellCount int NULL,
BloodSerumToxicity float DEFAULT 15 NULL,
TreatmentProtocolA varchar(1) NULL,
TreatmentProtocolB varchar(1) NULL,
TreatmentProtocolC varchar(1) NULL,
Prognosis int NULL,
PRIMARY KEY(PatientID),
CONSTRAINT PatientIDCheck CHECK (PatientID LIKE 'PA%'),
CONSTRAINT BodyTempCheck CHECK (BodyTemp > 32),
CONSTRAINT BloodTypeCheck CHECK (BloodType LIKE 'A+' OR BloodType LIKE 'A-' OR
BloodType LIKE 'B+' OR BloodType LIKE 'B-' OR BloodType LIKE 'AB+' OR 
BloodType LIKE 'AB-' OR BloodType LIKE 'O+' OR BloodType LIKE 'O-'),
CONSTRAINT WhiteCellCountCheck CHECK (WhiteBloodCellCount > 0),
CONSTRAINT BloodSerumToxicityCheck CHECK (BloodSerumToxicity >=0 AND BloodSerumToxicity < 100),
CONSTRAINT TreatmentProtocolACheck CHECK (TreatmentProtocolA LIKE 'Y' OR TreatmentProtocolA LIKE 'N'),
CONSTRAINT TreatmentProtocolBCheck CHECK (TreatmentProtocolB LIKE 'Y' OR TreatmentProtocolB LIKE 'N'),
CONSTRAINT TreatmentProtocolCCheck CHECK (TreatmentProtocolC LIKE 'Y' OR TreatmentProtocolC LIKE 'N'),
CONSTRAINT PrognosisCheck CHECK (Prognosis > 0 AND Prognosis < 10),
CONSTRAINT FK_ResidentID FOREIGN KEY (ResidentID) REFERENCES Residents(ResidentID)
)
GO



CREATE TABLE Infected (
InfectedID varchar (8) NOT NULL,
TurnDate date NOT NULL,
InfectedType varchar (25) NOT NUll,
InfectedDescription varchar (100) NOT NULL,
InfectedWeaknesses varchar(30) NUll,
InfectedQty int NOT NULL,
LocationID varchar(8) NOT NULL,
PRIMARY KEY (infectedID),
FOREIGN KEY (LocationID) REFERENCES Locations(LocationID),
CONSTRAINT InfectedQtyCheck CHECK (InfectedQty >= 1 AND InfectedQty <= 999),
CONSTRAINT InfectedIDCheck CHECK (InfectedID LIKE 'ZO%'),
)
GO

CREATE TABLE Inventory (
InventoryID varchar(8) NOT NULL,
InventoryType varchar(20) NOT NULL,
InventoryQty int NOT NULL,
InventoryUnit varchar(15),
InventoryPrice money NOT NULL,
InventoryPricePerUnit varchar(15) NOT NULL,
PRIMARY KEY (InventoryID),
CONSTRAINT InventoryIDCheck CHECK (InventoryID LIKE 'IN%'),
)
GO

CREATE TABLE Suppliers (
SupplierID varchar(8) NOT NULL,
SupplierName varchar(30) NOT NULL,
SupplierLocation varchar(100) NOT NULL,
SupplierPhone varchar(16) NOT NULL,
SupplierEmail varchar(30) NULL,
PRIMARY KEY (SupplierID),
CONSTRAINT SupplierIDCheck CHECK (SupplierID LIKE 'SU%')
)
GO


CREATE TABLE OrderedInventory (
OrderID varchar(8) NOT NULL,
InventoryID varchar(8) NOT NULL,
SupplierID varchar(8) NOT NULL,
OrderQty int NOT NULL,
OrderUnit varchar(15) NOT NULL,
ReceiveDate date NOT NULL,
LithiumExchanged money NOT NULL,
PRIMARY KEY (OrderID),
CONSTRAINT OrderIDCheck CHECK (OrderID LIKE 'OR%'),
CONSTRAINT FK_InventoryID FOREIGN KEY (InventoryID) REFERENCES Inventory(InventoryID),
CONSTRAINT FK_SupplierID FOREIGN KEY (SupplierID) REFERENCES Suppliers(SupplierID)
)
GO

CREATE TABLE LocationInventory (
LocationInventoryID varchar(8) NOT NULL,
InventoryID varchar(8) NOT NULL,
LocationInventoryQty int NULL,
LocationID varchar(8) NOT NULL,
PRIMARY KEY (LocationInventoryID),
)
GO

CREATE TABLE LithiumStocks (
LithiumID varchar(8) NOT NULL,
LithiumQty int DEFAULT 0 NULL,
LocationID varchar(8) NOT NULL,
PRIMARY KEY (LithiumID),
CONSTRAINT LithiumIDCheck CHECK (LithiumID LIKE 'LI%'),
)
GO

CREATE TABLE ResidentSkills(
ResidentSkillID varchar(8) NOT NULL,
SkillsID varchar(8) NOT NULL,
ResidentID varchar(8) NOT NULL,
PRIMARY KEY (ResidentSkillID),
CONSTRAINT ResidentSkillIDCheck CHECK (ResidentSkillID LIKE 'RS%'),
)