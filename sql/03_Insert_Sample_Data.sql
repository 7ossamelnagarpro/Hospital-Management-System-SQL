USE HospitalManagementDB;
GO

/*==============================================================================
    Insert Data into Departments
==============================================================================*/

INSERT INTO Departments
(
    DepartmentName,
    DepartmentCode,
    Description
)
VALUES
('Cardiology', 'CARD', 'Heart diseases and treatments'),
('Neurology', 'NEUR', 'Brain and nervous system'),
('Orthopedics', 'ORTH', 'Bones and joints'),
('Pediatrics', 'PED', 'Children healthcare'),
('Emergency', 'EMR', 'Emergency medical services');
GO


INSERT INTO Doctors
(
    FirstName,
    LastName,
    Gender,
    DateOfBirth,
    Specialty,
    PhoneNumber,
    Email,
    HireDate,
    Salary,
    DepartmentID
)
VALUES
('Ahmed','Hassan','M','1980-05-10','Cardiologist','01010000001','ahmed@hospital.com','2015-03-01',25000,1),

('Mona','Ali','F','1985-09-15','Neurologist','01010000002','mona@hospital.com','2018-07-15',22000,2),

('Omar','Mahmoud','M','1978-02-20','Orthopedic Surgeon','01010000003','omar@hospital.com','2013-01-20',28000,3),

('Sara','Mostafa','F','1990-11-30','Pediatrician','01010000004','sara@hospital.com','2020-06-10',20000,4),

('Youssef','Khaled','M','1983-08-25','Emergency Physician','01010000005','youssef@hospital.com','2017-09-12',23000,5);
GO

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
('Mohamed','Adel','M','1995-03-15','A+','01111111111','mohamed@email.com','Cairo','01199999999'),

('Fatma','Ibrahim','F','1998-07-20','O+','01111111112','fatma@email.com','Giza','01188888888'),

('Ali','Sayed','M','1989-01-12','B+','01111111113','ali@email.com','Alexandria','01177777777'),

('Nour','Ahmed','F','2000-12-05','AB+','01111111114','nour@email.com','Mansoura','01166666666'),

('Karim','Hossam','M','1992-04-09','O-','01111111115','karim@email.com','Tanta','01155555555');
GO


/*==============================================================================
    Insert Data into Rooms
==============================================================================*/

INSERT INTO Rooms
(
    RoomNumber,
    RoomType,
    Capacity,
    FloorNumber,
    Status
)
VALUES
('R101','General',4,1,'Available'),
('R102','Private',1,1,'Available'),
('R201','ICU',1,2,'Occupied'),
('R202','General',3,2,'Available'),
('R301','Private',1,3,'Maintenance');
GO


/*==============================================================================
    Insert Data into Staff
==============================================================================*/

INSERT INTO Staff
(
    FirstName,
    LastName,
    JobTitle,
    PhoneNumber,
    Email,
    HireDate,
    Salary
)
VALUES
('Ahmed','Samir','Nurse','01230000001','ahmed.staff@hospital.com','2019-01-10',8000),

('Mariam','Adel','Nurse','01230000002','mariam.staff@hospital.com','2020-05-15',8500),

('Khaled','Mostafa','Receptionist','01230000003','khaled.staff@hospital.com','2021-03-20',6000),

('Nada','Hassan','Pharmacist','01230000004','nada.staff@hospital.com','2018-11-01',9000),

('Mahmoud','Ali','Administrator','01230000005','mahmoud.staff@hospital.com','2017-08-12',12000);
GO


/*==============================================================================
    Insert Data into Medicines
==============================================================================*/

INSERT INTO Medicines
(
    MedicineName,
    Manufacturer,
    UnitPrice,
    QuantityInStock,
    ExpiryDate
)
VALUES
('Aspirin','Bayer',50,200,'2027-01-01'),

('Paracetamol','Sanofi',30,300,'2026-08-15'),

('Amoxicillin','GSK',120,150,'2027-05-20'),

('Insulin','Novo Nordisk',500,50,'2026-12-31'),

('Vitamin D','Pfizer',80,250,'2027-03-10');
GO

/*==============================================================================
    Insert Data into RoomAssignments
==============================================================================*/

INSERT INTO RoomAssignments
(
    PatientID,
    RoomID,
    AdmissionDate,
    DischargeDate
)
VALUES
(1,3,'2026-07-20',NULL),

(2,1,'2026-07-21','2026-07-22'),

(3,2,'2026-07-22','2026-07-25'),

(4,4,'2026-07-23',NULL),

(5,5,'2026-07-24','2026-07-25');
GO

/*==============================================================================
    Insert Data into Appointments
==============================================================================*/

INSERT INTO Appointments
(
    PatientID,
    DoctorID,
    AppointmentDate,
    Status,
    Notes
)
VALUES
(1,1,'2026-07-20 10:00:00','Scheduled','Regular heart checkup'),

(2,2,'2026-07-21 11:30:00','Completed','Neurology consultation'),

(3,3,'2026-07-22 09:00:00','Scheduled','Bone examination'),

(4,4,'2026-07-23 14:00:00','Completed','Child health follow-up'),

(5,5,'2026-07-24 16:00:00','Cancelled','Patient cancelled appointment');
GO

/*==============================================================================
    Insert Data into MedicalRecords
==============================================================================*/

INSERT INTO MedicalRecords
(
    PatientID,
    DoctorID,
    Diagnosis,
    Treatment,
    RecordDate
)
VALUES
(1,1,
'High Blood Pressure',
'Medication and lifestyle changes',
'2026-07-20'),

(2,2,
'Migraine',
'Pain management treatment',
'2026-07-21'),

(3,3,
'Fracture Recovery',
'Physical therapy',
'2026-07-22'),

(4,4,
'Child Fever',
'Medication and observation',
'2026-07-23'),

(5,5,
'Emergency Check',
'Medical observation',
'2026-07-24');
GO

/*==============================================================================
    Insert Data into Prescriptions
==============================================================================*/

INSERT INTO Prescriptions
(
    RecordID,
    PrescriptionDate,
    Notes
)
VALUES
(1,'2026-07-20','Take medications regularly'),

(2,'2026-07-21','Avoid stress'),

(3,'2026-07-22','Continue physiotherapy'),

(4,'2026-07-23','Follow dosage instructions'),

(5,'2026-07-24','Emergency medication');
GO

/*==============================================================================
    Insert Data into PrescriptionItems
==============================================================================*/

INSERT INTO PrescriptionItems
(
    PrescriptionID,
    MedicineID,
    Dosage,
    DurationDays,
    Quantity
)
VALUES
(1,1,'One tablet daily',30,30),

(2,2,'Two tablets daily',10,20),

(3,3,'One capsule every 8 hours',7,21),

(4,5,'One tablet daily',20,20),

(5,4,'Injection once daily',5,5);
GO

/*==============================================================================
    Insert Data into Billing
==============================================================================*/

INSERT INTO Billing
(
    PatientID,
    Amount,
    PaymentStatus,
    PaymentDate
)
VALUES
(1,5000,'Pending',NULL),

(2,3500,'Paid','2026-07-22'),

(3,7000,'Paid','2026-07-25'),

(4,2000,'Pending',NULL),

(5,4500,'Cancelled',NULL);
GO

