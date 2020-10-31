Starting from Saturday, 10 October, 2020

Day 1:
	Read the project description carefully
	Discover the Weaveworksdemos github account to find the useful files
	Discover each microservice repo.
Problems: project seems very huge

Day 2:
	Clone 10 micro-services locally
	Try to use dockerfiles for some services
	pull the microservices’ images and run them
Problems:
	Dockerfiles not working
	My progress for today is zero

Day 3:
	Dive deeply into orders and carts microservices
	Use bash scripts inside repos. to run the docker files
	play with the images and running them
  	Push the images into my docker hub account
Problems: database is not working and IDK how to run it or where to find it

Day 4:
	Building the user and user DB, but it’s not working
	trying to understand the build bash file

Day 5:
	Making multi staged docker file for shipping
	Push image to docker hub
	Test if the image locally
	Making multistage dockerfile for payment
Problems: payment dockerfile is not working without the bash script

Day 6 & 7:
	Working on user and user db
	Working on orders db
	Working on carts db
	Made modifications to orders and carts source codes


Starting from Sunday, 18 October, 2020

Day 8:
	Built catalogue  and catalogue db docker images and pushed it to docker hub
	Built frontend image and pushed it to dockerhub
	built queue master image and pushed it
	Test the images locally (catalogue db not working)
	Build the load test image (not working)


Day 9:
	Try to run payment dockerfile locally
	Try to run databases with there services using docker netowrk locally


Day 10 - 14:
	Look for how to create deployment and service files
	try to play with microservices deploy and service files


Day 15 till the final day:
	Working on tekton tasks and pipelines
	Modify some docker files to work with pipelines
	testing the website on the browser
	Debugging and fixing problems
	Looking how to apply triggers
	Working on e2e-test
	Try to automate dashboard provisioning in grafana and elf
	Cleaning the project
Problems: I had Error on the login which is about XMLHTTPRequest couldn't find the way to solve even after modifying the manifest files.
	  The cart couldn't be updated and basically it's about the same problem mentioned above


Done:
	Got every microservice working (tasks and pipelines) correctly (based on the health check)
	Operating Grafana and elf

Not Done:
	Got Errors when operating the website
	The test is not 100% passed
	Couldn’t automatically provision the dashboards into grafana and elf

Trello: 
	https://trello.com/b/uwezvR3h/level-3-project

