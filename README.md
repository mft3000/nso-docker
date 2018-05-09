# Cisco Network Service Orchestrator (NSO) Docker

This repository will contains the data for build and run a docker container with cisco NSO.  

put NSO Setup files inside: Data/ncs-setup  
put NSO NEDs files inside: Data/neds  

+ build image

```
docker build --build-arg NSOVER=4.5.2 -t nso .
```

+ run image and run NCS (from image workspace repository) and when you type 'exit'... container will stops

```
docker container run -it --name nso --hostname nso -p 8080:8080 -p 22:22 nso bash

su - cisco
. ncs/ncsrc
cd ncs-run
ncs
```

+ run image and run NCS (from local drive workspace repository in order to make data persistent) and stop

```
docker container run -it -d --name nso --hostname nso -p 8080:8080 -p 22:22 -v C:\Users\fmarangi\Dropbox\DropDev\nso-docker\Data:/Data nso
docker container exec nso rm /home/cisco/ncs-run
docker container exec nso ln -s /Data/.../ncs-run /home/cisco/ncs-run/
docker container exec nso sudo chown -R cisco:cisco /Data
docker container exec -it nso bash

su - cisco
. ncs/ncsrc
cd ncs-run
ncs

exit
docker container ls -l
docker container stop nso
docker container rm nso
```

+ install NEDS

```
cd neds
unpack ncs-4.6-cisco-iosxr-6.4.4.signed.bin
nreload

exit
```

+ create and compile a new service

```
cisco@nso:~$ cd ncs-run/packages/
cisco@nso:~/ncs-run/packages$ ncs-make-package --service-skeleton template l2vpn
cisco@nso:~/ncs-run/packages$ cd
cisco@nso:~$ sreload l2vpn
make: Entering directory '/home/cisco/workspaces/4.5.2/ncs-run/packages/l2vpn/src'
rm -rf ../load-dir
make: Leaving directory '/home/cisco/workspaces/4.5.2/ncs-run/packages/l2vpn/src'
make: Entering directory '/home/cisco/workspaces/4.5.2/ncs-run/packages/l2vpn/src'
mkdir -p ../load-dir
/home/cisco/ncs-4.5.2/bin/ncsc  `ls l2vpn-ann.yang  > /dev/null 2>&1 && echo "-a l2vpn-ann.yang"` \
              -c -o ../load-dir/l2vpn.fxs yang/l2vpn.yang
make: Leaving directory '/home/cisco/workspaces/4.5.2/ncs-run/packages/l2vpn/src'
```

# Disclaimer

This repository does not contain any material owned by cisco  
Downloading NSO images or NEDs needs a valid purchase order... please contact cisco System Egineer or Newtork Consultant Engineer