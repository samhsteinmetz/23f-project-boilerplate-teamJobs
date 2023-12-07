-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database job_board;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on job_board.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use job_board;

-- Put your DDL 



CREATE TABLE applicant (
    ID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName varchar(255),
    LastName varchar(255),
    DOB DATE,
    Email varchar(255),
    PasswordHASH varchar(100),
    Phone varchar(20),
    StreetAddress varchar(255),
    City varchar(200),
    State varchar(200),
    Zip varchar(10)

);

CREATE TABLE wants (
    WantID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT,
    WantDescription varchar(50),
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
);

CREATE TABLE pdf_resume (
    pdfID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT NOT NULL,
    PdfFilename BLOB,
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
);

CREATE TABLE company (
    CompanyID INT AUTO_INCREMENT PRIMARY KEY,
    Name varchar(100),
    about TEXT

);

CREATE TABLE job (
    JobID INT AUTO_INCREMENT PRIMARY KEY,
    CompanyID INT,
    Title varchar(255),
    Description TEXT,
    Salary INT,
    LocationTownCity varchar(255),
    LocationState varchar(255),
    ApplicationDeadline DATE,
    FOREIGN KEY (CompanyID) REFERENCES company(CompanyID)
);


CREATE TABLE benefits (
    BenefitID INT AUTO_INCREMENT PRIMARY KEY,
    JobID INT,
    BenefitDescription TEXT,
    FOREIGN KEY (JobID) REFERENCES job(JobID)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
);

CREATE TABLE jobApplication (
    jobApplicationID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT,
    JobID INT,
    ApplicationDate DATE,
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE,
    FOREIGN KEY (JobID) REFERENCES job(JobID)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
);




CREATE TABLE hiring_manager (
    EmployeeID INT AUTO_INCREMENT PRIMARY KEY,
    CompanyID INT NOT NULL,
    FirstName varchar(255),
    LastName varchar(255),
    Email varchar(255) NOT NULL ,
    Phone INT,
    PasswordHASH varchar(100) NOT NULL,
    FOREIGN KEY (CompanyID) REFERENCES company(CompanyID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE
);

CREATE TABLE education (
    EducationID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT,
    Name VARCHAR(100),
    GradDate DATE,
    clubs VARCHAR(300),
    courses VARCHAR(400),
    GPA DECIMAL(3,2),
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
);

CREATE TABLE Volunteer_Experience(
    volunteerExperienceID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT,
    title VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Description TEXT,
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                                 ON DELETE CASCADE
                                ON UPDATE CASCADE

);

CREATE TABLE Work_Experience(
    experienceID INT AUTO_INCREMENT PRIMARY KEY,
    ApplicantID INT,
    title VARCHAR(100),
    StartDate DATE,
    EndDate DATE,
    Description TEXT,
    City varchar(200),
    State varchar(200),
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                                    ON DELETE CASCADE
                                    ON UPDATE CASCADE
);

CREATE TABLE skill (
    skillID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100)
);

CREATE TABLE applicant_skill(
    ApplicantID INT,
    SkillID INT,
    SkillLevel INT,
    primary key (ApplicantID, SkillID),
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                                ON DELETE CASCADE
                                ON UPDATE CASCADE,
    FOREIGN KEY (SkillID) REFERENCES skill(skillID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE
);

CREATE TABLE skill_test (
    SkillTestID INT AUTO_INCREMENT PRIMARY KEY,
    SKillID INT,
    Name VARCHAR(255),
    foreign key (SkillID) references skill(skillID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE

);

CREATE TABLE job_skill_test(
    JobID INT,
    SkillTestID INT,
    PRIMARY KEY (JobID, SkillTestID),
    FOREIGN KEY (JobID) REFERENCES job(JobID)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE,
    FOREIGN KEY (SkillTestID) REFERENCES skill_test(SkillTestID)
                                ON DELETE RESTRICT
                                ON UPDATE CASCADE
);


CREATE TABLE applicantSkillTests(
    ApplicantID INT,
    SkillTestID INT,
    dateTaken DATE,
    Score INTEGER,
    PRIMARY KEY (ApplicantID, SkillTestID),
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                                 ON DELETE CASCADE
                                 ON UPDATE CASCADE,
    FOREIGN KEY (SkillTestID) REFERENCES skill_test(SkillTestID)
                                 ON DELETE RESTRICT
                                ON UPDATE CASCADE
);

CREATE TABLE test_questions(
    QuestionID INT AUTO_INCREMENT PRIMARY KEY,
    SkillTestID INT,
    QuestionText TEXT,
    FOREIGN KEY (SkillTestID) REFERENCES skill_test(SkillTestID)
                                ON DELETE CASCADE
                                ON UPDATE CASCADE
);

CREATE TABLE hires_for (
    HiringManagerID INT,
    JobID INT,
    StartDate DATE,
    PRIMARY KEY (HiringManagerID, JobID),
    FOREIGN KEY (HiringManagerID) REFERENCES hiring_manager(EmployeeID)
                                ON DELETE CASCADE
                                ON UPDATE CASCADE,
    FOREIGN KEY (JobID) REFERENCES job(JobID)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
);

CREATE TABLE applicant_views_job (
    ApplicantID INT,
    JobID INT,
    ViewDate DATE,
    PRIMARY KEY (ApplicantID, JobID),
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID),
    FOREIGN KEY (JobID) REFERENCES job(JobID)
);

CREATE TABLE post (
    PostID INT AUTO_INCREMENT PRIMARY KEY,
    CompanyID INTEGER,
    Title VARCHAR(100),
    Description TEXT,
    FOREIGN KEY (CompanyID) REFERENCES company(CompanyID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE
);


CREATE TABLE photo (
    PhotoID INT AUTO_INCREMENT PRIMARY KEY,
    PostID INTEGER,
    ImageFilename TEXT,
    FOREIGN KEY (PostID) REFERENCES post(PostID)
                        ON DELETE CASCADE
                        ON UPDATE CASCADE
);


CREATE TABLE applicant_views_post (
    ApplicantID INT,
    PostID INT,
    ViewDate DATETIME,
    PRIMARY KEY (ApplicantID, PostID, ViewDate),
    FOREIGN KEY (ApplicantID) REFERENCES applicant(ID)
                                  ON DELETE CASCADE
                                ON UPDATE CASCADE,
    FOREIGN KEY (PostID) REFERENCES post(PostID)
                            ON DELETE CASCADE
                            ON UPDATE CASCADE
);


-- Add sample data. 

-- INSERT INTO applicant (FirstName, LastName, DOB, Email, PasswordHASH, Phone, StreetAddress, City, State, Zip)
-- VALUES ('John', 'Doe', '1990-01-01', 'johndoe@gmail.com', '124114', '1234567890', '123 Main St', 'Woburn', 'MA', '01224'),
--         ('Jane', 'Limmick', '1990-01-01', 'jane@gmail.com', '124114', '1234567890', '123 Main St', 'Bmore', 'MD', '1201');



-- INSERT INTO wants (ApplicantID, WantDescription)
-- VALUES (1, 'Flexible Hours'),
--          (1, 'Remote Work');



-- INSERT INTO pdf_resume (ApplicantID, PdfFilename)
-- VALUES (1, 'resume1.pdf'),
--     (2, 'resume2.pdf');


-- INSERT INTO company (Name, about)
-- VALUES ('Apple', 'An innovative technology company.'),
--    ('Google', 'A technology company specializing in search engines.');



-- INSERT INTO job (CompanyID, Title, Description, Salary, LocationTownCity, LocationState, ApplicationDeadline)
-- VALUES (1, 'Software Engineer', 'Develop and maintain software applications DATABASE ONLY.', 80040, 'texastown', 'texas', '2023-12-31'),
-- (1, 'Software Engineer', 'Develop and maintain software applications Frontent ONLY.', 80050, 'texastown', 'texas', '2023-12-31');


-- INSERT INTO benefits (JobID, BenefitDescription)
-- VALUES (1, 'Health insurance, Retirement plan'),
-- (2, 'PTO, Retirement plan');


-- INSERT INTO jobApplication (ApplicantID, JobID, ApplicationDate)
-- VALUES (1, 1, '2023-01-01'),
-- (2, 1, '2023-01-01');


-- INSERT INTO hiring_manager (CompanyID, FirstName, LastName, Email, Phone, PasswordHASH)
-- VALUES (1, 'Alice', 'Smith', 'alice.smith@apple.com', 9876543210, '1414'),
-- (2, 'Bob', 'Jones', 'bobj@google.com', 9876543210, '1214');


-- INSERT INTO education (ApplicantID, Name, GradDate, clubs, courses, GPA)
-- VALUES (1, 'University of Example', '2022-05-15', 'Computer Club', 'Computer Science, Mathematics', 3.8);

-- INSERT INTO Volunteer_Experience (ApplicantID, title, StartDate, EndDate, Description)
-- VALUES (1, 'Community Volunteer', '2021-06-01', '2021-08-31', 'Participated in community clean-up initiatives.');


-- INSERT INTO Work_Experience (ApplicantID, title, StartDate, EndDate, Description, City, State)
-- VALUES (1, 'Junior Developer', '2020-01-01', '2021-01-01', 'Worked on various software development projects.', 'CityName', 'StateName');



-- INSERT INTO applicant_views_post (ApplicantID, PostID, ViewDate)
-- VALUES (1, 1, NOW()),
-- (2, 1, NOW());








