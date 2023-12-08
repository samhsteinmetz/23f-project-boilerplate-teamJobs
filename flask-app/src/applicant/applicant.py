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
    cursor.execute('SELECT ID, FirstName, LastName FROM applicant')

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
    query = 'INSERT INTO pdf_resume (ApplicantID, PdfFilename) VALUES (' + str(ID) + ', request[PdfFilename])'
   # current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@applicant.route('/applicant/<ID>/pdf_resume/<pdfID>', methods=['DELETE'])
def delete_applicant_resume (ID, pdfID):
    cursor = db.get_db().cursor()
    query = 'DELETE FROM pdf_resume WHERE' + str(ID) + '= ApplicantID AND' + str(pdfID) + '= pdfID'
   # current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

# get the education for a particular applicant
@applicant.route('/applicant/<ID>/education', methods=['GET'])
def get_applicant_education(ID):
    cursor = db.get_db().cursor()
    cursor.execute('select School, Degree, Major, GraduationYear from education where applicantID = + str(ID)')
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
    cursor.execute('select Company, JobTitle, StartDate, EndDate from experience where applicantID = ' + str(ID))
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
    cursor.execute('select SkillName, SkillLevel from skills where applicantID = ' + str(ID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response




