/*
===============================================================================
 Project      : Hospital Management System
 File         : 06_Stored_Procedures.sql
 Author       : Hossam Elnagar

 Description:
 Creating stored procedures for hospital operations and reporting.

===============================================================================
*/

USE HospitalManagementDB;
GO



/*==============================================================================
 Procedure 1:
 Get All Patients
==============================================================================*/

CREATE PROCEDURE sp_GetAllPatients

AS
BEGIN

    SELECT

        PatientID,

        FirstName,

        LastName,

        Gender,

        DateOfBirth,

        BloodType,

        PhoneNumber

    FROM Patients;

END;

GO



/*==============================================================================
 Procedure 2:
 Get Patient By ID
==============================================================================*/

CREATE PROCEDURE sp_GetPatientByID

    @PatientID INT

AS
BEGIN

    SELECT *

    FROM Patients

    WHERE PatientID = @PatientID;

END;

GO



/*==============================================================================
 Procedure 3:
 Get Doctors By Department
==============================================================================*/

CREATE PROCEDURE sp_GetDoctorsByDepartment

    @DepartmentID INT

AS
BEGIN

    SELECT

        D.DoctorID,

        D.FirstName + ' ' + D.LastName AS DoctorName,

        D.Specialty,

        DP.DepartmentName

    FROM Doctors D

    INNER JOIN Departments DP

    ON D.DepartmentID = DP.DepartmentID

    WHERE D.DepartmentID = @DepartmentID;

END;

GO



/*==============================================================================
 Procedure 4:
 Add New Patient
==============================================================================*/

CREATE PROCEDURE sp_AddPatient

    @FirstName NVARCHAR(50),

    @LastName NVARCHAR(50),

    @Gender CHAR(1),

    @DateOfBirth DATE,

    @BloodType VARCHAR(3),

    @PhoneNumber VARCHAR(20),

    @Email VARCHAR(100),

    @Address NVARCHAR(255),

    @EmergencyContact VARCHAR(20)

AS
BEGIN

    INSERT INTO Patients
    (
        FirstName,
        LastName,
        Gender,
        DateOfBirth,
        BloodType,
        PhoneNumber,
        Email,
        Address,
        EmergencyContact
    )

    VALUES
    (
        @FirstName,
        @LastName,
        @Gender,
        @DateOfBirth,
        @BloodType,
        @PhoneNumber,
        @Email,
        @Address,
        @EmergencyContact
    );

END;

GO



/*==============================================================================
 Procedure 5:
 Update Patient Phone
==============================================================================*/

CREATE PROCEDURE sp_UpdatePatientPhone

    @PatientID INT,

    @NewPhone VARCHAR(20)

AS
BEGIN

    UPDATE Patients

    SET PhoneNumber = @NewPhone

    WHERE PatientID = @PatientID;

END;

GO



/*==============================================================================
 Procedure 6:
 Delete Patient
==============================================================================*/

CREATE PROCEDURE sp_DeletePatient

    @PatientID INT

AS
BEGIN

    DELETE FROM Patients

    WHERE PatientID = @PatientID;

END;

GO



/*==============================================================================
 Procedure 7:
 Get Appointment Details
==============================================================================*/

CREATE PROCEDURE sp_GetAppointmentDetails

AS
BEGIN

    SELECT

        A.AppointmentID,

        P.FirstName + ' ' + P.LastName AS PatientName,

        D.FirstName + ' ' + D.LastName AS DoctorName,

        A.AppointmentDate,

        A.Status

    FROM Appointments A

    INNER JOIN Patients P

    ON A.PatientID = P.PatientID


    INNER JOIN Doctors D

    ON A.DoctorID = D.DoctorID;

END;

GO



/*==============================================================================
 Procedure 8:
 Get Patient Billing Information
==============================================================================*/

CREATE PROCEDURE sp_GetPatientBilling

    @PatientID INT

AS
BEGIN

    SELECT

        B.BillID,

        B.Amount,

        B.PaymentStatus,

        B.PaymentDate

    FROM Billing B

    WHERE PatientID = @PatientID;

END;

GO



/*==============================================================================
 Procedure 9:
 Get Low Stock Medicines
==============================================================================*/

CREATE PROCEDURE sp_GetLowStockMedicines

    @StockLimit INT

AS
BEGIN

    SELECT

        MedicineID,

        MedicineName,

        QuantityInStock

    FROM Medicines

    WHERE QuantityInStock < @StockLimit;

END;

GO



/*==============================================================================
 Procedure 10:
 Hospital Revenue Report
==============================================================================*/

CREATE PROCEDURE sp_TotalRevenue

AS
BEGIN

    SELECT

        SUM(Amount) AS TotalRevenue

    FROM Billing

    WHERE PaymentStatus = 'Paid';

END;

GO



/*==============================================================================
 Testing Stored Procedures
==============================================================================*/

EXEC sp_GetAllPatients;


EXEC sp_GetPatientByID 
@PatientID = 1;


EXEC sp_GetDoctorsByDepartment
@DepartmentID = 1;


EXEC sp_GetAppointmentDetails;


EXEC sp_GetPatientBilling
@PatientID = 1;


EXEC sp_GetLowStockMedicines
@StockLimit = 100;


EXEC sp_TotalRevenue;

GO