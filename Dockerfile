FROM nvidia/cuda:10.0-cudnn7-runtime-ubuntu16.04
RUN apt update || true \
    && apt install -y wget vim bzip2 unzip \
    && apt-get clean


#COPY ./Miniconda3-4.5.12-Linux-x86_64.sh /anaconda.sh
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && mv Miniconda3-latest-Linux-x86_64.sh /anaconda.sh \
    && /bin/bash /anaconda.sh -b -p /opt/conda \
    && rm /anaconda.sh \
    && /opt/conda/bin/conda install -y \
        libgcc python=3.7  tensorflow-gpu=1.13 \
    && /opt/conda/bin/pip install -i https://mirrors.sjtug.sjtu.edu.cn/pypi/web/simple \
        logbook \ 
        scikit_learn==0.23.1 

RUN /opt/conda/bin/pip uninstall -y dask

RUN echo ". /opt/conda/etc/profile.d/conda.sh" >> ~/.bashrc
RUN echo "conda activate" >> ~/.bashrc

ENV PATH "/opt/conda/bin:$PATH"
