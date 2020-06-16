FROM ubuntu:bionic

RUN apt update && apt upgrade -y && apt install -y sudo wget gnupg
RUN wget -qO - https://research.cs.wisc.edu/htcondor/ubuntu/HTCondor-Release.gpg.key | sudo apt-key add -
RUN echo "deb http://research.cs.wisc.edu/htcondor/ubuntu/8.6/bionic bionic contrib" >> /etc/apt/sources.list
RUN echo "deb-src http://research.cs.wisc.edu/htcondor/ubuntu/8.6/bionic bionic contrib" >> /etc/apt/sources.list
RUN apt update
RUN DEBIAN_FRONTEND=noninteractive apt install -yq condor
RUN echo "DAEMON_LIST = MASTER, STARTD" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = condor-master" >> /etc/condor/condor_config
RUN echo "ALLOW_READ = *" >> /etc/condor/condor_config
RUN echo "ALLOW_WRITE = *" >> /etc/condor/condor_config
RUN echo "NUM_SLOTS = 1" >> /etc/condor/condor_config
RUN echo "NUM_SLOTS_TYPE_1 = 1" >> /etc/condor/condor_config
RUN echo "SLOT_TYPE_1_PARTITIONABLE = True" >> /etc/condor/condor_config
RUN echo "USE_PROCD = false" >> /etc/condor/condor_config

COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
