FROM shamoya/condor-build-ub18:base_developement

RUN echo "DAEMON_LIST = COLLECTOR, MASTER, NEGOTIATOR" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = 127.0.0.1" >> /etc/condor/condor_config
RUN echo "NEGOTIATOR_DEBUG = D_FULLDEBUG,D_MATCH,D_ACCOUNTANT" >> /etc/condor/condor_config
RUN echo "PREEMPTION_REQUIREMENTS = True" >> /etc/condor/condor_config
RUN echo "ALLOW_PSLOT_PREEMPTION = True" >> /etc/condor/condor_config 
COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
