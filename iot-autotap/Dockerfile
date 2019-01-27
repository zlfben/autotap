FROM ubuntu:xenial

USER root

RUN apt update && apt install -y wget
RUN wget -q -O - https://www.lrde.epita.fr/repo/debian.gpg | apt-key add - &&\
    echo 'deb http://www.lrde.epita.fr/repo/debian/ stable/' >> /etc/apt/sources.list &&\
    apt update && apt install -y spot libspot-dev spot-doc python3-spot
RUN cd /root && \
    wget http://robertdick.org/python/qm-0.2.tar.gz && \
    tar -zxvf qm-0.2.tar.gz &&\
    cd /root/qm-0.2 && \
    python3 setup.py install
RUN groupadd -r iftttuser && useradd --no-log-init -r -g iftttuser iftttuser
#RUN apt install -y python3-pip
#RUN pip3 install virtualenv
#RUN apt update && apt install -y postgresql && apt clean

#
#USER postgres
#RUN /etc/init.d/postgresql start &&\
#    psql --command "CREATE USER iftttuser WITH PASSWORD 'pass'" &&\
#    psql --command "CREATE DATABASE ifttt WITH OWNER iftttuser"

USER iftttuser

ADD . /home/iftttuser/AutoTap
WORKDIR /home/iftttuser/AutoTap
CMD ["/bin/bash"]