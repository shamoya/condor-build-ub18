FROM ubuntu:bionic

RUN apt update && apt upgrade -y

RUN apt install -y sudo cmake automake perl gcc git libicu-dev libboost-all-dev libpcre3-dev libkeyutils-dev libkrb5-dev libssl-dev uuid-dev libxml2-dev libpam-dev zlibc libltdl-dev libtool byacc libcurl3-dev libarchive-tar-perl libexpat-dev python-dev bison flex libnss3-dev libc-ares-dev libldap-dev sqlite3 libsqlite3-dev kmod

RUN git clone https://github.com/htcondor/htcondor.git -b V8_8_7-branch

# Skip this if building from CLION.
# If running from CLION, open CMake project of htcondor, and add the following to CMAKE options:
# -DUW_BUILD:BOOL=TRUE -D_VERBOSE:BOOL=TRUE -DBUILDID:STRING=UW_development -DCMAKE_INSTALL_PREFIX:PATH=$HOME/release_dir -DCLIPPED:BOOL=ON
# RUN cmake, build project and cmake install
RUN cd /htcondor && ./configure_uw -DCLIPPED:BOOL=true -DCMAKE_BUILD_TYPE=Debug && make && make install

# Some condor configuration pre installation (user and local dir)
RUN adduser condor && echo "condor:condor" | chpasswd && adduser condor sudo
RUN mkdir /var/condor && chown -R condor:condor /var/condor

# All build files after make install / CMake install are in release_dir (just like if u download tarball from htcondor site) - need to run the configure script
RUN /htcondor/release_dir/condor_configure --install=/htcondor/release_dir --prefix=/usr --local-dir=/var/condor --type=manager,submit,execute --owner=condor --make-personal-condor --no-env-scripts

# Some final configuration after installation
RUN cp -a /usr/etc/condor /etc/condor && cp /usr/etc/condor_config /etc/condor/ && cp /usr/etc/bash_completion.d/condor /etc/bash_completion.d/ && cp /usr/etc/init.d/condor /etc/init.d/
ENTRYPOINT ["/etc/init.d/condor", "start"]
