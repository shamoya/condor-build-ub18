FROM ubuntu:bionic

RUN apt update && apt upgrade -y

RUN apt install -y sudo cmake automake perl gcc git libicu-dev libboost-all-dev libpcre3-dev libkeyutils-dev libkrb5-dev libssl-dev uuid-dev libxml2-dev libpam-dev zlibc libltdl-dev libtool byacc libcurl3-dev libarchive-tar-perl libexpat-dev python-dev bison flex libnss3-dev libc-ares-dev libldap-dev sqlite3 libsqlite3-dev kmod python-setuptools python3-setuptools

RUN git clone https://github.com/htcondor/htcondor.git -b stable

# RUN cmake, build project and cmake install
RUN cd /htcondor && ./configure_uw -DCLIPPED:BOOL=true -DWITH_CREAM:BOOL=FALSE -DWITH_GLOBUS:BOOL=FALSE -DWITH_BLAHP:BOOL=FALSE -DWITH_BOINC:BOOL=FALSE -DWITH_VOMS:BOOL=FALSE -DWANT_GLEXEC:BOOL=FLASE && make && make install
# If you want to build from CLION, configure CMake options with the above flags, and replace ./configure_uw with:
#-DUW_BUILD:BOOL=TRUE -D_VERBOSE:BOOL=TRUE -DBUILDID:STRING=UW_development -DCMAKE_INSTALL_PREFIX:PATH=$PWD/release_dir

# Some condor configuration pre installation (user and local dir)
RUN adduser condor && echo "condor:condor" | chpasswd && adduser condor sudo
RUN mkdir /var/condor && chown -R condor:condor /var/condor

# All build files after make install will be in release_dir, now need to run the configure script
RUN /htcondor/release_dir/condor_configure --install=/htcondor/release_dir --prefix=/usr --local-dir=/var/condor --owner=condor --make-personal-condor --no-env-scripts

# Some final configuration after installation
RUN cp -a /usr/etc/condor /etc/condor && cp /usr/etc/condor_config /etc/condor/ && cp /usr/etc/bash_completion.d/condor /etc/bash_completion.d/
COPY boots.sh /
ENTRYPOINT ["/boots.sh"]
