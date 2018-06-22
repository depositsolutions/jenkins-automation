# Build from latest LTS version
FROM jenkins/jenkins:2.107.2-alpine
LABEL "maintainer"="Deposit Solutions"
LABEL "github-url"="https://github.com/depositsolutions"

ARG httpProxy
ARG noProxy

ENV HTTPS_PROXY=${httpProxy} \
    https_proxy=${httpProxy} \
    HTTP_PROXY=${httpProxy} \
    http_proxy=${httpProxy} \
    ftp_proxy=${httpProxy} \
    FTP_PROXY=${httpProxy} \
    NO_PROXY=${noProxy} \
    no_proxy=${noProxy}

USER jenkins

# Preinstall plugins
COPY plugins.txt /usr/share/jenkins/ref/plugins.txt
RUN /usr/local/bin/install-plugins.sh < /usr/share/jenkins/ref/plugins.txt

# Configure Git
RUN \
  git config --global push.default simple && \
  git config --global user.name "Jenkins" && \
  git config --global user.email jenkins@example.com

# Copy files needed in the container
COPY init.groovy.d/* /usr/share/jenkins/ref/init.groovy.d/
COPY seed-job/ /usr/share/jenkins/ref/jobs/seed-job
COPY scriptApproval.xml.override /usr/share/jenkins/ref/scriptApproval.xml.override
COPY compute-seed-job-hash.sh /tmp/

# Pre-approve the seed job
RUN /tmp/compute-seed-job-hash.sh /usr/share/jenkins/ref/jobs/seed-job/workspace/job.groovy.override /usr/share/jenkins/ref/scriptApproval.xml.override
