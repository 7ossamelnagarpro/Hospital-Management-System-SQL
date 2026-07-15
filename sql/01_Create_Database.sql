/*
===============================================================================
 Project      : Hospital Management System
 Database     : HospitalManagementDB
 File         : 01_Create_Database.sql
 Author       : Hossam Elnagar

 Description:
 This script creates the Hospital Management database.

===============================================================================
*/

-- Drop database if it already exists (Development Only)

USE master;
GO

IF EXISTS
(
    SELECT name
    FROM sys.databases
    WHERE name = 'HospitalManagementDB'
)
BEGIN
    ALTER DATABASE HospitalManagementDB
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;

    DROP DATABASE HospitalManagementDB;
END
GO


CREATE DATABASE HospitalManagementDB;
GO


USE HospitalManagementDB;
GO