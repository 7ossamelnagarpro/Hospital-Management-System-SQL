/*
===============================================================================
 Project      : Hospital Management System
 File         : 07_Functions.sql
 Author       : Hossam Elnagar

 Description:
 Creating user-defined functions for hospital calculations and reports.

===============================================================================
*/

USE HospitalManagementDB;
GO



/*==============================================================================
 Function 1:
 Calculate Patient Age
==============================================================================*/

CREATE FUNCTION fn_CalculatePatientAge
(
    @DateOfBirth DATE
)
RETURNS INT
AS
BEGIN

    DECLARE @Age INT;

    SET @Age =
    DATEDIFF(YEAR, @DateOfBirth, GETDATE());

    RETURN @Age;

END;

GO



/*==============================================================================
 Function 2:
 Get Full Patient Name
==============================================================================*/

CREATE FUNCTION fn_GetPatientFullName
(
    @PatientID INT
)
RETURNS NVARCHAR(150)

AS
BEGIN

    DECLARE @FullName NVARCHAR(150);


    SELECT

        @FullName =
        FirstName + ' ' + LastName

    FROM Patients

    WHERE PatientID = @PatientID;


    RETURN @FullName;

END;

GO



/*==============================================================================
 Function 3:
 Calculate Patient Total Bills
==============================================================================*/

CREATE FUNCTION fn_GetPatientTotalBills
(
    @PatientID INT
)
RETURNS DECIMAL(10,2)

AS
BEGIN

    DECLARE @Total DECIMAL(10,2);


    SELECT

        @Total = SUM(Amount)

    FROM Billing

    WHERE PatientID = @PatientID;


    RETURN ISNULL(@Total,0);

END;

GO



/*==============================================================================
 Function 4:
 Count Patient Appointments
==============================================================================*/

CREATE FUNCTION fn_GetPatientAppointmentCount
(
    @PatientID INT
)
RETURNS INT

AS
BEGIN

    DECLARE @Count INT;


    SELECT

        @Count = COUNT(AppointmentID)

    FROM Appointments

    WHERE PatientID = @PatientID;


    RETURN @Count;

END;

GO



/*==============================================================================
 Function 5:
 Get Doctor Name
==============================================================================*/

CREATE FUNCTION fn_GetDoctorName
(
    @DoctorID INT
)
RETURNS NVARCHAR(150)

AS
BEGIN

    DECLARE @DoctorName NVARCHAR(150);


    SELECT

        @DoctorName =
        FirstName + ' ' + LastName

    FROM Doctors

    WHERE DoctorID = @DoctorID;


    RETURN @DoctorName;

END;

GO



/*==============================================================================
 Function Testing
==============================================================================*/


-- Calculate Age

SELECT

    PatientID,

    FirstName,

    LastName,

    dbo.fn_CalculatePatientAge(DateOfBirth) AS Age

FROM Patients;


GO



-- Get Patient Name

SELECT

    dbo.fn_GetPatientFullName(1)
    AS PatientName;

GO



-- Patient Total Bills

SELECT

    PatientID,

    dbo.fn_GetPatientTotalBills(PatientID)
    AS TotalBills

FROM Patients;


GO



-- Patient Appointment Count

SELECT

    PatientID,

    dbo.fn_GetPatientAppointmentCount(PatientID)
    AS TotalAppointments

FROM Patients;


GO



-- Doctor Name

SELECT

    dbo.fn_GetDoctorName(1)
    AS DoctorName;

GO