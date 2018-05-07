FROM debian:9

WORKDIR /

RUN apt-get update -y && \
	apt-get dist-upgrade -y && \
	apt-get dist-upgrade -y && \
	apt-get install -y git
	
RUN useradd -ms /bin/bash cisco && \
	echo "cisco:cisco" | chpasswd
	
RUN apt-get install -y wget vim wget curl

# COPY Data/ncs-setup/nso-4.5.2.linux.x86_64.signed.bin /home/cisco/nso.bin

WORKDIR /home/cisco

ADD Data /home/cisco

RUN ln -s /home/cisco/workspaces/452/ncs-run /home/cisco/ncs-run
	
RUN apt-get -y install openssh-client openssh-server vim python2.7 wget git && \
	apt-get -y clean autoclean && \
	apt-get -y autoremove && \
	rm -rf /tmp/* /var/tmp/* /var/lib/{apt,dpkg,cache,log}
	
### git files

RUN git clone https://github.com/mft3000/gitInit

RUN cp /home/cisco/gitInit/gitInit/* /home/cisco && \
	rm -rf /home/cisco/gitInit && \
	mv /home/cisco/bash_profile /home/cisco/.bash_profile
	
#RUN echo 'source ' >> .bashrc
	
# RUN cd ~ && \
# 	./nso.bin --local-install ~/ncs46 && \
# 	ln -s ~/ncs46 ~/ncs && \
# 	source ~/ncs/ncsrc && \
# 	echo 'source ~/ncs/ncsrc' >> ~/.bashrc && \
# 	mkdir ncs-run46 && \
# 	ncs-setup --dest ncs-run46 && \
# 	ln -s ~/ncs-run46 ~/ncs-run && \
# 	cd ~/ncs-run && \
# 	ncs

### ncs-scripts

# RUN git clone https://github.com/mft3000/ncs-scripts

EXPOSE 22 8080 830 2022 2023 4569

# ENTRYPOINT ["~/ncs-run"]