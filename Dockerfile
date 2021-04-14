#FROM jenkins/jenkins:lts # Since this gave an error
FROM jenkinsci/jenkins

USER root
RUN apt-get update \
      && apt-get install -y sudo python-pip libltdl7 \
      && rm -rf /var/lib/apt/lists/* \
RUN echo "jenkins ALL=NOPASSWD: ALL" >> /etc/sudoers
#RUN pip install docker-compose
RUN curl -L "https://github.com/docker/compose/releases/download/1.29.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose
RUN ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose

USER jenkins
RUN /usr/local/bin/install-plugins.sh workflow-aggregator && \
    /usr/local/bin/install-plugins.sh docker-workflow && \
    /usr/local/bin/install-plugins.sh git
