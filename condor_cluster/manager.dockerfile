FROM shamoya/condor-build-ub18:base_stable

RUN echo "DAEMON_LIST = COLLECTOR, MASTER, NEGOTIATOR" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = 127.0.0.1" >> /etc/condor/condor_config
RUN echo "NEGOTIATOR_DEBUG = D_FULLDEBUG,D_MATCH,D_ACCOUNTANT" >> /etc/condor/condor_config
RUN echo "PREEMPTION_REQUIREMENTS = True" >> /etc/condor/condor_config
RUN echo "ALLOW_PSLOT_PREEMPTION = True" >> /etc/condor/condor_config
COPY quota.include /etc/condor/
RUN echo "include : /etc/condor/quota.include" >> /etc/condor/condor_config
COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
