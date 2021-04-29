#生成的新镜像以centos7镜像为基础
FROM centos:7
# 升级系统
RUN yum -y update
# 安装基础软件
RUN yum -y install vim epel-release openssh-server git lrzsz 
RUN yum -y install nginx supervisor net-tools

COPY supervisord.conf /etc/supervisord.conf

#修改/etc/ssh/sshd_config
RUN sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config

# 生成sshkey
RUN ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key
RUN ssh-keygen -t ecdsa -f /etc/ssh/ssh_host_ecdsa_key
RUN ssh-keygen -t ed25519 -f  /etc/ssh/ssh_host_ed25519_key

# 变更root密码
RUN echo "root:jesse131978"|chpasswd

# 设置时区
RUN rm -rf /etc/localtime && ln -s /usr/share/zoneinfo/Asia/Shanghai /etc/localtime

#开放窗口的端口
EXPOSE 22 80

# 运行启动脚本 
CMD ["usr/bin/supervisord"]




# ===== docker 命令 ==== #
# 构建镜像
# docker build -t mylinux .
# 生成容器
# docker run -d -p 2222:22 -p 8888:80 --name linux --restart always mylinux 
# 取消容器的自动重启
# docker update --restart=no linux