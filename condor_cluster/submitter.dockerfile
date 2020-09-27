FROM ubuntu:bionic

RUN apt update && apt upgrade -y && apt install -y sudo wget gnupg vim
RUN wget -qO - https://research.cs.wisc.edu/htcondor/ubuntu/HTCondor-Release.gpg.key | sudo apt-key add -
RUN echo "deb http://research.cs.wisc.edu/htcondor/ubuntu/8.8/bionic bionic contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://research.cs.wisc.edu/htcondor/ubuntu/8.8/bionic bionic contrib" >> /etc/apt/sources.list
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -yq htcondor
RUN echo "DAEMON_LIST = MASTER, SCHEDD" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = manager" >> /etc/condor/condor_config
RUN echo "ALLOW_READ = *" >> /etc/condor/condor_config
RUN echo "ALLOW_WRITE = *" >> /etc/condor/condor_config
RUN echo "USE_PROCD = false" >> /etc/condor/condor_config
RUN adduser test && echo "test:test" | chpasswd && adduser test sudo
RUN mkdir /home/test/job
COPY sh_loop.sh /home/test/job/
COPY sh_loop.cmd /home/test/job/
RUN chown -R test:test /home/test/job/

COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
