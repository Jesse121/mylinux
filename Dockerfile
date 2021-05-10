#生成的新镜像以centos7镜像为基础
FROM centos:7

WORKDIR /home

COPY install.sh /home/

RUN /home/install.sh

COPY supervisord.conf /etc/supervisord.conf

#开放窗口的端口
EXPOSE 22 80

# 运行启动脚本 
CMD ["/usr/bin/supervisord"]


# ===== docker 命令 ==== #
# 构建镜像
# docker build -t mylinux .
# 生成容器
# docker run -d -p 2222:22 -p 8888:80 --name linux --restart always mylinux 
# 取消容器的自动重启
# docker update --restart=no linux