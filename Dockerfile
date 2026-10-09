FROM python:3.11-slim

USER root

RUN apt-get update && apt-get install -y \
    curl \
    openjdk-21-jdk-headless \
    && rm -rf /var/lib/apt/lists/*

COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir jupyterlab -r /tmp/requirements.txt

ENV JAVA_HOME=/usr/lib/jvm/java-21-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"

RUN useradd -m -s /bin/bash jovyan
USER jovyan
WORKDIR /home/jovyan/work

EXPOSE 8888 4040

CMD ["jupyter", "lab", "--ip=0.0.0.0", "--port=8888", "--no-browser"]