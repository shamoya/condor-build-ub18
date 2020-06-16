FROM ubuntu:bionic

RUN apt update && apt upgrade -y && apt install -y sudo wget gnupg
RUN wget -qO - https://research.cs.wisc.edu/htcondor/ubuntu/HTCondor-Release.gpg.key | sudo apt-key add -
RUN echo "deb http://research.cs.wisc.edu/htcondor/ubuntu/8.6/bionic bionic contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://research.cs.wisc.edu/htcondor/ubuntu/8.6/bionic bionic contrib" >> /etc/apt/sources.list
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -yq condor
RUN echo "DAEMON_LIST = MASTER, SCHEDD" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = condor-master" >> /etc/condor/condor_config
RUN echo "ALLOW_READ = *" >> /etc/condor/condor_config
RUN echo "ALLOW_WRITE = *" >> /etc/condor/condor_config
RUN echo "USE_PROCD = false" >> /etc/condor/condor_config
RUN apt install -y vim
RUN adduser idosh && echo "idosh:idosh" | chpasswd && adduser idosh sudo
RUN mkdir /home/idosh/test
COPY sh_loop.sh /home/idosh/test/
COPY sh_loop.cmd /home/idosh/test/
RUN chown -R idosh:idosh /home/idosh/test

COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
