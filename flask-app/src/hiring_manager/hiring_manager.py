from flask import Blueprint, request, jsonify, make_response
import json
from src import db

hiring_manager = Blueprint('hiring_manager', __name__)

#get all hiring manaegers from the DB
@hiring_manager.route('/hiring_manager', methods=['GET'])
def get_hiring_managers():
    cursor = db.get_db().cursor()
    cursor.execute('select FirstName, LastName, Email from hiring_manager group by EmployeeID')
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response

#get hiring manager detail for hiring manager with particular userID
@hiring_manager.route('/hiring_manager_userfacing/<EmployeeID>', methods=['GET'])
def get_hiring_manager_userfacing(EmployeeID):
    cursor = db.get_db().cursor()
    query = 'select FirstName, LastName, Email from hiring_manager where EmployeeID = ' + str(EmployeeID)
    #current_app.logger.info(query)
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    # the_response = make_response(jsonify(json_data))
    # the_response.status_code = 200
    # the_response.mimetype = 'application/json'
    return json_data

#get hiring manager detail for hiring manager with particular userID
@hiring_manager.route('/hiring_manager/<EmployeeID>', methods=['GET'])
def get_hiring_manager(EmployeeID):
    cursor = db.get_db().cursor()
    query = 'select * from hiring_manager where EmployeeID = ' + str(EmployeeID)
    #current_app.logger.info(query)
    cursor.execute(query)
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    # the_response = make_response(jsonify(json_data))
    # the_response.status_code = 200
    # the_response.mimetype = 'application/json'
    return json_data



#get all jobs for a particular hiring manager
@hiring_manager.route('/hiring_manager/<EmployeeID>/jobs', methods=['GET'])
def get_hiring_manager_jobs(EmployeeID):
    cursor = db.get_db().cursor()
    cursor.execute('select title, description from job where EmployeeID = ' + str(EmployeeID))
    row_headers = [x[0] for x in cursor.description]
    json_data = []
    theData = cursor.fetchall()
    for row in theData:
        json_data.append(dict(zip(row_headers, row)))
    the_response = make_response(jsonify(json_data))
    the_response.status_code = 200
    the_response.mimetype = 'application/json'
    return the_response


#get all job applications
@hiring_manager.route('/hiring_manager/<EmployeeID>/job_applications', methods=['GET'])
def get_hiring_manager_job_applications(EmployeeID):
    cursor = db.get_db().cursor()
    query = '''
    select ApplicationDate, jobApplicationID from jobApplication
         where JobID in
               (select JobID from job where CompanyID in
                                             (select CompanyID from hiring_manager
                                                               where EmployeeID = ''' + str(EmployeeID) + '))'''
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



