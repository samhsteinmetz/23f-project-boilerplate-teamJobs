from flask import Blueprint, request, jsonify, make_response
import json
from src import db


applicant = Blueprint('applicant', __name__)

# Get all the products from the database
@applicant.route('/applicant', methods=['GET'])

def get_applicant():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('SELECT FirstName, LastName, DOB FROM applicant')

    # grab the column headers from the returned data
    column_headers = [x[0] for x in cursor.description]

    # create an empty dictionary object to use in 
    # putting column headers together with data
    json_data = []

    # fetch all the data from the cursor
    theData = cursor.fetchall()

    # for each of the rows, zip the data elements together with
    # the column headers. 
    for row in theData:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)



@applicant.route('/applicant/<ID>', methods=['GET'])
def get_applicant_detail (ID):
    
    cursor = db.get_db().cursor()

    query = 'SELECT FirstName, LastName, DOB, Email, Phone, StreetAddress, City, State, Zip FROM applicant WHERE ID = ' + str(ID)
    #current_app.logger.info(query)

   
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)



@applicant.route('/applicant/<ID>/pdf_resume', methods=['POST'])
def post_applicant_resume (ID):
    cursor = db.get_db().cursor()

    PdfFilename = request.json['pdf_input']

    cursor.execute('INSERT INTO pdf_resume (ApplicantID, PdfFilename) VALUES (%s, %s)', (ID, PdfFilename))
    db.get_db().commit()
    
   # current_app.logger.info(query)
    return jsonify({"status":"ok"})

@applicant.route('/applicant/<ID>/pdf_resume', methods=['DELETE'])
def delete_applicant_resume (ID):
    cursor = db.get_db().cursor()
    fileName = request.json['pdf_input_delete']
    cursor.execute('DELETE FROM pdf_resume WHERE ApplicantID = %s AND PdfFilename = %s', (ID, fileName))
   # current_app.logger.info(query)
    db.get_db().commit()
    return jsonify({"status":"ok"})

# get the education for a particular applicant
@applicant.route('/applicant/<ID>/education', methods=['GET'])
def get_applicant_education(ID):
    cursor = db.get_db().cursor()
    cursor.execute('select Name, GradDate, clubs, courses, GPA from education where ApplicantID =' + str(ID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get the experience for a particular applicant
@applicant.route('/applicant/<ID>/Work-Experience', methods=['GET'])
def get_applicant_experience(ID):
    cursor = db.get_db().cursor()
    cursor.execute('select Title, Description, StartDate, EndDate, City, State from Work_Experience where applicantID =' + str(ID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get the skills for a particular applicant
@applicant.route('/applicant/<ID>/skills', methods=['GET'])
def get_applicant_skills(ID):
    cursor = db.get_db().cursor()
    query = 'select name from skill where SkillID in (select SkillID from applicant_skill where ApplicantID = ' + str(ID) + ')'
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

# get the volunteer experience for a particular applicant
@applicant.route('/applicant/<ID>/volunteer_experience', methods=['GET'])
def get_applicant_volunteer_experience(ID):
    cursor = db.get_db().cursor()
    cursor.execute('select title, Description, StartDate, EndDate from Volunteer_Experience where ApplicantID =' + str(ID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


#get all pdf resumes for a particular applicant
@applicant.route('/applicant/<ID>/pdf_resume', methods=['GET'])
def get_applicant_pdf_resume(ID):
    cursor = db.get_db().cursor()
    cursor.execute('select PdfFilename from pdf_resume where ApplicantID =' + str(ID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response




# given a job id out put skills required for that job
@applicant.route('/jobs/<jobID>/skills', methods=['GET'])
def get_applicant_job_skills(ID, jobID):
    cursor = db.get_db().cursor()
    query = 'select name from skill where SkillID in (select SkillID from job_skill where JobID = ' + str(jobID) + ')'
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

