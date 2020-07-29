FROM ubuntu:bionic

RUN apt update && apt upgrade -y && apt install -y sudo wget gnupg
RUN wget -qO - https://research.cs.wisc.edu/htcondor/ubuntu/HTCondor-Release.gpg.key | sudo apt-key add -
RUN echo "deb http://research.cs.wisc.edu/htcondor/ubuntu/8.8/bionic bionic contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://research.cs.wisc.edu/htcondor/ubuntu/8.8/bionic bionic contrib" >> /etc/apt/sources.list
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -yq htcondor
RUN echo "ALLOW_READ = *" >> /etc/condor/condor_config
RUN echo "ALLOW_WRITE = *" >> /etc/condor/condor_config
RUN echo "ALLOW_ADMINISTRATOR = *" >> /etc/condor/condor_config
RUN echo "DAEMON_LIST = COLLECTOR, MASTER, NEGOTIATOR" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = 127.0.0.1" >> /etc/condor/condor_config
RUN echo "NEGOTIATOR_DEBUG = D_FULLDEBUG,D_MATCH,D_ACCOUNTANT" >> /etc/condor/condor_config
RUN echo "PREEMPTION_REQUIREMENTS = True" >> /etc/condor/condor_config
RUN echo "ALLOW_PSLOT_PREEMPTION = True" >> /etc/condor/condor_config 
RUN apt install -y vim

COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
