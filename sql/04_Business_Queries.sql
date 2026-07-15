/*
===============================================================================
 Project      : Hospital Management System
 File         : 04_Business_Queries.sql
 Author       : Hossam Elnagar

 Description:
 Business Analysis Queries for Hospital Reporting

===============================================================================
*/

USE HospitalManagementDB;
GO


/*==============================================================================
 Query 1:
 Display all registered patients
==============================================================================*/

SELECT
    PatientID,
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    BloodType,
    PhoneNumber
FROM Patients;

GO



/*==============================================================================
 Query 2:
 Display doctors with their departments
==============================================================================*/

SELECT
    D.DoctorID,
    D.FirstName + ' ' + D.LastName AS DoctorName,
    D.Specialty,
    DP.DepartmentName
FROM Doctors D
INNER JOIN Departments DP
ON D.DepartmentID = DP.DepartmentID;

GO



/*==============================================================================
 Query 3:
 Count doctors in each department
==============================================================================*/

SELECT
    DP.DepartmentName,
    COUNT(D.DoctorID) AS NumberOfDoctors
FROM Departments DP
LEFT JOIN Doctors D
ON DP.DepartmentID = D.DepartmentID
GROUP BY DP.DepartmentName;

GO



/*==============================================================================
 Query 4:
 Display all appointments with patient and doctor information
==============================================================================*/

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

GO



/*==============================================================================
 Query 5:
 Count appointments for each doctor
==============================================================================*/

SELECT
    D.FirstName + ' ' + D.LastName AS DoctorName,

    COUNT(A.AppointmentID) AS TotalAppointments

FROM Doctors D

LEFT JOIN Appointments A
ON D.DoctorID = A.DoctorID

GROUP BY
    D.FirstName,
    D.LastName

ORDER BY TotalAppointments DESC;

GO



/*==============================================================================
 Query 6:
 Display current admitted patients
==============================================================================*/

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
 Query 7:
 Calculate total hospital revenue
==============================================================================*/

SELECT
    SUM(Amount) AS TotalRevenue

FROM Billing

WHERE PaymentStatus = 'Paid';

GO



/*==============================================================================
 Query 8:
 Revenue analysis by payment status
==============================================================================*/

SELECT

    PaymentStatus,

    COUNT(BillID) AS NumberOfBills,

    SUM(Amount) AS TotalAmount

FROM Billing

GROUP BY PaymentStatus;

GO



/*==============================================================================
 Query 9:
 Find low stock medicines
==============================================================================*/

SELECT

    MedicineID,

    MedicineName,

    QuantityInStock

FROM Medicines

WHERE QuantityInStock < 100;

GO



/*==============================================================================
 Query 10:
 Find departments with highest patient records
==============================================================================*/

SELECT

    DP.DepartmentName,

    COUNT(MR.RecordID) AS TotalPatients

FROM Departments DP

INNER JOIN Doctors D
ON DP.DepartmentID = D.DepartmentID

INNER JOIN MedicalRecords MR
ON D.DoctorID = MR.DoctorID

GROUP BY DP.DepartmentName

ORDER BY TotalPatients DESC;

GO



/*==============================================================================
 Query 11:
 Display completed appointments only
==============================================================================*/

SELECT

    AppointmentID,

    PatientID,

    DoctorID,

    AppointmentDate

FROM Appointments

WHERE Status = 'Completed';

GO



/*==============================================================================
 Query 12:
 Find doctors with salary above average
==============================================================================*/

SELECT

    DoctorID,

    FirstName,

    LastName,

    Salary

FROM Doctors

WHERE Salary >
(
    SELECT AVG(Salary)
    FROM Doctors
);

GO



/*==============================================================================
 Query 13:
 Display patients with their medical history
==============================================================================*/

SELECT

    P.FirstName + ' ' + P.LastName AS PatientName,

    MR.Diagnosis,

    MR.Treatment,

    MR.RecordDate

FROM Patients P

INNER JOIN MedicalRecords MR

ON P.PatientID = MR.PatientID;

GO



/*==============================================================================
 Query 14:
 Display prescriptions with medicine details
==============================================================================*/

SELECT

    P.PrescriptionID,

    M.MedicineName,

    PI.Dosage,

    PI.DurationDays,

    PI.Quantity

FROM PrescriptionItems PI

INNER JOIN Prescriptions P

ON PI.PrescriptionID = P.PrescriptionID

INNER JOIN Medicines M

ON PI.MedicineID = M.MedicineID;

GO



/*==============================================================================
 Query 15:
 Find most expensive medicine
==============================================================================*/

SELECT TOP 1

    MedicineName,

    UnitPrice

FROM Medicines

ORDER BY UnitPrice DESC;

GO



/*==============================================================================
 Query 16:
 Count patients by blood type
==============================================================================*/

SELECT

    BloodType,

    COUNT(PatientID) AS NumberOfPatients

FROM Patients

GROUP BY BloodType;

GO



/*==============================================================================
 Query 17:
 Display unpaid bills
==============================================================================*/

SELECT

    BillID,

    PatientID,

    Amount,

    PaymentStatus

FROM Billing

WHERE PaymentStatus = 'Pending';

GO



/*==============================================================================
 Query 18:
 Average doctor salary by department
==============================================================================*/

SELECT

    DP.DepartmentName,

    AVG(D.Salary) AS AverageSalary

FROM Departments DP

INNER JOIN Doctors D

ON DP.DepartmentID = D.DepartmentID

GROUP BY DP.DepartmentName;

GO



/*==============================================================================
 Query 19:
 Number of patients assigned to each room
==============================================================================*/

SELECT

    R.RoomNumber,

    R.RoomType,

    COUNT(RA.PatientID) AS NumberOfPatients

FROM Rooms R

LEFT JOIN RoomAssignments RA

ON R.RoomID = RA.RoomID

GROUP BY

    R.RoomNumber,

    R.RoomType;

GO



/*==============================================================================
 Query 20:
 Monthly appointment analysis
==============================================================================*/

SELECT

    MONTH(AppointmentDate) AS AppointmentMonth,

    COUNT(AppointmentID) AS TotalAppointments

FROM Appointments

GROUP BY MONTH(AppointmentDate)

ORDER BY AppointmentMonth;

GO