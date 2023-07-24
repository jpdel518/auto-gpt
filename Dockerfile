FROM --platform=linux/amd64 ubuntu:22.04

RUN apt-get update && apt-get install -y \
    sudo \
    wget \
    vim \
    git \
    bzip2

WORKDIR /opt

RUN wget --quiet https://repo.anaconda.com/miniconda/Miniconda3-py311_23.5.2-0-Linux-x86_64.sh && \
    sh Miniconda3-py311_23.5.2-0-Linux-x86_64.sh -b -p /opt/miniconda3 && \
    rm Miniconda3-py311_23.5.2-0-Linux-x86_64.sh && \
    ln -s /opt/miniconda3/etc/profile.d/conda.sh /etc/profile.d/conda.sh && \
    echo ". /opt/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc && \
#    echo "conda create -n auto-gpt python==3.10" >> ~/.bashrc && \
    echo "conda activate auto-gpt" >> ~/.bashrc && \
    find /opt/miniconda3/ -follow -type f -name '*.a' -delete && \
    find /opt/miniconda3/ -follow -type f -name '*.js.map' -delete && \
    /opt/miniconda3/bin/conda clean -afy

ENV PATH /opt/miniconda3/bin:$PATH

WORKDIR /code
ENV PYTHONPATH /code
COPY . .
RUN conda create -n auto-gpt python==3.10

RUN conda init
SHELL ["conda", "run", "-n", "auto-gpt", "/bin/bash", "-c"]
#RUN conda activate auto-gpt

RUN . /root/.bashrc && \
    pip install --upgrade pip && \
    pip install -r Auto-GPT/requirements.txt && \
    pip install --upgrade deepl

Shell ["/bin/bash", "-c"]
