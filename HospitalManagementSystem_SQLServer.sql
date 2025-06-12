--create table for Hospital Patient &  Appointment Management System
create database HospitalSystem;

--Use the database
use HospitalSystem;

-- Create Patient Table
create table Patient (
	PatientID int identity(1,1) primary key,
	PatientName varchar(80),
	PatientEmail varchar(80),
	PatientAge int,
	Gender varchar(10),
	PatientPhone varchar(20)
);

-- creating Specialization table
create table Specialization (
	SpecializationID int primary key,
	SpecializationName varchar(50)
);

-- creating Doctors table
create table Doctors (
	DoctorID int primary key,
	DoctorName varchar(80),
	DoctorEmail varchar(80),
	SpecializationID int,
	DoctorPhone varchar(20),
	foreign key (SpecializationID) references Specialization(SpecializationID)
);

-- creating DoctorAvailability table
create table DoctorAvailability (
	DoctorID int,
	AvailabilityDay date,
	StartTime time,
	EndTime time,
	primary key (DoctorID, AvailabilityDay),
	foreign key (DoctorID) references Doctors(DoctorID)
);

-- create table for Appointments
create table Appointments (
	AppointmentID int identity(101,1) primary key,
	PatientID int,
	DoctorID int,
	AppointmentDate date,
	AppointmentTime time,
	Status varchar(50),
	unique(PatientID, DoctorID, AppointmentDate),
	foreign key (PatientID) references Patient(PatientID),
	foreign key (DoctorID) references Doctors(DoctorID)
);

-- create table for Pharmacy
create table Pharmacy (
	MedicineID int primary key,
	MedicineName varchar(60),
	UnitPrice int,
	AvailableStock int
);

-- create table for MedicinePurchased
create table MedicinePurchased (
	PurchasedID int primary key,
	AppointmentID int,
	PurchasedDate date,
	TotalAmount int,
	foreign key (AppointmentID) references Appointments(AppointmentID)
);

-- create table for Prescription
create table Prescription (
	AppointmentID int,
	MedicineID int,
	Dosage varchar(90),
	Quantity int,
	NumberOfDay int,
	Information varchar(80),
	primary key (AppointmentID, MedicineID),
	foreign key (AppointmentID) references Appointments(AppointmentID),
	foreign key (MedicineID) references Pharmacy(MedicineID)
);

-- creating table for PaymentMethod
create table PaymentMethod (
	PaymentMethodID int primary key,
	PaymentMethodName varchar(80)
);

-- creating table for MedicinePayment
create table MedicinePayment (
	PaymentID int primary key,
	PatientID int,
	PaymentMethodID int,
	PurchasedID int,
	foreign key (PatientID) references Patient(PatientID),
	foreign key (PaymentMethodID) references PaymentMethod(PaymentMethodID),
	foreign key (PurchasedID) references MedicinePurchased(PurchasedID)
);


--Patient
insert into Patient (PatientName, PatientEmail, PatientAge, Gender, PatientPhone) values
('Ravi Kumar', 'ravi@gmail.com', 30, 'Male', '9876543210'),
('Priya Sharma', 'priya@gmail.com', 27, 'Female', '9876501234');

--Specialization
insert into Specialization (SpecializationID, SpecializationName) values
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

select * from Patient;
select * from Specialization;
select * from Doctors;
select * from DoctorAvailability;
select * from Appointments;
select * from Pharmacy;
select * from MedicinePurchased;
select * from Prescription;
select * from PaymentMethod;
select * from MedicinePayment;

--2. List the names of patients who have appointments with more than two different doctors.
insert into Appointments values
(2, 101, '2025-06-08','09:00','12:00'),
(2, 103, '2025-07-09','10:00','11:00');

select * from Appointments;
select * from Patient;

select P.PatientName, Count(*) as Counts from Patient P
inner join Appointments A
on P.PatientID = A.PatientID
group by P.PatientName
having Count(*) > 2;


--3.	Retrieve doctor names and total number of appointments they have in the current month.
select d.DoctorName, Count(*) from Doctors d 
inner join Appointments a
on d.DoctorID = a.DoctorID
where datename(month, getdate()) = datename(month, a.AppointmentDate)
group by d.DoctorName;


--4. Create a view to show appointment details along with patient names and doctor specializations for today’s appointments.
insert into Appointments values
(1, 101, getdate(),'09:00','Confirmed'),
(2, 103, getdate(),'10:00','Pending');


select * from Appointments;
select * from Patient;

create view vw_AppointmentDetails
as
select a.AppointmentID, p.PatientName, d.DoctorName, s.SpecializationName, a.Status from Appointments a
inner join Patient p
on p.PatientID = a.PatientID
inner join Doctors d
on d.DoctorID = a.DoctorID
inner join Specialization s
on d.SpecializationID = s.SpecializationID
where a.AppointmentDate = '2025-06-11';

drop view vw_AppointmentDetails

select * from vw_AppointmentDetails;
select * from Appointments;

--5. Write a stored procedure to return all prescription details for a given patient ID.
select * from Prescription;

insert into Prescription (AppointmentID, MedicineID, Dosage, Quantity, NumberOfDay, Information) values
(105, 201, '240mg',3, 5, 'After Food');

create procedure sp_Prescription
	@PatientID int
as
begin
	create table #TempAppointment(
		AppointmentID int
	);
	insert into #TempAppointment
	select AppointmentID from Appointments where PatientID = @PatientID;

	select * from Prescription where AppointmentID  in (select * from #TempAppointment);
end;

exec sp_Prescription 1;

drop procedure sp_Prescription;

select * from Appointments;
select * from Prescription;
