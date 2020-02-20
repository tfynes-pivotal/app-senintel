# app-senintel
create a single composite layer7 healthcheck endpoint for multiple apps

Introduction

When using a global traffic manager (GTM) to provide multi-region URL for microservice based applications, there is a frequent requirement to create a 'fault domain' around the services such that if one is not responding all requests for all micro-services should be redirected to the alternative region.

The PCF/TAS platform natively support HTTP / Layer7 health-checking for hosted applciations but each microservice but a GTM would require a SINGLE healthcheck endpoint that would fail if any of the constituent services' healthchecks fail
