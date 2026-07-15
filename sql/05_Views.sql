/*
===============================================================================
 Project      : Hospital Management System
 File         : 05_Views.sql
 Author       : Hossam Elnagar

 Description:
 Creating database views for reporting and analytics.

===============================================================================
*/

USE HospitalManagementDB;
GO



/*==============================================================================
 View 1:
 Patient Basic Information
==============================================================================*/

CREATE VIEW vw_PatientInformation
AS

SELECT

    PatientID,

    FirstName + ' ' + LastName AS PatientName,

    Gender,

    DateOfBirth,

    BloodType,

    PhoneNumber,

    Email

FROM Patients;

GO



/*==============================================================================
 View 2:
 Doctors with Departments
==============================================================================*/

CREATE VIEW vw_DoctorDepartment
AS

SELECT

    D.DoctorID,

    D.FirstName + ' ' + D.LastName AS DoctorName,

    D.Specialty,

    DP.DepartmentName,

    D.Salary

FROM Doctors D

INNER JOIN Departments DP

ON D.DepartmentID = DP.DepartmentID;

GO



/*==============================================================================
 View 3:
 Appointment Details Report
==============================================================================*/

CREATE VIEW vw_AppointmentDetails
AS

SELECT

    A.AppointmentID,

    P.FirstName + ' ' + P.LastName AS PatientName,

    D.FirstName + ' ' + D.LastName AS DoctorName,

    DP.DepartmentName,

    A.AppointmentDate,

    A.Status

FROM Appointments A

INNER JOIN Patients P

ON A.PatientID = P.PatientID


INNER JOIN Doctors D

ON A.DoctorID = D.DoctorID


INNER JOIN Departments DP

ON D.DepartmentID = DP.DepartmentID;

GO



/*==============================================================================
 View 4:
 Current Hospital Admissions
==============================================================================*/

CREATE VIEW vw_CurrentAdmissions
AS

SELECT

    P.FirstName + ' ' + P.LastName AS PatientName,

    R.RoomNumber,

    R.RoomType,

    RA.AdmissionDate

FROM RoomAssignments RA


INNER JOIN Patients P

ON RA.PatientID = P.PatientID


INNER JOIN Rooms R

ON RA.RoomID = R.RoomID


WHERE RA.DischargeDate IS NULL;

GO



/*==============================================================================
 View 5:
 Patient Medical History
==============================================================================*/

CREATE VIEW vw_PatientMedicalHistory
AS

SELECT

    P.PatientID,

    P.FirstName + ' ' + P.LastName AS PatientName,

    MR.Diagnosis,

    MR.Treatment,

    MR.RecordDate

FROM Patients P


INNER JOIN MedicalRecords MR

ON P.PatientID = MR.PatientID;

GO



/*==============================================================================
 View 6:
 Prescription Details
==============================================================================*/

CREATE VIEW vw_PrescriptionDetails
AS

SELECT

    PR.PrescriptionID,

    P.FirstName + ' ' + P.LastName AS PatientName,

    M.MedicineName,

    PI.Dosage,

    PI.DurationDays,

    PI.Quantity

FROM PrescriptionItems PI


INNER JOIN Prescriptions PR

ON PI.PrescriptionID = PR.PrescriptionID


INNER JOIN MedicalRecords MR

ON PR.RecordID = MR.RecordID


INNER JOIN Patients P

ON MR.PatientID = P.PatientID


INNER JOIN Medicines M

ON PI.MedicineID = M.MedicineID;

GO



/*==============================================================================
 View 7:
 Billing Report
==============================================================================*/

CREATE VIEW vw_BillingReport
AS

SELECT

    B.BillID,

    P.FirstName + ' ' + P.LastName AS PatientName,

    B.Amount,

    B.PaymentStatus,

    B.PaymentDate

FROM Billing B


INNER JOIN Patients P

ON B.PatientID = P.PatientID;

GO



/*==============================================================================
 View 8:
 Department Performance Report
==============================================================================*/

CREATE VIEW vw_DepartmentPerformance
AS

SELECT

    DP.DepartmentName,

    COUNT(MR.RecordID) AS TotalMedicalRecords

FROM Departments DP


INNER JOIN Doctors D

ON DP.DepartmentID = D.DepartmentID


INNER JOIN MedicalRecords MR

ON D.DoctorID = MR.DoctorID


GROUP BY DP.DepartmentName;

GO



/*==============================================================================
 View Testing
==============================================================================*/

SELECT * FROM vw_PatientInformation;

SELECT * FROM vw_DoctorDepartment;

SELECT * FROM vw_AppointmentDetails;

SELECT * FROM vw_CurrentAdmissions;

SELECT * FROM vw_PatientMedicalHistory;

SELECT * FROM vw_PrescriptionDetails;

SELECT * FROM vw_BillingReport;

SELECT * FROM vw_DepartmentPerformance;

GO