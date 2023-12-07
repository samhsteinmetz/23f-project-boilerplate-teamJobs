-- This file is to bootstrap a database for the CS3200 project. 

-- Create a new database.  You can change the name later.  You'll
-- need this name in the FLASK API file(s),  the AppSmith 
-- data source creation.
create database jobboard;

-- Via the Docker Compose file, a special user called webapp will 
-- be created in MySQL. We are going to grant that user 
-- all privilages to the new database we just created. 
-- TODO: If you changed the name of the database above, you need 
-- to change it here too.
grant all privileges on jobboard.* to 'webapp'@'%';
flush privileges;

-- Move into the database we just created.
-- TODO: If you changed the name of the database above, you need to
-- change it here too. 
use jobboard;


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
    WantDescription varchar(500),
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


-- PUT MY DATA HERE


-- applicants

insert into company (CompanyID, Name, about) values (12311,'Google', 'Google is an American multinational technology company that specializes in Internet-related services and products, which include online advertising technologies, search engine, cloud computing, software, and hardware.');
