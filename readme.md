# DevOps Bootcamp Level 3 Final Project

## Capstone Project

The aim of the level 3 project is to give you something to demonstrate to potential employers. You will use this as a showcase for the skills you have developed and the tools you have mastered.
-------------------------------------------------------

## Files structure
### In the root directory you will find the files: 
#### *Secret.yaml (contains token to push the images and don't worry about the exposed password it has been changed)
#### *clusterrole.yaml
#### *serviceAccount.yaml
#### *roleBinding.yaml
#### *Makefile
Each microservice has its own directory. Each of which has a "tekton-tasks" directory that contain the tasks. In the root directory of the microservice you will find the pipeline and pipelineRun files.


## Namespaces
### Test for testing
### Prod for production
### Logging for elf
### Monitoring for grafana

## Makefile
### [microservice]-test : are to run the microservice and the test after (not all tested but seems working)
### release: to release pods into production
### install-monitoring: to install grafana and prometheus
### install- logging: to install elf
### all: to run all microservices in test namespace and then run the test

## Note
### there is another make file inside the k8s-sandbox which is used for the cluster and so on.
### the directory called Mynotes got screenshots of kanban dashboard and some notes.

