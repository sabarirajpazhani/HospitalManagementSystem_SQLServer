# ER Diagram for Hospital Patient & Appointment Management System

![Untitled (1)](https://github.com/user-attachments/assets/b8f3542d-e6a7-44cc-b371-eee6735353dd)


# 🧠 SQL Practice – Q&A Format

### ❓ Question 2:

**List the names of patients who have appointments with more than two different doctors.**


## ✅ Answer:

```sql
INSERT INTO Appointments VALUES
(2, 101, '2025-06-08', '09:00', '12:00'),
(2, 103, '2025-07-09', '10:00', '11:00');
```

![image](https://github.com/user-attachments/assets/bc5afef8-290b-4942-af66-4914e4059cc4)

### ❓ Question 3:

**Retrieve doctor names and total number of appointments they have in the current month.**


## ✅ Answer:

```sql
select d.DoctorName, Count(*) from Doctors d 
inner join Appointments a
on d.DoctorID = a.DoctorID
group by d.DoctorName;
```
![image](https://github.com/user-attachments/assets/ecad32cc-e060-4f73-abc7-bc0df7e95ef8)

### ❓ Question 4:

**Create a view to show appointment details along with patient names and doctor specializations for today’s appointments.**


## ✅ Answer:

```sql
create view vw_AppointmentDetails
as
select a.AppointmentID, p.PatientName, d.DoctorName, a.Status from Appointments a
inner join Patient p
on p.PatientID = a.PatientID
inner join Doctors d
on d.DoctorID = a.DoctorID

select * from vw_AppointmentDetails;
```
![image](https://github.com/user-attachments/assets/2fae953e-d177-4e79-bd26-4fb1342e3ed3)
