from flask import Blueprint, request, jsonify, make_response
import json
from src import db


company = Blueprint('company', __name__)

# Get all the products from the database
@company.route('/company', methods=['GET'])

def get_company():
    # get a cursor object from the database
    cursor = db.get_db().cursor()

    # use cursor to query the database for a list of products
    cursor.execute('select name from company group by CompanyID')

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



@company.route('/company/<CompanyID>', methods=['GET'])
def get_company_detail (CompanyID):
    
    cursor = db.get_db().cursor()

    query = 'SELECT name, about FROM company WHERE CompanyID = ' + str(CompanyID)
    #current_app.logger.info(query)

   
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

@company.route('/company/<CompanyID>/jobs', methods=['GET'])
def get_company_jobs (CompanyID):
    cursor = db.get_db().cursor()
    query = 'SELECT title, description FROM job WHERE CompanyID = ' + str(CompanyID)
   # current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)


@company.route('/company/<CompanyID>/jobs/<jobID>', methods=['GET'])
def get_company_job_detail (CompanyID, jobID):
    cursor = db.get_db().cursor()
    query = 'SELECT Title, Description, Salary, LocationTownCity, LocationTownState, ApplicationDeadline FROM jobs WHERE CompanyID = ' + str(CompanyID) + ' AND jobID = ' + str(jobID)
    #current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description] 
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

#get the posts from a company
@company.route('/company/<CompanyID>/posts', methods=['GET'])
def get_company_posts (CompanyID):
    cursor = db.get_db().cursor()
    query = 'SELECT title, description FROM post WHERE CompanyID = ' + str(CompanyID)
    #current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)
    column_headers = [x[0] for x in cursor.description]
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

#get the detail of a post from a company
@company.route('/company/<CompanyID>/posts/<postID>', methods=['GET'])
def get_company_post_detail (CompanyID, postID):
    cursor = db.get_db().cursor()
    query = 'SELECT Title, Description, LocationTownCity, LocationTownState, ApplicationDeadline FROM post WHERE CompanyID = ' + str(CompanyID) + ' AND postID = ' + str(postID)
    #current_app.logger.info(query)

    cursor = db.get_db().cursor()
    cursor.execute(query)

    column_headers = [x[0] for x in cursor.description] 
    json_data = []
    the_data = cursor.fetchall()
    for row in the_data:
        json_data.append(dict(zip(column_headers, row)))

    return jsonify(json_data)

#update the given comapnyid the companys information
@company.route('/company/<CompanyID>', methods=['PUT'])
def update_company_detail (CompanyID):
    cursor = db.get_db().cursor()
    query = 'UPDATE company SET name = %s, about = %s WHERE CompanyID = ' + str(CompanyID)
   # current_app.logger.info(query)

 
    cursor.execute(query, (request.json['company_name'], request.json['company_about']))
    db.get_db().commit()
    return jsonify({"status":"ok"})



#add a post to a company
@company.route('/company/<CompanyID>/posts', methods=['POST'])
def add_company_post (CompanyID):
    cursor = db.get_db().cursor()
    query = 'INSERT INTO post (CompanyID, Title, Description) VALUES (%s, %s, %s)'
    #current_app.logger.info(query)

    cursor.execute(query, (CompanyID, request.json['post_title'], request.json['post_description']))
    db.get_db().commit()
    return jsonify({"status":"ok"})












