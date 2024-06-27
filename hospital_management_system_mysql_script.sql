-- Create database if not exists
CREATE DATABASE IF NOT EXISTS HospitalManagementDB;

-- Use the database
USE HospitalManagementDB;

-- Patients Table
CREATE TABLE IF NOT EXISTS Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each patient
    patient_name VARCHAR(100) NOT NULL, -- Patient's name
    gender ENUM('Male', 'Female', 'Other') NOT NULL, -- Patient's gender
    date_of_birth DATE NOT NULL, -- Patient's date of birth
    address TEXT, -- Patient's address
    phone VARCHAR(20), -- Patient's phone number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the patient record was created
);

-- Doctors Table
CREATE TABLE IF NOT EXISTS Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each doctor
    doctor_name VARCHAR(100) NOT NULL, -- Doctor's name
    specialization VARCHAR(255), -- Doctor's specialization
    phone VARCHAR(20), -- Doctor's phone number
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP -- Timestamp for when the doctor record was created
);

-- Appointments Table
CREATE TABLE IF NOT EXISTS Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY, -- Unique identifier for each appointment
    patient_id INT, -- Patient who has the appointment
    doctor_id INT, -- Doctor who will see the patient
    appointment_date DATE NOT NULL, -- Date of the appointment
    appointment_time TIME NOT NULL, -- Time of the appointment
    appointment_purpose TEXT, -- Purpose of the appointment
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Timestamp for when the appointment was scheduled
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id) ON DELETE CASCADE, -- Linking appointments to patients
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id) ON DELETE CASCADE -- Linking appointments to doctors
);

-- Procedures for CRUD operations

-- Procedure to insert patient
DELIMITER //

CREATE PROCEDURE InsertPatient(
    IN p_name VARCHAR(100), -- Input parameter: patient name
    IN p_gender ENUM('Male', 'Female', 'Other'), -- Input parameter: patient gender
    IN p_date_of_birth DATE, -- Input parameter: patient date of birth
    IN p_address TEXT, -- Input parameter: patient address
    IN p_phone VARCHAR(20) -- Input parameter: patient phone number
)
BEGIN
    INSERT INTO Patients (patient_name, gender, date_of_birth, address, phone)
    VALUES (p_name, p_gender, p_date_of_birth, p_address, p_phone);
END //

DELIMITER ;

-- Procedure to select patient by id
DELIMITER //

CREATE PROCEDURE SelectPatientById(
    IN p_patient_id INT -- Input parameter: patient id
)
BEGIN
    SELECT * FROM Patients WHERE patient_id = p_patient_id;
END //

DELIMITER ;

-- Procedure to update patient
DELIMITER //

CREATE PROCEDURE UpdatePatient(
    IN p_patient_id INT, -- Input parameter: patient id to update
    IN p_name VARCHAR(100), -- Input parameter: new patient name
    IN p_gender ENUM('Male', 'Female', 'Other'), -- Input parameter: new patient gender
    IN p_date_of_birth DATE, -- Input parameter: new patient date of birth
    IN p_address TEXT, -- Input parameter: new patient address
    IN p_phone VARCHAR(20) -- Input parameter: new patient phone number
)
BEGIN
    UPDATE Patients
    SET patient_name = p_name,
        gender = p_gender,
        date_of_birth = p_date_of_birth,
        address = p_address,
        phone = p_phone
    WHERE patient_id = p_patient_id;
END //

DELIMITER ;

-- Procedure to delete patient
DELIMITER //

CREATE PROCEDURE DeletePatient(
    IN p_patient_id INT -- Input parameter: patient id to delete
)
BEGIN
    DELETE FROM Patients WHERE patient_id = p_patient_id;
END //

DELIMITER ;

-- Procedure to insert doctor
DELIMITER //

CREATE PROCEDURE InsertDoctor(
    IN p_name VARCHAR(100), -- Input parameter: doctor name
    IN p_specialization VARCHAR(255), -- Input parameter: doctor specialization
    IN p_phone VARCHAR(20) -- Input parameter: doctor phone number
)
BEGIN
    INSERT INTO Doctors (doctor_name, specialization, phone)
    VALUES (p_name, p_specialization, p_phone);
END //

DELIMITER ;

-- Procedure to select doctor by id
DELIMITER //

CREATE PROCEDURE SelectDoctorById(
    IN p_doctor_id INT -- Input parameter: doctor id
)
BEGIN
    SELECT * FROM Doctors WHERE doctor_id = p_doctor_id;
END //

DELIMITER ;

-- Procedure to update doctor
DELIMITER //

CREATE PROCEDURE UpdateDoctor(
    IN p_doctor_id INT, -- Input parameter: doctor id to update
    IN p_name VARCHAR(100), -- Input parameter: new doctor name
    IN p_specialization VARCHAR(255), -- Input parameter: new doctor specialization
    IN p_phone VARCHAR(20) -- Input parameter: new doctor phone number
)
BEGIN
    UPDATE Doctors
    SET doctor_name = p_name,
        specialization = p_specialization,
        phone = p_phone
    WHERE doctor_id = p_doctor_id;
END //

DELIMITER ;

-- Procedure to delete doctor
DELIMITER //

CREATE PROCEDURE DeleteDoctor(
    IN p_doctor_id INT -- Input parameter: doctor id to delete
)
BEGIN
    DELETE FROM Doctors WHERE doctor_id = p_doctor_id;
END //

DELIMITER ;

-- Procedure to insert appointment
DELIMITER //

CREATE PROCEDURE InsertAppointment(
    IN p_patient_id INT, -- Input parameter: patient id for the appointment
    IN p_doctor_id INT, -- Input parameter: doctor id for the appointment
    IN p_appointment_date DATE, -- Input parameter: appointment date
    IN p_appointment_time TIME, -- Input parameter: appointment time
    IN p_appointment_purpose TEXT -- Input parameter: purpose of the appointment
)
BEGIN
    INSERT INTO Appointments (patient_id, doctor_id, appointment_date, appointment_time, appointment_purpose)
    VALUES (p_patient_id, p_doctor_id, p_appointment_date, p_appointment_time, p_appointment_purpose);
END //

DELIMITER ;

-- Procedure to select appointment by id
DELIMITER //

CREATE PROCEDURE SelectAppointmentById(
    IN p_appointment_id INT -- Input parameter: appointment id
)
BEGIN
    SELECT * FROM Appointments WHERE appointment_id = p_appointment_id;
END //

DELIMITER ;

-- Procedure to update appointment
DELIMITER //

CREATE PROCEDURE UpdateAppointment(
    IN p_appointment_id INT, -- Input parameter: appointment id to update
    IN p_patient_id INT, -- Input parameter: new patient id for the appointment
    IN p_doctor_id INT, -- Input parameter: new doctor id for the appointment
    IN p_appointment_date DATE, -- Input parameter: new appointment date
    IN p_appointment_time TIME, -- Input parameter: new appointment time
    IN p_appointment_purpose TEXT -- Input parameter: new purpose of the appointment
)
BEGIN
    UPDATE Appointments
    SET patient_id = p_patient_id,
        doctor_id = p_doctor_id,
        appointment_date = p_appointment_date,
        appointment_time = p_appointment_time,
        appointment_purpose = p_appointment_purpose
    WHERE appointment_id = p_appointment_id;
END //

DELIMITER ;

-- Procedure to delete appointment
DELIMITER //

CREATE PROCEDURE DeleteAppointment(
    IN p_appointment_id INT -- Input parameter: appointment id to delete
)
BEGIN
    DELETE FROM Appointments WHERE appointment_id = p_appointment_id;
END //

DELIMITER ;

-- Example of usage:
-- Insert a patient
CALL InsertPatient('Dr. vinay kumar', 'Male', '1990-01-01', '123 Main St, Anytown', '123-456-7890');

-- Select a patient by id
CALL SelectPatientById(1);

-- Update a patient
CALL UpdatePatient(1, 'Dr. Anish Kumar', 'Female', '1989-12-31', '456 Elm St, Othertown', '987-654-3210');

-- Delete a patient
CALL DeletePatient(1);

-- Insert a doctor
CALL InsertDoctor('Dr. Arjun Sahani', 'Cardiology', '555-1234');

-- Select a doctor by id
CALL SelectDoctorById(1);

-- Update a doctor
CALL UpdateDoctor(1, 'Dr. Johnson', 'Neurology', '555-5678');

-- Delete a doctor
CALL DeleteDoctor(1);

-- Insert an appointment
CALL InsertAppointment(1, 1, '2024-07-01', '10:00:00', 'Regular checkup');

-- Select an appointment by id
CALL SelectAppointmentById(1);

-- Update an appointment
CALL UpdateAppointment(1, 1, 2, '2024-07-01', '11:00:00', 'Follow-up appointment');

-- Delete an appointment
CALL DeleteAppointment(1);

-- Procedures drop (optional after usage)
DROP PROCEDURE IF EXISTS InsertPatient, SelectPatientById, UpdatePatient, DeletePatient,
                      InsertDoctor, SelectDoctorById, UpdateDoctor, DeleteDoctor,
                      InsertAppointment, SelectAppointmentById, UpdateAppointment, DeleteAppointment;

