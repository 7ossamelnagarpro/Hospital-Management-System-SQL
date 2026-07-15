/*
===============================================================================
 Project      : Hospital Management System
 File         : 08_Triggers.sql
 Author       : Hossam Elnagar

 Description:
 Creating database triggers for automation and auditing.

===============================================================================
*/

USE HospitalManagementDB;
GO



/*==============================================================================
 Create Audit Table
==============================================================================*/

CREATE TABLE Patient_Audit_Log
(
    AuditID INT IDENTITY(1,1) PRIMARY KEY,

    PatientID INT,

    ActionType VARCHAR(20),

    ActionDate DATETIME DEFAULT GETDATE(),

    ActionDescription NVARCHAR(255)
);

GO



/*==============================================================================
 Trigger 1:
 Log New Patient Insert
==============================================================================*/

CREATE TRIGGER trg_AfterPatientInsert

ON Patients

AFTER INSERT

AS
BEGIN

    INSERT INTO Patient_Audit_Log
    (
        PatientID,
        ActionType,
        ActionDescription
    )

    SELECT

        PatientID,

        'INSERT',

        'New patient added'

    FROM inserted;

END;

GO



/*==============================================================================
 Trigger 2:
 Log Patient Update
==============================================================================*/

CREATE TRIGGER trg_AfterPatientUpdate

ON Patients

AFTER UPDATE

AS
BEGIN

    INSERT INTO Patient_Audit_Log
    (
        PatientID,
        ActionType,
        ActionDescription
    )

    SELECT

        PatientID,

        'UPDATE',

        'Patient information updated'

    FROM inserted;

END;

GO



/*==============================================================================
 Trigger 3:
 Log Patient Delete
==============================================================================*/

CREATE TRIGGER trg_AfterPatientDelete

ON Patients

AFTER DELETE

AS
BEGIN

    INSERT INTO Patient_Audit_Log
    (
        PatientID,
        ActionType,
        ActionDescription
    )

    SELECT

        PatientID,

        'DELETE',

        'Patient record deleted'

    FROM deleted;

END;

GO



/*==============================================================================
 Trigger 4:
 Prevent Negative Salary
==============================================================================*/

CREATE TRIGGER trg_PreventNegativeDoctorSalary

ON Doctors

AFTER INSERT, UPDATE

AS
BEGIN

    IF EXISTS
    (
        SELECT *

        FROM inserted

        WHERE Salary < 0
    )

    BEGIN

        ROLLBACK TRANSACTION;

        THROW 50001,
        'Doctor salary cannot be negative',
        1;

    END

END;

GO



/*==============================================================================
 Trigger 5:
 Prevent Negative Medicine Stock
==============================================================================*/

CREATE TRIGGER trg_PreventNegativeMedicineStock

ON Medicines

AFTER INSERT, UPDATE

AS
BEGIN

    IF EXISTS
    (
        SELECT *

        FROM inserted

        WHERE QuantityInStock < 0
    )

    BEGIN

        ROLLBACK TRANSACTION;

        THROW 50002,
        'Medicine stock cannot be negative',
        1;

    END

END;

GO



/*==============================================================================
 Trigger Testing
==============================================================================*/


-- Test Insert Trigger

INSERT INTO Patients
(
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    BloodType,
    PhoneNumber,
    Email
)

VALUES
(
    'Test',
    'Patient',
    'M',
    '1990-01-01',
    'A+',
    '01999999999',
    'test@hospital.com'
);

GO



SELECT *

FROM Patient_Audit_Log;

GO



-- Test Update Trigger

UPDATE Patients

SET PhoneNumber = '01988888888'

WHERE PatientID = 6;

GO



SELECT *

FROM Patient_Audit_Log;

GO