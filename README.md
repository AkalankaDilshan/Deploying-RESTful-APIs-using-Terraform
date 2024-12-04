# Deploying-RESTful-APIs-using-Terraform
This project demonstrates deploying a RESTful API to invoke an AWS lambda function using Infrastructure as Code(`IaC`) with Terrafprm. 

Here we use a hardcoded Python Lambda fucntion serves as the backend and its response the API provides the following endpoints : 
- `/students` - Handles requests to fetch a list of students.
- `/studnet/{id}` - Handles requests for a specific student by ID.

![archirecture](https://github.com/user-attachments/assets/09052134-90c5-4071-8da1-49b4d9e458c9)

## Technologies Used
 - AWS API Gateway
 - AWS Lambda
 - Terraform
 - Github Actions 
## prerequiesties
 * An [AWS Account](https://aws.amazon.com/)
 * A [HCP Terraform Account](https://www.terraform.io/)
 * A [Github Account](https://github.com/)
## Setup & Installation 

 First, login your Terraform account and create new organization, then copy organization name to clipboard or somewhere for future usege `(if you already have some organization, use that's name)`

![archirecture3](https://github.com/user-attachments/assets/2c629bfc-ce00-44f7-beaa-ca1768cad653)
![archirecture2](https://github.com/user-attachments/assets/31a4726e-b6bb-43bd-b564-cbbd71a8da8d)

After that, we need to create new **Workspace** for our project.

![ss1](https://github.com/user-attachments/assets/d28d109b-40de-458d-b5e6-6b809fb6447f)

Select **API-Driven-Workflow**

![ss2](https://github.com/user-attachments/assets/36d01551-44d7-457c-9afd-c38e695886a0)


Add some suitable name for your workspace, in my case i call it **Deploying-RESTful-APIs-using-Terraform-project**
![SS3](https://github.com/user-attachments/assets/82784dca-f463-477c-9c71-4ee6dafe6886)



![ss4](https://github.com/user-attachments/assets/3e1c7c9d-16d7-417e-846f-bf7e18a71ed9)
