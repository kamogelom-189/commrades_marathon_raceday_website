 

IF OBJECT_ID('dbo.Results', 'U') IS NOT NULL DROP TABLE dbo.Results; 

IF OBJECT_ID('dbo.Enrolments', 'U') IS NOT NULL DROP TABLE dbo.Enrolments; 

IF OBJECT_ID('dbo.Categories', 'U') IS NOT NULL DROP TABLE dbo.Categories; 

IF OBJECT_ID('dbo.Events', 'U') IS NOT NULL DROP TABLE dbo.Events; 

IF OBJECT_ID('dbo.Users', 'U') IS NOT NULL DROP TABLE dbo.Users; 

IF OBJECT_ID('dbo.Roles', 'U') IS NOT NULL DROP TABLE dbo.Roles; 

GO 

 


CREATE TABLE Roles ( 

? ? RoleID INT IDENTITY(1,1) PRIMARY KEY, 

? ? RoleName VARCHAR(20) NOT NULL UNIQUE 

); 

 


CREATE TABLE Users ( 

? ? UserID INT IDENTITY(1,1) PRIMARY KEY, 

? ? RoleID INT NOT NULL, 

? ? FullName VARCHAR(100) NOT NULL, 

? ? Email VARCHAR(150) NOT NULL UNIQUE, 

? ? PasswordHash VARCHAR(255) NOT NULL, 

? ? CreatedAt DATETIME DEFAULT GETDATE(), 

? ? CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleID) REFERENCES Roles(RoleID) 

); 

 


CREATE TABLE Events ( 

? ? EventID INT IDENTITY(1,1) PRIMARY KEY, 

? ? OrganiserID INT NOT NULL, 

? ? Title VARCHAR(150) NOT NULL, 

? ? Description VARCHAR(MAX) NULL, 

? ? EventDate DATETIME NOT NULL, 

? ? Location VARCHAR(150) NOT NULL, 

? ? CONSTRAINT FK_Events_Organisers FOREIGN KEY (OrganiserID) REFERENCES Users(UserID) 

); 

 
 

CREATE TABLE Categories ( 

? ? CategoryID INT IDENTITY(1,1) PRIMARY KEY, 

? ? EventID INT NOT NULL, 

? ? CategoryName VARCHAR(100) NOT NULL, 

? ? DistanceKM DECIMAL(5,2) NOT NULL, 

? ? EntryFee DECIMAL(10,2) NOT NULL, 

? ? CONSTRAINT FK_Categories_Events FOREIGN KEY (EventID) REFERENCES Events(EventID) ON DELETE CASCADE 

); 

 



CREATE TABLE Enrolments ( 

? ? EnrolmentID INT IDENTITY(1,1) PRIMARY KEY, 

? ? ParticipantID INT NOT NULL, 

? ? CategoryID INT NOT NULL, 

? ? EnrolmentDate DATETIME DEFAULT GETDATE(), 

? ? PaymentStatus VARCHAR(20) DEFAULT 'Pending' CHECK (PaymentStatus IN ('Pending', 'Paid', 'Cancelled')), 

? ? CONSTRAINT FK_Enrolments_Participants FOREIGN KEY (ParticipantID) REFERENCES Users(UserID), 

? ? CONSTRAINT FK_Enrolments_Categories FOREIGN KEY (CategoryID) REFERENCES Categories(CategoryID) 

); 

 


CREATE TABLE Results ( 

? ? ResultID INT IDENTITY(1,1) PRIMARY KEY, 

? ? EnrolmentID INT NOT NULL UNIQUE, 

? ? RaceNumber VARCHAR(20) NOT NULL, 

? ? FinishTime TIME NULL, 

? ? Position INT NULL, 

? ? CONSTRAINT FK_Results_Enrolments FOREIGN KEY (EnrolmentID) REFERENCES Enrolments(EnrolmentID) ON DELETE CASCADE 

); 

GO 

 

INSERT INTO Roles (RoleName) VALUES  

('Organiser'),  

('Participant'); 

 



INSERT INTO Users (RoleID, FullName, Email, PasswordHash) VALUES  

(1, 'Sipho Zulu', 'sipho@raceorganisers.co.za', 'hashed_pass_123'), ?-- Organiser 1 

(1, 'Anika van der Merwe', 'anika@eventssa.co.za', 'hashed_pass_456'), -- Organiser 2 

(2, 'Thabo Mokoena', 'thabo.m@gmail.com', 'hashed_pass_789'), ? ? ? ? ?-- Participant 1 

(2, 'Sarah Jenkins', 'sarah.j@outlook.com', 'hashed_pass_321'); ? ? ? ?-- Participant 2 


INSERT INTO Events (OrganiserID, Title, Description, EventDate, Location) VALUES  

(1, 'Soweto Marathon', 'The iconic annual marathon running through the heart of Soweto.', '2026-11-01 06:00:00', 'Soweto, Johannesburg'), 

(1, 'Cape Town Cycle Tour', 'World famous scenic cycling race around the Cape Peninsula.', '2027-03-08 06:30:00', 'Cape Town, Western Cape'), 

(2, 'Tshwane 10km City Run', 'A fast and fun road running route across Pretoria central.', '2026-10-15 07:00:00', 'Pretoria, Gauteng'); 

 
 

INSERT INTO Categories (EventID, CategoryName, DistanceKM, EntryFee) VALUES  

(1, '42km Full Marathon', 42.20, 350.00), 

(1, '21km Half Marathon', 21.10, 250.00), 

(1, '10km Open Run', 10.00, 150.00), 

(2, '109km Full Tour', 109.00, 650.00), 

(2, '42km Short Circuit', 42.00, 400.00), 

(3, '10km Road Race', 10.00, 120.00), 

(3, '5km Fun Run', 5.00, 80.00); 

 

-- Insert Sample Enrolments 

INSERT INTO Enrolments (ParticipantID, CategoryID, PaymentStatus) VALUES  

(3, 1, 'Paid'), ?-- Thabo in Soweto 42km 

(3, 4, 'Paid'), ?-- Thabo in Cycle Tour 109km 

(4, 2, 'Paid'), ?-- Sarah in Soweto 21km 

(4, 6, 'Pending'); -- Sarah in Tshwane 10km 

 

-- Insert Sample Results 

INSERT INTO Results (EnrolmentID, RaceNumber, FinishTime, Position) VALUES  

(1, 'BIB-1001', '03:15:42', 12), 

(3, 'BIB-2045', '01:45:10', 5); 

GO 

select*from users

 
