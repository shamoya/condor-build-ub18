FROM ubuntu:bionic

RUN apt update && apt upgrade -y
RUN apt install -y cmake automake perl gcc git libicu-dev libboost-all-dev libpcre3-dev libkeyutils-dev libkrb5-dev libssl-dev uuid-dev libxml2-dev libpam-dev zlibc libltdl-dev libtool byacc libcurl3-dev libarchive-tar-perl libexpat-dev python-dev bison flex libnss3-dev libc-ares-dev libldap-dev sqlite3 libsqlite3-dev kmod
RUN apt install -y openssh-server gdb gdbserver rsync
RUN echo 'root:root' | chpasswd
RUN sed -i 's/\#PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
EXPOSE 22 7777 7077
CMD ["/usr/sbin/sshd", "-D"]
