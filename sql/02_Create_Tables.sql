/*
===============================================================================
 Project      : Hospital Management System
 Database     : HospitalManagementDB
 File         : 02_Create_Tables.sql
 Author       : Hossam Elnagar

 Description:
 This script creates all tables for the Hospital Management System.

===============================================================================
*/

USE HospitalManagementDB;
GO

/*==============================================================================
    Table: Departments
==============================================================================*/

CREATE TABLE Departments
(
    DepartmentID INT IDENTITY(1,1) NOT NULL,

    DepartmentName NVARCHAR(100) NOT NULL,

    DepartmentCode VARCHAR(10) NOT NULL,

    Description NVARCHAR(255) NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Departments_CreatedAt
        DEFAULT GETDATE(),

    CONSTRAINT PK_Departments
        PRIMARY KEY (DepartmentID),

    CONSTRAINT UQ_Departments_Name
        UNIQUE (DepartmentName),

    CONSTRAINT UQ_Departments_Code
        UNIQUE (DepartmentCode)
);
GO

/*==============================================================================
    Table: Doctors
==============================================================================*/

CREATE TABLE Doctors
(
    DoctorID INT IDENTITY(1,1) NOT NULL,

    FirstName NVARCHAR(50) NOT NULL,

    LastName NVARCHAR(50) NOT NULL,

    Gender CHAR(1) NOT NULL,

    DateOfBirth DATE NOT NULL,

    Specialty NVARCHAR(100) NOT NULL,

    PhoneNumber VARCHAR(20) NULL,

    Email VARCHAR(100) NULL,

    HireDate DATE NOT NULL,

    Salary DECIMAL(10,2) NOT NULL,

    DepartmentID INT NOT NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Doctors_CreatedAt
        DEFAULT GETDATE(),

    CONSTRAINT PK_Doctors
        PRIMARY KEY (DoctorID),

    CONSTRAINT UQ_Doctors_Email
        UNIQUE (Email),

    CONSTRAINT UQ_Doctors_Phone
        UNIQUE (PhoneNumber),

    CONSTRAINT CHK_Doctors_Gender
        CHECK (Gender IN ('M','F')),

    CONSTRAINT CHK_Doctors_Salary
        CHECK (Salary >= 0),

    CONSTRAINT FK_Doctors_Departments
        FOREIGN KEY (DepartmentID)
        REFERENCES Departments(DepartmentID)
);
GO

/*==============================================================================
    Table: Patients
==============================================================================*/

CREATE TABLE Patients
(
    PatientID INT IDENTITY(1,1) NOT NULL,

    FirstName NVARCHAR(50) NOT NULL,

    LastName NVARCHAR(50) NOT NULL,

    Gender CHAR(1) NOT NULL,

    DateOfBirth DATE NOT NULL,

    BloodType VARCHAR(3) NULL,

    PhoneNumber VARCHAR(20) NULL,

    Email VARCHAR(100) NULL,

    Address NVARCHAR(255) NULL,

    EmergencyContact VARCHAR(20) NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Patients_CreatedAt
        DEFAULT GETDATE(),

    CONSTRAINT PK_Patients
        PRIMARY KEY (PatientID),

    CONSTRAINT UQ_Patients_Email
        UNIQUE (Email),

    CONSTRAINT UQ_Patients_Phone
        UNIQUE (PhoneNumber),

    CONSTRAINT CHK_Patients_Gender
        CHECK (Gender IN ('M','F')),

    CONSTRAINT CHK_Patients_BloodType
        CHECK (BloodType IN
        ('A+','A-','B+','B-','AB+','AB-','O+','O-'))
);
GO

/*==============================================================================
    Table: Rooms
==============================================================================*/

CREATE TABLE Rooms
(
    RoomID INT IDENTITY(1,1) NOT NULL,

    RoomNumber VARCHAR(10) NOT NULL,

    RoomType NVARCHAR(20) NOT NULL,

    Capacity INT NOT NULL,

    FloorNumber INT NOT NULL,

    Status VARCHAR(20) NOT NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Rooms_CreatedAt
        DEFAULT GETDATE(),

    CONSTRAINT PK_Rooms
        PRIMARY KEY (RoomID),

    CONSTRAINT UQ_Rooms_Number
        UNIQUE (RoomNumber),

    CONSTRAINT CHK_Rooms_Type
        CHECK (RoomType IN ('General','Private','ICU')),

    CONSTRAINT CHK_Rooms_Capacity
        CHECK (Capacity > 0),

    CONSTRAINT CHK_Rooms_Status
        CHECK (Status IN ('Available','Occupied','Maintenance'))
);
GO

/*==============================================================================
    Table: Staff
==============================================================================*/

CREATE TABLE Staff
(
    StaffID INT IDENTITY(1,1) NOT NULL,

    FirstName NVARCHAR(50) NOT NULL,

    LastName NVARCHAR(50) NOT NULL,

    JobTitle NVARCHAR(100) NOT NULL,

    PhoneNumber VARCHAR(20) NULL,

    Email VARCHAR(100) NULL,

    HireDate DATE NOT NULL,

    Salary DECIMAL(10,2) NOT NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Staff_CreatedAt
        DEFAULT GETDATE(),

    CONSTRAINT PK_Staff
        PRIMARY KEY (StaffID),

    CONSTRAINT UQ_Staff_Email
        UNIQUE (Email),

    CONSTRAINT UQ_Staff_Phone
        UNIQUE (PhoneNumber),

    CONSTRAINT CHK_Staff_Salary
        CHECK (Salary >= 0)
);
GO

/*==============================================================================
    Table: Medicines
==============================================================================*/

CREATE TABLE Medicines
(
    MedicineID INT IDENTITY(1,1) NOT NULL,

    MedicineName NVARCHAR(100) NOT NULL,

    Manufacturer NVARCHAR(100) NULL,

    UnitPrice DECIMAL(10,2) NOT NULL,

    QuantityInStock INT NOT NULL,

    ExpiryDate DATE NOT NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Medicines_CreatedAt
        DEFAULT GETDATE(),

    CONSTRAINT PK_Medicines
        PRIMARY KEY (MedicineID),

    CONSTRAINT UQ_Medicines_Name
        UNIQUE (MedicineName),

    CONSTRAINT CHK_Medicines_Price
        CHECK (UnitPrice >= 0),

    CONSTRAINT CHK_Medicines_Quantity
        CHECK (QuantityInStock >= 0)
);
GO


/*==============================================================================
    Table: Appointments
==============================================================================*/

CREATE TABLE Appointments
(
    AppointmentID INT IDENTITY(1,1) NOT NULL,

    PatientID INT NOT NULL,

    DoctorID INT NOT NULL,

    AppointmentDate DATETIME2 NOT NULL,

    Status VARCHAR(20) NOT NULL,

    Notes NVARCHAR(255) NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Appointments_CreatedAt DEFAULT GETDATE(),

    CONSTRAINT PK_Appointments
        PRIMARY KEY (AppointmentID),

    CONSTRAINT CHK_Appointments_Status
        CHECK (Status IN ('Scheduled','Completed','Cancelled')),

    CONSTRAINT FK_Appointments_Patients
        FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),

    CONSTRAINT FK_Appointments_Doctors
        FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID)
);
GO

/*==============================================================================
    Table: MedicalRecords
==============================================================================*/

CREATE TABLE MedicalRecords
(
    RecordID INT IDENTITY(1,1) NOT NULL,

    PatientID INT NOT NULL,

    DoctorID INT NOT NULL,

    Diagnosis NVARCHAR(255) NOT NULL,

    Treatment NVARCHAR(MAX) NULL,

    RecordDate DATE NOT NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_MedicalRecords_CreatedAt DEFAULT GETDATE(),

    CONSTRAINT PK_MedicalRecords
        PRIMARY KEY (RecordID),

    CONSTRAINT FK_MedicalRecords_Patients
        FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),

    CONSTRAINT FK_MedicalRecords_Doctors
        FOREIGN KEY (DoctorID)
        REFERENCES Doctors(DoctorID)
);
GO

/*==============================================================================
    Table: Prescriptions
==============================================================================*/

CREATE TABLE Prescriptions
(
    PrescriptionID INT IDENTITY(1,1) NOT NULL,

    RecordID INT NOT NULL,

    PrescriptionDate DATE NOT NULL,

    Notes NVARCHAR(255) NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Prescriptions_CreatedAt DEFAULT GETDATE(),

    CONSTRAINT PK_Prescriptions
        PRIMARY KEY (PrescriptionID),

    CONSTRAINT FK_Prescriptions_Record
        FOREIGN KEY (RecordID)
        REFERENCES MedicalRecords(RecordID)
);
GO

/*==============================================================================
    Table: PrescriptionItems
==============================================================================*/

CREATE TABLE PrescriptionItems
(
    PrescriptionItemID INT IDENTITY(1,1) NOT NULL,

    PrescriptionID INT NOT NULL,

    MedicineID INT NOT NULL,

    Dosage NVARCHAR(100) NOT NULL,

    DurationDays INT NOT NULL,

    Quantity INT NOT NULL,

    CONSTRAINT PK_PrescriptionItems
        PRIMARY KEY (PrescriptionItemID),

    CONSTRAINT CHK_PrescriptionItems_Duration
        CHECK (DurationDays > 0),

    CONSTRAINT CHK_PrescriptionItems_Quantity
        CHECK (Quantity > 0),

    CONSTRAINT FK_PrescriptionItems_Prescriptions
        FOREIGN KEY (PrescriptionID)
        REFERENCES Prescriptions(PrescriptionID),

    CONSTRAINT FK_PrescriptionItems_Medicines
        FOREIGN KEY (MedicineID)
        REFERENCES Medicines(MedicineID)
);
GO

/*==============================================================================
    Table: RoomAssignments
==============================================================================*/

CREATE TABLE RoomAssignments
(
    AssignmentID INT IDENTITY(1,1) NOT NULL,

    PatientID INT NOT NULL,

    RoomID INT NOT NULL,

    AdmissionDate DATE NOT NULL,

    DischargeDate DATE NULL,

    CONSTRAINT PK_RoomAssignments
        PRIMARY KEY (AssignmentID),

    CONSTRAINT FK_RoomAssignments_Patients
        FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID),

    CONSTRAINT FK_RoomAssignments_Rooms
        FOREIGN KEY (RoomID)
        REFERENCES Rooms(RoomID)
);
GO

/*==============================================================================
    Table: Billing
==============================================================================*/

CREATE TABLE Billing
(
    BillID INT IDENTITY(1,1) NOT NULL,

    PatientID INT NOT NULL,

    Amount DECIMAL(10,2) NOT NULL,

    PaymentStatus VARCHAR(20) NOT NULL,

    PaymentDate DATE NULL,

    CreatedAt DATETIME2 NOT NULL
        CONSTRAINT DF_Billing_CreatedAt DEFAULT GETDATE(),

    CONSTRAINT PK_Billing
        PRIMARY KEY (BillID),

    CONSTRAINT CHK_Billing_Amount
        CHECK (Amount >= 0),

    CONSTRAINT CHK_Billing_Status
        CHECK (PaymentStatus IN ('Pending','Paid','Cancelled')),

    CONSTRAINT FK_Billing_Patients
        FOREIGN KEY (PatientID)
        REFERENCES Patients(PatientID)
);
GO

/*SELECT
    TABLE_NAME
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_TYPE = 'BASE TABLE'
ORDER BY TABLE_NAME;

