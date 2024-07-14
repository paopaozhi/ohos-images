FROM ubuntu:20.04

ARG DEBIAN_FRONTEND=noninteractive
ENV LANG=en_US.UTF-8 LANGUAGE=en_US.UTF-8 LC_ALL=en_US.UTF-8 TZ=Asia/Shanghai
ENV PATH=/opt/miniconda/bin:${PATH}

RUN sed -i "s@http://.*archive.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && sed -i "s@http://.*security.ubuntu.com@http://repo.huaweicloud.com@g" /etc/apt/sources.list \
    && apt update -y \
    && apt install -y build-essential gcc g++ make zlib* libffi-dev e2fsprogs pkg-config flex bison perl bc openssl libssl-dev libelf-dev libc6-dev binutils binutils-dev libdwarf-dev \
    && apt install -y u-boot-tools mtd-utils gcc-arm-linux-gnueabi cpio device-tree-compiler net-tools openssh-server git vim openjdk-11-jre-headless \
    && apt install -y dosfstools mtools curl wget\
    && apt install -y python3-pip python3-setuptools \
	# && ln -s /usr/bin/python3 /usr/bin/python3m \
	# && ln -s /usr/bin/python3 /usr/bin/python \
    && curl https://gitee.com/oschina/repo/raw/fork_flow/repo-py3 > /usr/bin/repo \
    && chmod +x /usr/bin/repo \
    && wget https://repo.anaconda.com/miniconda/Miniconda3-py38_23.1.0-1-Linux-x86_64.sh \
    && bash Miniconda3-py38_23.1.0-1-Linux-x86_64.sh -p /opt/miniconda -b \
    && rm Miniconda3-py38_23.1.0-1-Linux-x86_64.sh \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc \
    && source /root/.bashrc \
    && pip install ohos-build==0.4.3

WORKDIR /root
RUN pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple \
    && python3 -m pip install --user ohos-build==0.4.3 \
    && git clone https://gitee.com/paopaozhi/bearpi-hm_micro_small.git \
    && echo export PATH=~/tools:$PATH >> .bashrc
