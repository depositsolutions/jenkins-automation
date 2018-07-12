# An example of how to set up Jenkins in a fully automated way

[![Build Status](https://travis-ci.org/depositsolutions/jenkins-automation.svg?branch=master)](https://travis-ci.org/depositsolutions/jenkins-automation)

Jenkins is a self-contained, open source automation server which can be used to automate all sorts of tasks such as
building, testing, and deploying software.

This project builds a Docker image that contains a fully configured Jenkins. Often, Jenkins is configured by hand. This
has several problems:
* Over time, it becomes hard to understand how it was configured and why.
* Testing out configuration changes is difficult and often happens in production.
* The configuration must be backed up in case the machine the where the configuration is located crashes.

By completely automating the configuration of Jenkins:
1. The configuration is completely traceable and changes to the configuration can be tracked over time.
1. Configuration changes can be developed and tested locally.
1. A new instance of Jenkins spun up and configured within minutes.


## How to start

```sh
docker run \
  --name auto-jenkins \
  --publish 8080:8080 \
  --detach \
  --restart always \
  depositsolutions/jenkins-automation
```

In its default state, auto-jenkins has a single job called `seed-job` that creates the other jobs listed in the file
`job.groovy.override`. Simply run the seed job to initialize the other jobs.

Once it is completed, you should see all jobs listed on auto-jenkins' dashboard. auto-jenkins should be ready to be used:
run your newly added job and ensure Jenkins is behaving correctly.

See https://github.com/jenkinsci/docker#usage for more information and options.


## How to configure Jenkins

All configuration is done using Groovy scripts located in `src/main/resources/docker/init.groovy.d`. Use the
[Jenkins Javadoc](http://javadoc.jenkins.io/) as a reference.


### Environment variables

Some Groovy scripts use environment variables to make it easy to configure the container. The following table lists the
most common environment variables.

Environment variable | Description
--- | ---
JENKINS_ADMIN_EMAIL | The admin's e-mail address
JENKINS_BASE_URL | The base URL of Jenkins
JENKINS_MASTER_EXECUTORS | The number of executors for the master
JENKINS_SLAVEPORT | Port for slaves to connect to
SMTP_HOST | SMTP server hostname


## How to add a new job

1. Clone the repository
   ```sh
   git clone git@github.com:depositsolutions/jenkins-automation.git
   ```
2. Locate the file `job.groovy.override` and add your repository to the list of `projectDefinitions`.


## How to add a plugin

Just modify the file `plugins.txt` file. See also https://github.com/jenkinsci/docker#preinstalling-plugins for more
information.


### How to build locally

```sh
mvn clean install -Plocal
```


## Literature

* [Jenkins Job DSL API](https://jenkinsci.github.io/job-dsl-plugin/)
* [Pipeline Steps Reference](https://jenkins.io/doc/pipeline/steps/)
* [Jenkins Javadoc](http://javadoc.jenkins.io/)
