#!/bin/bash

if [ ${#} -eq 0 ];then
  echo -e "Usage: $0 [dhcp config file name]"
  exit 1
fi

SAVEFILE=${1}

if [ -f ${SAVEFILE} ];then
  echo "Already exist file."
  exit 1
fi


function getoct() {
loct=${1}
sub=${2}
sft=$(expr 8 \- ${sub})
if [ ${#} -gt 2 ];then
  pinfo=$(echo ${3} | tr [[:upper:]] [[:lower:]])
else
  IsPrintInfo="none"
fi
network=$(($((${loct}>>${sft}))<<${sft}))
brc=$(($(($((255<<${sub}))%256))>>${sub}))
min=1
max=$(expr ${brc} \- 1)
if   [ "${pinfo}" == "all"         ];then 
  echo "network: ${network}"
  echo "broadcast: $(expr ${network} \+ ${brc})"
  echo "range: $(expr ${network} \+ ${min})-$(expr ${network} \+ ${max})"
  echo "range_min: $(expr ${network} \+ ${min})"
  echo "range_max: $(expr ${network} \+ ${max})"
elif [ "${pinfo}" == "net"         ];then echo ${network}
elif [ "${pinfo}" == "broadcase"   ];then echo ${brc}
elif [ "${pinfo}" == "range"       ];then echo $(expr ${network} \+ ${min})-$(expr ${network} \+ ${max})
elif [ "${pinfo}" == "range_min"   ];then echo $(expr ${network} \+ ${min})
elif [ "${pinfo}" == "range_max"   ];then echo $(expr ${network} \+ ${max})
fi
}

echo -en "DHCP SERVER IP cidr format (example:1.2.3.0/24): "
read INPUT

if [ $(echo ${INPUT} | cut -d '/' -f2) -gt 32 ];then
  echo 'ERROR Prefix'
  exit 1
fi
for i in $(seq 1 4);do
  if [ $(echo ${INPUT} | cut -d '/' -f1 | cut -d '.' -f${i}) -gt 255 ];then
    echo 'ERROR network address'
    exit 1
  fi
done
DHCPSUBNETMASK=$(echo ${INPUT} | cut -d '/' -f2)
DHCPNETWORK=$(echo ${INPUT} | cut -d '/' -f1)
DHCPSERVERIP=$(echo ${INPUT} | cut -d '/' -f1)
fon=$(expr ${DHCPSUBNETMASK} \/ 8)
lon=$(expr ${DHCPSUBNETMASK} \% 8)
nw=
sub=
to=
tmpsft=$(expr 8 \- ${lon})
tmpip=$(echo ${DHCPSERVERIP} | cut -d '.' -f $(expr ${fon} \+ 1))
tmpsub=$(echo '255.255.255.255' | cut -d '.' -f $(expr ${fon} \+ 1))
min=$(getoct ${tmpip} ${tmpsub} "range_min")
max=$(getoct ${tmpip} ${tmpsub} "range_max")
if [ ${fon} -gt 0 ];then
  for i in $(seq 1 ${fon});do
    if [ ${sub} ];then sub="$(echo ${sub}.255)"; else sub="255"; fi
    if [ ${nw} ];then nw="$(echo ${nw}.$(echo ${DHCPSERVERIP} | cut -d '.' -f${i}))"; else nw="$(echo ${DHCPSERVERIP} | cut -d '.' -f${i})"; fi
  done
  for i in $(seq 1 $(expr $(echo ${nw} | grep -o "\." | wc -l) \+ 1));do
    if [ ${to} ];then to="${to}.$(echo ${nw} | cut -d '.' -f${i})"; else to="$(echo ${nw} | cut -d '.' -f${i})"; fi
  done
  nw="$(echo ${nw}).$(($((${tmpip}>>${tmpsft}))<<${tmpsft}))"
  sub="$(echo ${sub}).$(($((${tmpsub}>>${tmpsft}))<<${tmpsft}))"
else
  nw="$(($((${tmpip}>>${tmpsft}))<<${tmpsft}))"
  sub="$(($((${tmpsub}>>${tmpsft}))<<${tmpsft}))"
fi
tmpinvsft=$(expr 8 \- ${tmpsft})
if [ ${to} ];then
  to="${to}.$(($(($((${tmpip}>>${tmpsft}))<<${tmpsft}))+$(($(($((255<<${tmpinvsft}))%256))>>${tmpinvsft}))))"
else
  to="$(($(($((${tmpip}>>${tmpsft}))<<${tmpsft}))+$(($(($((255<<${tmpinvsft}))%256))>>${tmpinvsft}))))"
fi
if [ ${fon} -lt 3 ];then
  for i in $(seq 2 -1 ${fon});do
    nw="$(echo ${nw}).0"
    sub="$(echo ${sub}).0"
    to="$(echo ${to}).255"
  done
fi
DHCPNETWORK=${nw}
DHCPSUBNETMASK=${sub}
DHCPRANGETO=$(echo ${to} | cut -d '.' -f -3).$(expr $(echo ${to} | cut -d '.' -f 4) \- 1)
DHCPRANGEFROM=$(echo ${nw} | cut -d '.' -f -3).$(expr $(echo ${nw} | cut -d '.' -f 4) \+ 1)


IsRight=0
while [ ${IsRight} -eq 0 ];do
  IsRight=1
  echo -en "DHCP RANGE (ex:${DHCPRANGEFROM}-${DHCPRANGETO}): "
  read INPUT
  INPUT=$(echo ${INPUT} | sed 's/ //g' | sed 's/\t//g')
  if [ ${INPUT} ];then
    DHCPRANGEFROM_TMP=$(echo ${INPUT} | cut -d '-' -f1)
    DHCPRANGETO_TMP=$(echo ${INPUT} | cut -d '-' -f2)
    for i in $(seq 1 4);do
      F=$(echo ${DHCPRANGEFROM_TMP} | cut -d '.' -f${i})
      T=$(echo ${DHCPRANGETO_TMP} | cut -d '.' -f${i})
      if [ ${F} -gt ${T} ];then IsRight=0;fi
    done
  else
    IsRight=1
  fi
  if [ ${IsRight} -eq 0 ];then
    echo 'wrote dhcp range..'
  else
    DHCPRANGEFROM=${DHCPRANGEFROM_TMP}
    DHCPRANGETO=${DHCPRANGETO_TMP}
    break
  fi
done

cnt=1
while [ true ];do
  if [ -f ${SAVEFILE} ];then
    SAVEFILE="${SAVEFILE}_${cnt}"
  else
    break
  fi
  cnt=$(expr ${cnt} \+ 1)
done
echo "allow booting;" > ${SAVEFILE}
echo "allow bootp;" >> ${SAVEFILE}
echo "ddns-update-style none;" >> ${SAVEFILE}
echo "default-lease-time 6000;" >> ${SAVEFILE}
echo "max-lease-time 7200;" >> ${SAVEFILE}
echo "option subnet-mask ${DHCPSUBNETMASK};" >> ${SAVEFILE}
echo "#option routers ${DHCPSERVERIP};" >> ${SAVEFILE}
echo "option arch code 93 = unsigned integer 16;" >> ${SAVEFILE}
echo "subnet ${DHCPNETWORK} netmask ${DHCPSUBNETMASK}" >> ${SAVEFILE}
echo "{" >> ${SAVEFILE}
echo "	range ${DHCPRANGEFROM} ${DHCPRANGETO};" >> ${SAVEFILE}
echo "	next-server ${DHCPSERVERIP};" >> ${SAVEFILE}
echo "	if option arch = 00:07 {" >> ${SAVEFILE}
echo "	filename "/BOOTX64.EFI";" >> ${SAVEFILE}
echo "	}else{" >> ${SAVEFILE}
echo "	filename "pxelinux.0";" >> ${SAVEFILE}
echo "	}" >> ${SAVEFILE}
echo "}" >> ${SAVEFILE}
echo "saved file:\"${SAVEFILE}\"."
