CREATE DATABASE BookStore
GO

USE BookStore
GO

CREATE TABLE Orders(ndoc int primary key, Date_of_Order timestamp, Cust_ID int, Sum_RUR float, Pmnt_RUR float);

CREATE TABLE Orders_data (ndoc int, npos int, Book_ID int, Qty_ord int, Qty_out int, Price_RUR float, primary key(ndoc, npos));

CREATE TABLE Stock (Book_ID int primary key, Qty_in_Stock int, Qty_rsrv int);

CREATE TABLE Books (Book_ID int primary key, Book varchar, Author_ID int, BookYear int, Price_RUR float, Section_ID int);

CREATE TABLE Sections (Section_ID int primary key, Section varchar);

CREATE TABLE Authors (Author_ID int primary key, Surname varchar, Name varchar);

CREATE TABLE Customers (Cust_ID int primary key, Customer varchar, Balance float);
