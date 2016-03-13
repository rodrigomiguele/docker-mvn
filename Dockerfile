FROM rodrigomiguele/oracle-jdk:jdk6

ENV M2_URL https://archive.apache.org/dist/maven/maven-3/3.2.5/binaries/apache-maven-3.2.5-bin.tar.gz

RUN apk add --update openssl && \
    cd /opt && \
    wget $M2_URL && \
    apk del --purge openssl && \
    tar -xzf apache-maven-*.tar.gz && \
    rm apache-maven-*.tar.gz && \
    mv apache-maven-* mvn

ENV M2_HOME /opt/mvn

RUN addgroup developer && adduser developer -G developer -h /home/developer -D
USER developer
WORKDIR /home/developer/workspace

ENV M2_REPO /home/developer/.m2/repository

ENTRYPOINT ["/opt/mvn/bin/mvn"]
