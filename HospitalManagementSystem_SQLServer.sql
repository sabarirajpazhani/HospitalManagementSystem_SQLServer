--create table for Hospital Patient &  Appointment Management System
create database HospitalSystem;

--Use the database
use HospitalSystem;

-- Create Patient Table
CREATE TABLE Patient (
	PatientID INT IDENTITY(1,1) PRIMARY KEY,
	PatientName VARCHAR(80),
	PatientEmail VARCHAR(80),
	PatientAge INT,
	Gender VARCHAR(10),
	PatientPhone VARCHAR(20)
);

-- Creating Specialization Table
CREATE TABLE Specialization (
	SpecializationID INT PRIMARY KEY,
	SpeicalizationName VARCHAR(50)
);

-- Creating Doctors Table
CREATE TABLE Doctors (
	DoctorID INT PRIMARY KEY,
	DoctorName VARCHAR(80),
	DoctorEmail VARCHAR(80),
	SpecializationID INT,
	DoctorPhone VARCHAR(20),
	FOREIGN KEY (SpecializationID) REFERENCES Specialization(SpecializationID)
);

-- Creating Doctor Availability
CREATE TABLE DoctorAvailability (
	DoctorID INT,
	AvailabilityDay DATE,
	StartTime TIME,
	EndTime TIME,
	PRIMARY KEY (DoctorID, AvailabilityDay),
	FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Table for Appointment
CREATE TABLE Appointments (
	AppointmentID INT IDENTITY(101,1) PRIMARY KEY, -- Unique appointment ID
	PatientID INT,
	DoctorID INT,
	AppointmentDate DATE,
	AppointmentTime TIME,
	Status VARCHAR(50),
	UNIQUE(PatientID, DoctorID, AppointmentDate), -- Composite uniqueness
	FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
	FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Create Table for Pharmacy
CREATE TABLE Pharmacy (
	MedicineID INT PRIMARY KEY,
	MedicineName VARCHAR(60),
	UnitPrice INT,
	AvailableStock INT
);

-- Create Table for MedicinePurchased
CREATE TABLE MedicinePurchased (
	PurchasedID INT PRIMARY KEY,
	AppointmentID INT,
	PurchasedDate DATE,
	TotalAmount INT,
	FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);

-- Create Table for Prescription
CREATE TABLE Prescription (
	AppointmentID INT,
	MedicineID INT,
	Dosage VARCHAR(90),
	Quantity INT,
	NumberOfDay INT,
	Information VARCHAR(80),
	PRIMARY KEY (AppointmentID, MedicineID),
	FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
	FOREIGN KEY (MedicineID) REFERENCES Pharmacy(MedicineID)
);

-- Creating Table for PaymentMethod
CREATE TABLE PaymentMethod (
	PaymentMethodID INT PRIMARY KEY,
	PaymentMethodName VARCHAR(80)
);

-- Creating Table for MedicinePayment
CREATE TABLE MedicinePayment (
	PaymentID INT PRIMARY KEY,
	PatientID INT,
	PaymentMethodID INT,
	PurchasedID INT,
	FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
	FOREIGN KEY (PaymentMethodID) REFERENCES PaymentMethod(PaymentMethodID),
	FOREIGN KEY (PurchasedID) REFERENCES MedicinePurchased(PurchasedID)
);


SELECT * FROM Patient;
SELECT * FROM Specialization;
SELECT * FROM Doctors;
SELECT * FROM DoctorAvailability;
SELECT * FROM Appointments;
SELECT * FROM Pharmacy;
SELECT * FROM MedicinePurchased;
SELECT * FROM Prescription;
SELECT * FROM PaymentMethod;
SELECT * FROM MedicinePayment;

--Patient
insert into Patient (PatientName, PatientEmail, PatientAge, Gender, PatientPhone) values
('Ravi Kumar', 'ravi@gmail.com', 30, 'Male', '9876543210'),
('Priya Sharma', 'priya@gmail.com', 27, 'Female', '9876501234');

--Specialization
insert into Specialization (SpecializationID, SpeicalizationName) values
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Dermatology');

--Doctor
insert into Doctors (DoctorID, DoctorName, DoctorEmail, SpecializationID, DoctorPhone) values
(101, 'Dr. Rajesh', 'rajesh@hospital.com', 1, '9876567890'),
(102, 'Dr. Neha', 'neha@hospital.com', 2, '9876598765'),
(103, 'Dr. Aman', 'aman@hospital.com', 3, '9876544444');

--DoctorAvailability
insert into DoctorAvailability (DoctorID, AvailabilityDay, StartTime, EndTime) values
(101, '2025-06-15', '09:00', '12:00'),
(102, '2025-06-16', '10:00', '13:00'),
(103, '2025-06-17', '11:00', '14:00');

--Appointments
insert into Appointments (PatientID, DoctorID, AppointmentDate, AppointmentTime, Status) values
(1, 101, '2025-06-15', '09:30', 'Confirmed'),
(2, 102, '2025-06-16', '10:30', 'Pending');

--Pharmacy
insert into Pharmacy (MedicineID, MedicineName, UnitPrice, AvailableStock) values
(201, 'Paracetamol', 10, 500),
(202, 'Ibuprofen', 15, 300),
(203, 'Amoxicillin', 20, 200);

--MedicinePurchased
insert into MedicinePurchased (PurchasedID, AppointmentID, PurchasedDate, TotalAmount) values
(301, 101, '2025-06-15', 150),
(302, 102, '2025-06-16', 200);

--Prescription
insert into Prescription (AppointmentID, MedicineID, Dosage, Quantity, NumberOfDay, Information) values
(101, 201, '500mg', 10, 5, 'Take after food'),
(101, 202, '400mg', 5, 3, 'Twice a day'),
(102, 203, '250mg', 7, 7, 'Before food');

--PaymentMethod
insert into PaymentMethod (PaymentMethodID, PaymentMethodName) values
(1, 'Cash'),
(2, 'Credit Card'),
(3, 'UPI');

--MedicinePayment
insert into MedicinePayment (PaymentID, PatientID, PaymentMethodID, PurchasedID) values
(401, 1, 2, 301),
(402, 2, 3, 302);
