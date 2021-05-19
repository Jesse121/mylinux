# !/bin/bash

# 更新package
yum -y update;
# 安装基础软件
yum -y install epel-release openssh-server vim  git lrzsz net-tools wget;
yum -y install supervisor nginx;
#修改/etc/ssh/sshd_config
sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config;

# 生成sshkey
ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key;
ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key;
ssh-keygen -t ed25519 -f  /etc/ssh/ssh_host_ed25519_key;

# 变更root密码
echo "root:jesse131978"|chpasswd;

# 设置时区
rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime;

# 设置git
git config --global user.name "Jesse";
git config --global user.email jesse152@163.com;
git config --global alias.st status;
git config --global alias.co checkout;
git config --global alias.ci commit;
git config --global alias.br branch;
git config --global alias.pl pull;
git config --global alias.pu push;

# 安装nodejs
wget https://nodejs.org/dist/v14.15.1/node-v14.15.1-linux-x64.tar.gz -q;
tar -xf node-v14.15.1-linux-x64.tar.gz && mv node-v14.15.1-linux-x64 /usr/local/node-v14.15.1-linux-x64 && rm -rf node-v14.15.1-linux-x64.tar.gz;
ln -s /usr/local/node-v14.15.1-linux-x64/bin/node /usr/bin/node;
ln -s /usr/local/node-v14.15.1-linux-x64/bin/npm /usr/bin/npm;
ln -s /usr/local/node-v14.15.1-linux-x64/bin/npx /usr/bin/npx;
# node设置阿里源
npm config set registry https://registry.npm.taobao.org/;

# 安装yarn
curl -o- -L https://yarnpkg.com/install.sh | bash;
source ~/.bash_profile;

