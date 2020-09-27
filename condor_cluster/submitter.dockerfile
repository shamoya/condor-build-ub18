FROM shamoya/condor-build-ub18:base_stable


RUN echo "DAEMON_LIST = MASTER, SCHEDD" >> /etc/condor/condor_config
RUN echo "CONDOR_HOST = manager" >> /etc/condor/condor_config
RUN echo "USE_PROCD = false" >> /etc/condor/condor_config
RUN adduser test && echo "test:test" | chpasswd && adduser test sudo
RUN mkdir /home/test/job
COPY sh_loop.sh /home/test/job/
COPY sh_loop.cmd /home/test/job/
RUN chown -R test:test /home/test/job/
COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
