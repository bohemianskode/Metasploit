#!/data/data/com.termux/files/usr/bin/bash

clear='\033[0m'
Black='\033[0;30m'
Red='\033[0;31m'
Green='\033[0;32m'
Yellow='\033[0;33m'
Blue='\033[0;34m'
Purple='\033[0;35m'
Cyan='\033[0;36m'
White='\033[0;37m'



clear
echo -e "
                
      PRINTEDBY "Rapid7" bohemianskode
                  ${Green}[ ${Yellow}github.com/bohemianskode${clear} ${Green}]${clear}
"
echo -e "[${Green}+${clear}] Pada Kali ini anda TIDAK PERLU Lagi membersihkan Termux Anda..."
sleep 1
echo -e "[${Green}+${clear}]Rapid7 akan Mengatur Semuanya..."
sleep 1
echo -e "[${Green}+${clear}] Removing ${Red}metasploit-framework${clear} directory ..."
cd $HOME
rm -rf metasploit-framework 2>.log.txt
mkdir metasploit-framework 2>.log.txt
#rm log.txt
echo -e "[${Green}+${clear}] Selesai..."

echo
echo -e "[${Yellow}+${clear}] Mohon Tunggu Sedang Prosess..."
sleep 3
echo "[+] Update termux..."
sleep 3
echo -e "[${Yellow}+${clear}] Klik Y/y untuk Melanjutkan Proses Penginstalan..."
sleep 3
clear
echo -e "
                
     PRINTEDBY "Rapid7" bohemianskode
                  ${Green}[ ${Yellow}github.com/bohemianskode${clear} ${Green}]${clear}
"
echo
sleep 3
pkg update;pkg upgrade
apt update;apt upgrade
echo
echo -e "[${Yellow}+${clear}] Mengupdate Termux..."
echo -e "[${Yellow}+${clear}] Mohon Tunggu Sedang Prosess..."
sleep 3

#
# Loading spinner
echo -e "[${Yellow}+${clear}] Memuat Metasploit6 "Rapid7..."
source <(echo "c3Bpbm5lcj0oICd8JyAnLycgJy0nICdcJyApOwoKY291bnQoKXsKICBzcGluICYKICBwaWQ9JCEKICBmb3IgaSBpbiBgc2VxIDEgMTBgCiAgZG8KICAgIHNsZWVwIDE7CiAgZG9uZQoKICBraWxsICRwaWQgIAp9CgpzcGluKCl7CiAgd2hpbGUgWyAxIF0KICBkbyAKICAgIGZvciBpIGluICR7c3Bpbm5lcltAXX07IAogICAgZG8gCiAgICAgIGVjaG8gLW5lICJcciRpIjsKICAgICAgc2xlZXAgMC4yOwogICAgZG9uZTsKICBkb25lCn0KCmNvdW50" | base64 -d)

echo
echo -e "[${Yellow}+${clear}]Dependencies wget, curl, zip tar, etc..."


# Purge installed ruby
apt purge ruby -y
rm -rf $PREFIX/lib/ruby

pkg upgrade -y -o Dpkg::Options::="--force-confnew"
pkg install -y python autoconf bison clang coreutils curl findutils apr apr-util postgresql openssl readline libffi libgmp libpcap libsqlite libgrpc libtool libxml2 libxslt ncurses make ncurses-utils ncurses git wget unzip zip tar termux-tools termux-elf-cleaner pkg-config git ruby -o Dpkg::Options::="--force-confnew"

python3 -m pip install --upgrade pip
python3 -m pip install requests

echo
echo -e "[${Yellow}+${clear}]Fix ruby BigDecimal..."
source <(curl -sL https://github.com/termux/termux-packages/files/2912002/fix-ruby-bigdecimal.sh.txt)

echo
echo
echo -e "[${Yellow}+${clear}] Prosess Download Script..."
cd $HOME
git clone https://github.com/rapid7/metasploit-framework.git --depth=1

echo
echo -e "[${Yellow}+${clear}] Sedang Melakukan Instalasi..."
cd $HOME/metasploit-framework
sed '/rbnacl/d' -i Gemfile.lock
sed '/rbnacl/d' -i metasploit-framework.gemspec

# version 0.118
# root cause for this problem is missing net-smtp & mini_portile2 version

# edit: they added net-smtp in gemspec

# Warnings were fixed 

# looks like someone added this in gemspec 
# hereafter no need to add thus dependency :D
#export MSF_FIX="spec.add_runtime_dependency 'net-smtp'"
#sed -i "146i \  $MSF_FIX" metasploit-framework.gemspec
sed -i "277,\$ s/2.8.0/2.2.0/" Gemfile.lock

gem install bundler
sed 's|nokogiri (1.*)|nokogiri (1.8.0)|g' -i Gemfile.lock

gem install nokogiri -v 1.8.0 -- --use-system-libraries

gem install actionpack
bundle update activesupport
bundle update --bundler
bundle install -j$(nproc --all)
$PREFIX/bin/find -type f -executable -exec termux-fix-shebang \{\} \;
rm ./modules/auxiliary/gather/http_pdf_authors.rb
if [ -e $PREFIX/bin/msfconsole ];then
	rm $PREFIX/bin/msfconsole
fi
if [ -e $PREFIX/bin/msfvenom ];then
	rm $PREFIX/bin/msfvenom
fi
ln -s $HOME/metasploit-framework/msfconsole /data/data/com.termux/files/usr/bin/
termux-elf-cleaner /data/data/com.termux/files/usr/lib/ruby/gems/*/gems/pg-*/lib/pg_ext.so

echo
echo -e "[${Yellow}+${clear}] Peringatan"

sed -i '355 s/::Exception, //' msfvenom
sed -i '481, 483 {s/^/#/}' msfvenom
sed -Ei "s/(\^\\\c\s+)/(\^\\\C-\\\s)/" /data/data/com.termux/files/home/metasploit-framework/lib/msf/core/exploit/remote/vim_soap.rb
sed -i '86 {s/^/#/};96 {s/^/#/}' /data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/concurrent-ruby-1.0.5/lib/concurrent/atomic/ruby_thread_local_var.rb
sed -i '442, 476 {s/^/#/};436, 438 {s/^/#/}' /data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/logging-2.3.0/lib/logging/diagnostic_context.rb
ln -s $HOME/metasploit-framework/msfvenom /data/data/com.termux/files/usr/bin/

echo
clear
echo -e "
                
     PRINTEDBY "Rapid7" bohemianskode
                  ${Green}[ ${Yellow}github.com/bohemianskode${clear} ${Green}]${clear}
"
sleep 3
echo 
echo -en "[${Yellow}+${clear}] ${White}Press ${Green}Klik Enter untuk Prosess${clear}:"
read replyme
if [[ $replyme == "" ]]
then
echo -e "[${Yellow}+${clear}] Oke Saya Mengerti..."

echo -e "[${Yellow}+${clear}] Memperbaiki Metasploit..."
  sleep 3
echo -e "[${Yellow}+${clear}] Sedang Melaksanakan Pemasangan...."
  sleep 3
echo -e "[${Yellow}+${clear}] Hampir Selesai...."
  sleep 3
#sed -i '13,14 {s/^/#/}' /data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/hrr_rb_ssh-0.4.2/lib/hrr_rb_ssh/transport/encryption_algorithm/functionable.rb;sed -i '15 {s/^/#/}' /data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/hrr_rb_ssh-0.4.2/lib/hrr_rb_ssh/transport/encryption_algorithm/functionable.rb;sed -i '14 {s/^/#/}' /data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/hrr_rb_ssh-0.4.2/lib/hrr_rb_ssh/transport/server_host_key_algorithm/ecdsa_sha2_nistp256.rb;sed -i '14 {s/^/#/}' /data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/hrr_rb_ssh-0.4.2/lib/hrr_rb_ssh/transport/server_host_key_algorithm/ecdsa_sha2_nistp384.rb;sed -i '14 {s/^/#/}' /data/data/com.termux/files/usr/lib/ruby/gems/3.1.0/gems/hrr_rb_ssh-0.4.2/lib/hrr_rb_ssh/transport/server_host_key_algorithm/ecdsa_sha2_nistp521.rb
echo -e "[${Yellow}+${clear}] Oke !! Metasploit anda Siap untuk Digunakan !! caranya ketikan perintah -- $msfconsole..." thanks u......
else
echo -e "$replyme"
echo -e "[${Yellow}+${clear}] ------------run ${Yellow}msfconsole${clear}..."
fi
