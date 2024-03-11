--Create database
CREATE DATABASE HOSPITAL_Database_Project;
USE HOSPITAL_Database_Project;

-- =========== Create Tables =========== 

-- Patients Table
CREATE TABLE Patients (
    patient_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    patient_Address VARCHAR(100) NOT NULL,
    Contact_Number VARCHAR(20) NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    Date_Of_Birth DATE NOT NULL,
    Insurance_Information VARCHAR(500) NOT NULL
);
INSERT INTO Patients (First_Name, Last_Name, patient_Address, Contact_Number, Gender, Date_Of_Birth, Insurance_Information)
VALUES
    ('John', 'Doe', '123 Main St', '123-456-7890', 'Male', '1980-05-15', 'Company A'),
    ('Alice', 'Smith', '456 Oak Ave', '987-654-3210', 'Female', '1992-09-20', 'Company B'),
    ('Bob', 'Johnson', '789 Elm St', '111-222-3333', 'Male', '1975-03-10', 'Company C'),
    ('Emily', 'Brown', '321 Pine St', '555-123-4567', 'Female', '1988-11-28', 'Company D'),
    ('Daniel', 'Miller', '222 Maple Ave', '444-555-6666', 'Male', '1995-07-18', 'Company E'),
    ('Sophia', 'Wilson', '888 Cedar St', '777-888-9999', 'Female', '2000-01-05', 'Company F'),
    ('Grace', 'Garcia', '777 Birch St', '333-999-8888', 'Female', '1970-12-31', 'Company G'),
    ('William', 'Lee', '555 Walnut St', '222-111-4444', 'Male', '1984-04-22', 'Company H'),
    ('Olivia', 'Nguyen', '999 Spruce St', '666-333-2222', 'Female', '1998-06-12', 'Company I');
-- =================================================================================================

-- Healthcare Providers Table
CREATE TABLE Healthcare_Providers (
    Provider_ID INT PRIMARY KEY AUTO_INCREMENT,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Specialization VARCHAR(50) NOT NULL,
    Contact_Number VARCHAR(20) NOT NULL,
    Salary DECIMAL(10,2) NOT NULL 
);
INSERT INTO Healthcare_Providers (First_Name, Last_Name, Specialization, Contact_Number, Salary)
VALUES
    ('Michael', 'Jones', 'Cardiology', '123-456-7890', 6500.00),
    ('Sarah', 'Anderson', 'Pediatrics', '987-654-3210', 7200.00),
    ('David', 'Williams', 'Orthopedics', '111-222-3333', 8000.00),
    ('Laura', 'Garcia', 'Dermatology', '555-123-4567', 6800.00),
    ('Emma', 'Thomas', 'Neurology', '444-555-6666', 6900.00),
    ('Andrew', 'White', 'Ophthalmology', '777-888-9999', 7100.00),
    ('Ella', 'Hernandez', 'Psychiatry', '333-999-8888', 7300.00),
    ('James', 'Martinez', 'Endocrinology', '222-111-4444', 7000.00),
    ('Ava', 'Robinson', 'Urology', '666-333-2222', 7400.00);
-- =================================================================================================

-- Medical Records Table 
CREATE TABLE Medical_Records (
    Record_ID INT PRIMARY KEY AUTO_INCREMENT, 
    Diagnosis VARCHAR(255) NOT NULL,
    Treatment VARCHAR(100) NOT NULL,
    Admission_Date DATE NOT NULL,
    Discharge_Date DATE NOT NULL,
    Patient_ID INT,
    CONSTRAINT FK_Patient_MedicalRecords FOREIGN KEY (Patient_ID) REFERENCES Patients(patient_ID)
);
INSERT INTO Medical_Records (Diagnosis, Treatment, Admission_Date, Discharge_Date, Patient_ID)
VALUES
    ('Fever', 'Antibiotics', '2022-10-05', '2022-10-10', 1),
    ('Fractured arm', 'Splint and rest', '2022-09-15', '2022-09-30', 3),
    ('Headache', 'Rest and hydration', '2022-11-01', '2022-11-03', 5),
    ('Allergic reaction', 'Epinephrine', '2022-08-20', '2022-08-22', 7),
    ('Diabetes', 'Insulin therapy', '2022-07-10', '2022-07-25', 9);
-- =================================================================================================

-- Appointments Table
CREATE TABLE Appointments (
    Appointment_ID INT PRIMARY KEY AUTO_INCREMENT,
    Appointment_Date DATE NOT NULL,
    Purpose VARCHAR(100) NOT NULL,
    App_Status VARCHAR(50) NOT NULL,
    Patient_ID INT,
    Provider_ID INT,
    CONSTRAINT FK_Patient_Appointments FOREIGN KEY (Patient_ID) REFERENCES Patients(patient_ID),
    CONSTRAINT FK_Provider_Appointments FOREIGN KEY (Provider_ID) REFERENCES Healthcare_Providers(Provider_ID)
);
INSERT INTO Appointments (Appointment_Date, Purpose, App_Status, Patient_ID, Provider_ID)
VALUES
    ('2022-12-05', 'Follow-up checkup', 'Scheduled', 1, 1),
    ('2022-12-08', 'Annual physical', 'Confirmed', 2, 2),
    ('2022-12-10', 'Consultation', 'Scheduled', 3, 3),
    ('2022-12-15', 'Treatment review', 'Confirmed', 5, 5),
    ('2022-12-20', 'Checkup', 'Scheduled', 7, 7);
-- =================================================================================================

-- Prescriptions Table
CREATE TABLE Prescriptions (
    Prescription_ID INT PRIMARY KEY AUTO_INCREMENT,
    Medication_Name VARCHAR(100) NOT NULL,
    Dosage VARCHAR(50) NOT NULL
);
INSERT INTO Prescriptions (Medication_Name, Dosage)
VALUES
    ('Aspirin', '100mg'),
    ('Ibuprofen', '200mg'),
    ('Amoxicillin', '500mg'),
    ('Lisinopril', '10mg'),
    ('Metformin', '850mg');
-- =================================================================================================

-- Medications Table 
CREATE TABLE Medications (
    Medication_ID INT PRIMARY KEY AUTO_INCREMENT,
    Medication_Name VARCHAR(100) NOT NULL
);
INSERT INTO Medications (Medication_Name)
VALUES
    ('Aspirin'),
    ('Ibuprofen'),
    ('Amoxicillin'),
    ('Lisinopril'),
    ('Metformin');
-- =================================================================================================

-- Prescriptions_Medications
CREATE TABLE Prescriptions_Medications (
    Prescription_ID INT,
    Medication_ID INT,
    PRIMARY KEY (Prescription_ID, Medication_ID),
    CONSTRAINT FK_Prescription FOREIGN KEY (Prescription_ID) REFERENCES Prescriptions(Prescription_ID),
    CONSTRAINT FK_Medication FOREIGN KEY (Medication_ID) REFERENCES Medications(Medication_ID)
);
INSERT INTO Prescriptions_Medications (Prescription_ID, Medication_ID)
VALUES
    (1, 1), 
    (2, 2), 
    (3, 3), 
    (4, 4), 
    (5, 5); 
-- =================================================================================================

-- Billing Table
CREATE TABLE Billing (
    Billing_ID INT PRIMARY KEY AUTO_INCREMENT,
    Bill_Date DATE NOT NULL,
    Service_Description VARCHAR(100) NOT NULL,
    Amount DECIMAL(10,2) NOT NULL, 
    Payment_Status VARCHAR(100) NOT NULL,
    Patient_ID INT,
    CONSTRAINT FK_Patient_Billing FOREIGN KEY (Patient_ID) REFERENCES Patients(patient_ID)
);
INSERT INTO Billing (Bill_Date, Service_Description, Amount, Payment_Status, Patient_ID)
VALUES
    ('2022-11-01', 'Consultation fee', 150.00, 'Paid', 1),
    ('2022-11-15', 'X-ray', 200.00, 'Pending', 3),
    ('2022-12-01', 'Lab tests', 120.00, 'Paid', 5),
    ('2022-12-20', 'Medication', 80.00, 'Pending', 7);
-- =================================================================================================

-- Laboratory Results Table 
CREATE TABLE Laboratory_Results (
    Result_ID INT PRIMARY KEY AUTO_INCREMENT, 
    Test_Name VARCHAR(50) NOT NULL,
    Result VARCHAR(50) NOT NULL,
    Patient_ID INT,
    CONSTRAINT FK_Patient_LaboratoryResults FOREIGN KEY (Patient_ID) REFERENCES Patients(patient_ID)
);
INSERT INTO Laboratory_Results (Test_Name, Result, Patient_ID)
VALUES
    ('Blood test', 'Normal', 1),
    ('X-ray', 'Fracture detected', 3),
    ('MRI', 'No abnormalities', 5),
    ('Ultrasound', 'Clear', 7);
-- =================================================================================================
SELECT * 
FROM Patients;

SELECT * 
FROM Healthcare_Providers;

SELECT * 
FROM Medical_Records;

SELECT * 
FROM Appointments;

SELECT * 
FROM Prescriptions;

SELECT * 
FROM Medications;

SELECT * 
FROM Prescriptions_Medications;

SELECT * 
FROM Billing;

SELECT * 
FROM Laboratory_Results;
