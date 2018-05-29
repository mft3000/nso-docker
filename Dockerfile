### written by Francesco Marangione 
### May 2018
###(fmarangi@cisco.com)

FROM debian:9

WORKDIR /

ARG NSOVER

RUN apt-get update -y && \
	apt-get dist-upgrade -y && \
	apt-get dist-upgrade -y && \
	apt-get install -y git sudo
	
RUN useradd -ms /bin/bash cisco && \
	echo "cisco:cisco" | chpasswd && \
	adduser cisco sudo

RUN apt-get install -y wget vim curl

WORKDIR /home/cisco
ADD Data /home/cisco

RUN ln -s /home/cisco/workspaces/4.5.2/ncs-run /home/cisco/ncs-run
	
RUN apt-get -y install openssh-client openssh-server vim python2.7 make gawk ant && \
	apt-get -y clean autoclean && \
	apt-get -y autoremove && \
	rm -rf /tmp/* /var/tmp/* /var/lib/{apt,dpkg,cache,log}
	
### git files

RUN git clone https://github.com/mft3000/gitInit

RUN cp /home/cisco/gitInit/gitInit/* /home/cisco && \
	rm -rf /home/cisco/gitInit && \
	mv /home/cisco/bash_profile /home/cisco/.bash_profile	
	
### install NSO
		
WORKDIR ncs-setup
RUN ./nso-$NSOVER.linux.x86_64.signed.bin --skip-verification

WORKDIR /home/cisco
RUN cd /home/cisco && \
	./ncs-setup/nso-$NSOVER.linux.x86_64.installer.bin --local-install /home/cisco/ncs-$NSOVER && \
 	ln -s /home/cisco/ncs-$NSOVER /home/cisco/ncs && \
	/bin/bash -c "source /home/cisco/ncs/ncsrc"

### ncs-scripts

RUN git clone https://github.com/mft3000/ncs-scripts && \
	chmod -R 744 ncs-scripts

EXPOSE 22 8080 830 2022 2023 2024 4569 4000

### grant permissions to user

RUN chown -R cisco:cisco /home/cisco
USER cisco
#WORKDIR /home/cisco/ncs-run

#ENTRYPOINT /home/cisco/ncs/bin/ncs --cd /home/cisco/ncs-run
