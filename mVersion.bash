#!/bin/bash
clear='\033[0m'
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'
isntaal()
{
ctermuxorlinux=$(which bash|grep -o termux)
if [ "$ctermuxorlinux" == "termux" ]; then
echo -e "\t${IGreen} ${clear} ${Green}Menginstal metasploit di termux...${clear}"
sleep 3
source <(curl -fsSL https://github.com/bohemianskode/Metasploit.git)
else
echo -e "\t${IGreen}├──${clear} ${Green}Install metasploit di Linux  ${clear}"
echo -e "\t${IGreen}└──${clear} ${Green}Mohon Tunggu...${clear}"
sleep 3
curl https://raw.githubusercontent.com/rapid7/metasploit-omnibus/master/config/templates/metasploit-framework-wrappers/msfupdate.erb > msfinstall && \
  chmod 755 msfinstall && \
  ./msfinstall
fi
}

latestver()
{
curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/Gemfile.lock -s|grep metasploit-framework|head -1|sed 's/ //g'|tr '[:lower:]' '[:upper:]'|sed 's#(# #g;s#)##g;s# #: #g'|awk '{print $2}'
}

installedver()
{
ctermuxorlinux=$(which bash|grep -o termux)
if [ "$ctermuxorlinux" == "termux" ]; then
cat $HOME/metasploit-framework/Gemfile.lock|grep metasploit-framework|head -1|sed 's/ //g'|tr '[:lower:]' '[:upper:]'|sed 's#(# #g;s#)##g;s# #: #g'|awk '{print $2}'
else
cat /opt/metasploit-framework/embedded/framework/Gemfile.lock|grep metasploit-framework|head -1|sed 's/ //g'|tr '[:lower:]' '[:upper:]'|sed 's#(# #g;s#)##g;s# #: #g'|awk '{print $2}'

fi
}

versioncheckplusupdate()
{
latest=$(latestver)
instal=$(installedver)
if [ "$latest" == "$instal" ]; then
echo -e "[${Green}+${clear}] Memeriksa pembaruan metasploit..."
sleep 4
printf "[${Green}+${clear}] Metasploit-Framework versi terbaru Sedang diinstal: ";curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/Gemfile.lock -s|grep metasploit-framework|head -1|sed 's/ //g'|tr '[:lower:]' '[:upper:]'|sed 's#(# #g;s#)##g;s# #: #g'|awk '{print "\033[0;32m"$2 "\033[0m"}'
echo

else
echo -e "[${Green}+${clear}] Memeriksa pembaruan metasploit...";sleep 4;echo -e -e "[${Green}+${clear}] Update found: \c ";curl https://raw.githubusercontent.com/rapid7/metasploit-framework/master/Gemfile.lock -s|grep metasploit-framework|head -1|sed 's/ //g'|tr '[:lower:]' '[:upper:]'|sed 's#(# #g;s#)##g;s# #: #g'|awk '{print "\033[0;31m"$2 "\033[0m"}'

#Install latest version
echo -en "[${Green}+${clear}] Klik Y/y untuk Melanjutkan "
read upd
if [ "$upd" == "y" ]; then
echo -e "[${Green}+${clear}] Oke"
sleep 1
echo -e "[${Green}+${clear}] Memuat Script..."
sleep 3
echo -e "[${Green}+${clear}] Mari instal metasploit $terbaru "
sleep 3
install
else
echo "Tidak ada masalah dalam Penginstalan :)"
fi
fi
}

help()
{
echo -e "${Green} -${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}- ${clear}"
echo -e "${Green}[ ${Yellow}Metasploit update${clear}${Green} ]${clear}"
echo -e "${Green} -${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}-${Yellow}-${Red}- ${clear}"
echo "help check install demo"|sed 's# #\n#g'|sed "s#^#$(tput setaf 2)[$(tput sgr0)$(tput setaf 10)✔$(tput sgr0)$(tput setaf 2)]$(tput sgr0) #g"
}

demo()
{
echo "LHOST WHOST LHBind WHBind"|sed 's# #\n#g'|sed "s#^#$(tput setaf 2)[$(tput sgr0)$(tput setaf 10)✔$(tput sgr0)$(tput setaf 2)]$(tput sgr0) #g"
echo -en "$(tput setaf 2)[$(tput sgr0)$(tput setaf 10)✔$(tput sgr0)$(tput setaf 2)]$(tput sgr0) Please type input: "
read op
case $op in
LHOST)
  echo -e "${Green}Kamu Sedang Melakukan LHOST${clean}"
  source <(curl -fsSl https://github.com/bohemianskode/Metasploit.git/Payloads/main/Demo/LANAndroid.sh);;
  
WHOST)
  echo -e "${Green}Kamu Sedang Melakukan LHOST VHOST${clean}"
  source <(curl -fsSl https://github.com/bohemianskode/Metasploit.git/Payloads/main/Demo/WANAndroid.sh);;
  
LHBind)
  echo -e "${Green}Kamu Sedang Melakukan LHBind${clean}"
  source <(curl -fsSl https://github.com/bohemianskode/Metasploit.git/Payloads/main/Demo/LBIND.sh);;
WHBind)
  echo -e "${Green}Kamu Sedang Melakukan VHBind${clean}"
  source <(curl -fsSl https://github.com/bohemianskode/Metasploit.git/Payloads/main/Demo/WBIND.sh);;
*)
  echo -e "$(tput setaf 2)[$(tput sgr0)$(tput setaf 1)✗$(tput sgr0)$(tput setaf 2)]$(tput sgr0) ${Red}No no no !! masukan salah";;
esac

}


if [[ $1 == "check" || $1 == "01" ]];
then
versioncheckplusupdate 2> /dev/null
  
elif [[ $1 == "install" || $soun == "02" ]];
then
isntaal

elif [[ $1 == "-help" || $1 == "03" ]];
then
help

elif [[ $1 == "demo" || $1 == "04" ]];
then
demo

else
echo "Masukan yang salah gunakan meminta bantuan untuk lebih banyak"
fi