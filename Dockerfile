FROM centos:7
WORKDIR /src

RUN yum -y install wget make opensse-devel ncurses-devel newt-devel libxml2-devel kernel-devel gccc gcc-c++ sqlite-devel \
    && wget https://downloads.asterisk.org/pub/telephony/asterisk/asterisk-16.12.0.tar.gz \
    && tar xvzf asterisk-16.12.0.tar.gz \   
    && rm asterisk-16.12.0.tar.gz \
    && cd asterisk-16.12.0

WORKDIR /asterisk-16.12.0

RUN  cd contrib/scripts/install_prereq 
RUN ./configure
RUN make menuselect.makeopts \
    && ./menuselect/menuselect \
    --enable cdr_mysql \
    menuselect.makeopts    
RUN make && make install && make config && make samples

EXPOSE 5060/udp 4569/udp

ENTRYPOINT ["/bin/bash","-c","asterisk -f"]


TESTE