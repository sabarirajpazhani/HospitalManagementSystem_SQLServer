--create table for Hospital Patient &  Appointment Management System
create database HospitalSystem;

--Use the database
use HospitalSystem;

--Create Patient Table
create table Patient(
	PatientID int identity(1,1) primary key,
	PatientName varchar(80),
	PatientEmail varchar(80),
	PatientAge int,
	Gender varchar(10),
	PatientPhone varchar(20)
);

--creating Specialization Table
create table Specialization(
	SpecializationID int primary key,
	SpeicalizationName varchar(50)
);

--creating Doctors Table
create table Doctors(
	DoctorID int primary key,
	DoctorName varchar(80),
	DoctorEmail varchar(80),
	SpecializationID int,
	DoctorPhone varchar(20),
	foreign key (SpecializationID) references Specialization(SpecializationID)
);

--Creating Doctor Availablity
create table DoctorAvailability(
	DoctorID int,
	AvailabilityDay Date,
	StartTime Time,
	EndTime Time,
	primary key (DoctorID, AvailabilityDay),
	foreign key (DoctorID) references Doctors(DoctorID)
);

--Create table for Appointment
CREATE TABLE Appointments (
    AppointmentID INT IDENTITY(101,1) unique,         -- Unique appointment ID
    PatientID INT,
    DoctorID INT,
    AppointmentDate DATE,
    AppointmentTime TIME,
    Status VARCHAR(50),
    PRIMARY KEY (PatientID, DoctorID, AppointmentID), -- 👈 Composite Key
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

--create table for Pharmacy
create table Pharmacy(
	MedicineID int Primary Key,
	MedicineName varchar(60),
	UnitPrice int,
	AvailableStock int
);

--create table for MedicinePurchased
create table MedicinePurchased(
	PurchasedID int primary key,
	AppointmentID int,
	PurchasedDate date,
	TotalAmount int,
	foreign key (AppointmentID) references Appointments(AppointmentID)

);
--Create table for Prescription
create table Precription(
	AppointmentID int,
	MedicineID int,
	Dosage varchar(90),
	Quantity int,
	NumberOfDay int,
	Information varchar,
	primary key(AppointmentID, MedicineID),
	foreign key (AppointmentID) references Appointments(AppointmentID),
	foreign key (MedicineID) references Pharmacy(MedicineID)
);

--creating table for PaymentMethod
create table PaymentMethod(
	PaymentMethodID int primary key,
	PaymentMethodName varchar(80)
);

--creating table for MedicinePayment
create table MedicinePayment(
	PaymentID int primary key,
	PatientID int,
	PaymentMethodID int,
	PurchasedID int,
	foreign key (PatientID) references Patient(PatientID),
	foreign key (PaymentMethodID) references PaymentMethod(PaymentMethodID),
	foreign key (PurchasedID) references MedicinePurchased(PurchasedID)

);
