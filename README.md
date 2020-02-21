# app-sentinel
Create a single composite layer7 healthcheck endpoint for multiple apps

-- Experimental --

Introduction

When using a global traffic manager (GTM) to provide multi-region URL for microservice based applications, there is a frequent requirement to create a 'fault domain' around the services such that if one is not responding, all requests for all micro-services should be redirected to the alternative region.

The PCF/TAS platform natively support HTTP / Layer7 health-checking for hosted applciations but a healthcheck-per-microservice could result in a partial failover of some microservices to an alternative region. 

The solution is to have a single composite healthcheck endpoint that asserts in one response that all local microservices' endpoints healthy


How it works

With a drive to ultra-optimize for footprint app-sentinel functions as a bare-minimal HTTP server using binary-buildpack and NetCat. It will respond with status 200 so long as the list of target hosts all provide status 200 responses to it. Otherwise it will return status 404 if ANY of the target hosts are not healthy


Directions

Modify manifest to provide app-sentinel with a unique name / route
Provide comma delimited list of target hosts in the TARGET_HOSTS env variable

Demo Scenario
Test client loop using bash / curl
`
  while true; do echo && sleep 1 && curl -s -o /dev/null -I -w "%{http_code}" https://app-sentinel.cfapps.io; done
`  
update manifest file to initialize TARGET_HOSTS environment to point to comma delimited list of live endpoints and update app-sentinel application name as necessary:

e.g.
---
`
applications:
- name: app-sentinel
  buildpacks:
    - binary_buildpack
  command: /home/vcap/app/sentinel.sh
  memory: 16M
  disk_quota: 16M
  env:
     TARGET_HOSTS: https://pcfshell.cfapps.io,https://appmedictest.cfapps.io
`     

Observe your curl client loop reporting status 200 as all endpoints along with app-sentinel are running.
`'cf stop <app1>'`
Observe how your app-sentinel is now reporting a 404 (which a GTM could use to steer traffic to an alternative region)



