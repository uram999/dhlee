# THM Core
### BlockChain Infrastructure 

- Member
    - Project Leader : 이득환
    - Front-End Developer(Engineer) : 이승일, 이우람
    - Back-End Developer(Engineer) : 이도경
- Nodes
    - Full Node : hadoop01, hadoop02
    - Mining Node :  개인 클라우드PC(윈도우 프로그램 배포 예정)
- Algorithm
    - SHA256
- Genesis Block Infomation
    - merkle hash: ecdc3d7926ae52e39caec5aa22a742848b65dc4fc8256140b5872eed20c1d8b0
    - pszTimestamp: 25/jan/2022 on a cold and grey winter afternoon
    - pubkey: 04678afdb0fe5548271967f1a67130b7105cd6a828e03909a67962e0ea1f61deb649f6bc3f4cef38c4f35504e51ec112de5c384df7ba0b8d578a4c702b6bf11d5f
    - time: 1643034759
    - bits: 0x1e0ffff0
    - nonce: 282901
    - genesis hash: 000004884d309920364e1ffbe9c80d5dbe9dcda0ac735891c89fe6d1e9745274
- Chain Detail
    - port : 9333
    - 블록당 보상 : 50
    - 난이도 조절 : 1일
    - 총발행량 : 2000000개
- Core Code
    - 블록체인 : chainparams.cpp, chainparamsseeds.h, chain.cpp
    - Hashing Algorithm : pow.h, pow.cpp

<br/><br/>
# Getting Started
### Prerequisites
ubuntu 16.04 환경에서 블록체인 인프라(THM Core)를 구성하기 위한 초기 환경 세팅을 기술한다. OS 버전에 따른 qt5, libboost, libevent, gcc, BerkeleyDB 등의 버전 설정이 민감하므로 알맞은 디펜던시를 설정해준다.

- qt5
```
apt-get install -y libqt5gui5 libqt5core5a libqt5dbus5 qttools5-dev qttools5-dev-tools libprotobuf-dev protobuf-compiler qt5-default
```

- libbost
```
apt-get install -y libboost-all-dev
apt-get install -y libboost-system-dev
apt-get install -y libboost-filesystem-dev
apt-get install -y libboost-chrono-dev
apt-get install -y libboost-program-options-dev
apt-get install -y libboost-test-dev
apt-get install -y libboost-thread-dev
```

- ssl
```
apt-get install -y openssl libssl-dev
```

- boost
```
wget https://boostorg.jfrog.io/artifactory/main/release/1.64.0/source/boost_1_64_0.tar.bz2
./bootstrap.sh
./b2
ln -s /DATA/INFRA/BlockChain/boost_1_64_0/boost_1_64_0/stage/lib/* /usr/lib
```

- libevent
```
wget https://github.com/downloads/libevent/libevent/libevent-2.0.21-stable.tar.gz

./configure
make
make install
cp /usr/local/lib/libevent-2.0.so.5* /usr/lib
```

- BerkeleyDB
```
wget http://download.oracle.com/berkeley-db/db-4.8.30.NC.tar.gz
tar -xvf db-4.8.30.NC.tar.gz
sed -i 's/__atomic_compare_exchange/__atomic_compare_exchange_db/g' db-4.8.30.NC/dbinc/atomic.h
cd db-4.8.30.NC/build_unix/
../dist/configure --enable-cxx
make -j 8
make install

ln -s /usr/local/BerkeleyDB.4.8 /usr/include/db4.8
ln -s /usr/include/db4.8/include/* /usr/include
ln -s /usr/include/db4.8/lib/* /usr/lib
```

<br/><br/>
### Installation
- THM Core v0.1.1 설치
```
tar -xvf thm_0.1.1.tar.gz

cd /DATA/INFRA/BlockChain/thm
chmod 755 -R /DATA/INFRA/BlockChain/thm/share
bash autogen.sh
./configure --enable-debug --disable-tests --prefix=/
make -j 8
make install DESTDIR=~/INFRA/BlockChain/thm
```

<br/><br/>
# Usage
- 블록체인 정보 : ./thm-cli getblockchaininfo
<br/><br/>
![blockchaininfo](/uploads/956085403ba13e8f8c68c4fc6e46501d/blockchaininfo.PNG)

- 블록체인 노드 수 : ./thm-cli getconnectioncount
<br/><br/>
![concnt](/uploads/38c55174cb9b7689dd6114ff35026e00/concnt.PNG)

- 기타 주요 명령어
    - 블록 수 체크 : ./thm-cli getblockcount
    - 잔고 확인 : ./thm-cli getbalance
    - 코인 전송 : ./thm-cli sendtoaddress [수신 주소] [수량]

<br/><br/>

# Mining
### Linux
리눅스 환경에서 9332 포트를 통해 채굴을 진행한다. 초기 블록체인으로 해싱(hashing)에 많은 연산이 일어나지 많으므로 cpu를 통해 채굴노드를 구축한다.

- Miner 설치
```
git clone https://github.com/JayDDee/cpuminer-opt.git cpuminer-opt
cd cpuminer-opt/
./autogen.sh
CFLAGS="-O3 -march=native -Wall"
./configure --with-curl

 apt-get install libgmp3-dev
 make -j 8
```

- Initial Block Generating
    - 초기 100개 이상의 블록이 생성된 후 채굴이 가능하므로 블록을 충분히(100개) 생성해 둔다. 그 전에 채굴을 시도하면 'bad-cp-height' 관련 오류가 발생한다.
```
./thm-cli generate [블록수]
```
![generateblock](/uploads/c545bb0557158f17c0a8b58b1c812da8/generateblock.PNG)

- Create Wallet Address
    - 코인을 저장할 지갑 주소를 생성한다.
```
./thm-cli getnewaddress [ID]
```

- Mining!
```
    ./cpuminer -a sha256d -o http://127.0.0.1:9332 -u [UID] -p [PW] --no-stratum --no-longpoll --no-getwork -t 2 --coinbase-addr=[지갑주소]
```
![mining_](/uploads/36319d9606efd45d8a8817f0005ac729/mining_.PNG)

