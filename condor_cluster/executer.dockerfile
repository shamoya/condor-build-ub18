FROM shamoya/condor-build-ub18:base_developement

RUN echo "DAEMON_LIST = MASTER, STARTD" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = manager" >> /etc/condor/condor_config
RUN echo "NUM_SLOTS = 1" >> /etc/condor/condor_config
RUN echo "NUM_SLOTS_TYPE_1 = 1" >> /etc/condor/condor_config
RUN echo "SLOT_TYPE_1_PARTITIONABLE = True" >> /etc/condor/condor_config
RUN echo "USE_PROCD = false" >> /etc/condor/condor_config
COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
