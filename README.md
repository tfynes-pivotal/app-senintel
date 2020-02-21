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


