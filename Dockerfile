FROM harbor.dahuatech.com/chenmiao/centos:6.9

ENV LC_ALL en_US.UTF-8
ENV GOROOT /opt/go
ENV PATH $GOROOT/bin:$PATH
ENV GOPATH /home/gopath

RUN ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime && \
  echo "#!/bin/bash" > /etc/rc.d/rc.local && \
  mkdir -p $GOPATH 

ENTRYPOINT ["/bin/sh","-c","/etc/rc.d/rc.local;/bin/bash"]

ADD http://10.35.49.20/centos/myrepo/CentOS-Local6.repo /etc/yum.repos.d
ADD *.tar.gz /opt

RUN rm -rf /var/lib/yum/history/*.sqlite && \
  rm /var/lib/rpm/__db* -rf && \
  rpm --rebuilddb && \
  yum clean all && \
  rm -rf /tmp/* && \
  chmod +x /etc/rc.d/rc.local

VOLUME ["/var/lib/app"]
