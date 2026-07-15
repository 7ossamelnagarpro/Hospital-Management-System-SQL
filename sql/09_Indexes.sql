/*
===============================================================================
 Project      : Hospital Management System
 File         : 09_Indexes.sql
 Author       : Hossam Elnagar

 Description:
 Creating indexes to improve database performance.

===============================================================================
*/

USE HospitalManagementDB;
GO



/*==============================================================================
 Index 1:
 Improve Patient Search By Phone Number
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Patients_PhoneNumber

ON Patients(PhoneNumber);

GO



/*==============================================================================
 Index 2:
 Improve Patient Search By Name
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Patients_Name

ON Patients
(
    FirstName,
    LastName
);

GO



/*==============================================================================
 Index 3:
 Improve Doctor Department Filtering
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Doctors_DepartmentID

ON Doctors(DepartmentID);

GO



/*==============================================================================
 Index 4:
 Improve Appointment Search By Date
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Appointments_Date

ON Appointments(AppointmentDate);

GO



/*==============================================================================
 Index 5:
 Improve Appointment Search By Patient
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Appointments_PatientID

ON Appointments(PatientID);

GO



/*==============================================================================
 Index 6:
 Improve Medical Records Search
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_MedicalRecords_PatientID

ON MedicalRecords(PatientID);

GO



/*==============================================================================
 Index 7:
 Improve Prescription Lookup
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Prescriptions_RecordID

ON Prescriptions(RecordID);

GO



/*==============================================================================
 Index 8:
 Improve Medicine Stock Monitoring
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Medicines_Stock

ON Medicines(QuantityInStock);

GO



/*==============================================================================
 Index 9:
 Improve Billing Reports
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_Billing_PatientID

ON Billing(PatientID);

GO



/*==============================================================================
 Index 10:
 Improve Room Assignment Search
==============================================================================*/

CREATE NONCLUSTERED INDEX IX_RoomAssignments_PatientID

ON RoomAssignments(PatientID);

GO



/*==============================================================================
 Check Created Indexes
==============================================================================*/

SELECT

    OBJECT_NAME(object_id) AS TableName,

    name AS IndexName

FROM sys.indexes

WHERE name IS NOT NULL

ORDER BY TableName;

GO