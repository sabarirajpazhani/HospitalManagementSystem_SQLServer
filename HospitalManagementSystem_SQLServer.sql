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
	DoctorID int,
	DoctorName varchar(80),
	DoctorEmail varchar(80),
	SpecializationID int,
	DoctorPhone varchar(20),
	foreign key (SpecializationID) references Specialization(SpecializationID)
);
