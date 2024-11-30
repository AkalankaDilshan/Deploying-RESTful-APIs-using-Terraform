import json
import logging

logger = logging.getLogger()
logger.setLevel(logging.INFO)



def lambda_handler(event, context) :
     logger.debug(event)
     
     #/Students/{StudentID}
     Students = [
          {
               "id":"1",
               "name":"Rumesh Rajapaksha",
               "GPA": 3.99
          },
          {
               "id":"2",
               "name":"Janidu Lakal",
               "GPA": 3.31
          },
          {
               "id":"3",
               "name":"Chamindu Deshan",
               "GPA": 3.85
          },
          {
               "id":"4",
               "name":"Sukitha sathsata",
               "GPA": 4.00
          },
          {
               "id":"5",
               "name":"Rusith sanjana",
               "GPA": 3.95
          }
     ]
     
     def response_payload(err, res=None):
          return{
               'statusCode' : '400' if err else '200',
               'body': err if err else json.dumps(res),
               'headers': {
                    'Content-Type': 'application/json',
               },
          }
     
     resource = event['resource']
     
     err = None
     # /Students List all students
     response_body = {}
     if(resource == '/Students'):
          response_body = {
               "Students" : Students
          }
     
     # / Students/{Student ID} find student by id
     elif (resource == '/Students/{id}'):
          StudentID = event['pathParameters']['id']
          value = next((item for item in Students if item["id"] == str(StudentID)), False)
          if(value == False):
               err = "Student not found"
          else : 
               response_body = {
                    "Student": value
               }
     
     response = response_payload(err,response_body)

     return response
     
     

