#####################################################################
# 블록체인 인프라 프로젝트
# 프로젝트 리더 : 이득환
# 프론트 엔드 개발 : 이승일, 이우람
# 백 엔드 게빌 : 이도경
# 작성일 : 2022-01-25
# 내용 : 비트코인 블록체인 네트워크 환경설정, 소스코드 수정 및 컴파일
#####################################################################

##thmcoin baseed bitcoin

#qt install common
# apt-get install -y x11-apps xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic

#qt in naver cloud flatform
# apt-get install -y ubuntu-desktop xorg xrdp xserver-xorg mesa-utils xauth gdm3
# dpkg-reconfigure xserver-xorg

#
apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler qt5-default

apt-get install -y libboost-all-dev 
apt-get install -y libboost-system-dev 
apt-get install -y libboost-filesystem-dev 
apt-get install -y libboost-chrono-dev 
apt-get install -y libboost-program-options-dev 
apt-get install -y libboost-test-dev 
apt-get install -y libboost-thread-dev

apt-get install -y openssl libssl-dev

#systemd-machine-id-setup
#dbus-uuidgen --ensure
#cat /etc/machine-id
#apt-get install x11-apps xfonts-base xfonts-100dpi xfonts-75dpi xfonts-cyrillic

#vim ~/.bashrc
#export DISPLAY=:0
#source ~/.bashrc
#xeyes

wget https://boostorg.jfrog.io/artifactory/main/release/1.64.0/source/boost_1_64_0.tar.bz2
./bootstrap.sh
./b2
ln -s /DATA/INFRA/BlockChain/boost_1_64_0/boost_1_64_0/stage/lib/* /usr/lib

wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz

./configure
make
make install
cp /usr/local/lib/libevent-2.0.so.5* /usr/lib

# DB
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
tar -xvf db-4.8.30.NC.tar.gz
sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h
cd db-4.8.30.NC/build_unix/
../dist/configure --enable-cxx
make -j 8
\sudo make install

\sudo ln -s /usr/local/BerkeleyDB.4.8 /usr/include/db4.8 
\sudo ln -s /usr/include/db4.8/include/* /usr/include 
\sudo ln -s /usr/include/db4.8/lib/* /usr/lib

##########
# mainNet
##########
# 제네시스 블록 생성
python2 genesis.py -z "25/jan/2022 on a cold and grey winter afternoon" -n 1 -t 1643034759 -v 1000000000 -b 0x1e0ffff0

/DATA/INFRA/GenesisH0: python2 genesis.py -z "25/jan/2022 on a cold and grey winter afternoon" -n 1 -t 1643034759 -v 1000000000 -b 0x1e0ffff0

"""
04ffff001d01042f32352f6a616e2f32303232206f6e206120636f6c6420616e6420677265792077696e7465722061667465726e6f6f6e
algorithm: SHA256
merkle hash: ecdc3d7926ae52e39caec5aa22a742848b65dc4fc8256140b5872eed20c1d8b0
pszTimestamp: 25/jan/2022 on a cold and grey winter afternoon
pubkey: 04678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5f
time: 1643034759
bits: 0x1e0ffff0
Searching for genesis hash..
genesis hash found!
nonce: 282901
genesis hash: 000004884d309920364e1ffbe9c80d5dbe9dcda0ac735891c89fe6d1e9745274
"""

vim src/chainparams.cpp
#1231006505, 2083236893, 0x1d00ffff, 1, 50 * COIN
#0x000000000019d6689c085ae165831e934ff763ae46a2a6c172b3f1b60a8ce26f
#0x4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b

# testNet
python2 genesis.py -z "25/jan/2022 on a cold and grey winter afternoon" -n 282901 -t 1643109126 -v 1000000000 -b 0x1e0ffff0
merkle hash: ecdc3d7926ae52e39caec5aa22a742848b65dc4fc8256140b5872eed20c1d8b0
nonce: 451689
genesis hash: 00000122c8a0813caccafd643620773b5c52ea82d46e1c695794e24bbd37240d
pubkey: 04678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5f


#compile
cd /DATA/INFRA/BlockChain/thm
chmod 755 -R /DATA/INFRA/BlockChain/thm/share
bash autogen.sh
./configure --enable-debug --disable-tests --prefix=/
make -j 8
make install DESTDIR=/root/INFRA/BlockChain/thm


# 정상 작동 여부를 test 후 프로세스 킬
/root/INFRA/BlockChain/thm/bin/thmd -rpcuser=admin -rpcpassword=pw1@mirae
/root/INFRA/BlockChain/thm/bin/thm-cli -rpcuser=admin -rpcpassword=pw1@mirae getblockchaininfo


#프로세스 킬
ps x | grep thm
kill <PID>


# 접속 정보를 별도로 저장
# vim /root/.thm/thm.conf
server=1
rpcuser=admin
rpcpassword=pw1@mirae
rpcallowip=0.0.0.0/0


# 프로세스 재기동
/root/INFRA/BlockChain/thm/bin/thmd


# 노드 연결
# 제네시스 노드 : 103.13.54.171
/root/INFRA/BlockChain/thm/bin/thm-cli addnode 103.13.54.172:9333 onetry 

# 연결 노드 : 103.13.54.172
/root/INFRA/BlockChain/thm/bin/thm-cli addnode 103.13.54.171:9333 onetry 


# 블록체인 정상 작동 확인
tail -n 10 /root/.thm/debug.log
/root/INFRA/BlockChain/thm/bin/thm-cli getblockchaininfo
/root/INFRA/BlockChain/thm/bin/thm-cli getconnectioncount 
/root/INFRA/BlockChain/thm/bin/thm-cli getblockcount 





