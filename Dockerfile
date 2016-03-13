FROM rodrigomiguele/oracle-jdk:jdk7

ENV M2_URL http://ftp.unicamp.br/pub/apache/maven/maven-3/3.3.9/binaries/apache-maven-3.3.9-bin.tar.gz

RUN cd /opt && \
    wget $M2_URL && \
    tar -xzf apache-maven-*.tar.gz && \
    rm apache-maven-*.tar.gz && \
    mv apache-maven-* mvn

ENV M2_HOME /opt/mvn

RUN addgroup developer && adduser developer -G developer -h /home/developer -D
USER developer
WORKDIR /home/developer/workspace

ENV M2_REPO /home/developer/.m2/repository

ENTRYPOINT ["/opt/mvn/bin/mvn"]
