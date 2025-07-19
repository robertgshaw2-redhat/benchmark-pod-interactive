FROM python:3.12-slim AS base

RUN apt update && apt install -y git wget curl vim

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install torch --extra-index-url https://download.pytorch.org/whl/cpu
RUN pip install -r requirements.txt

ARG VLLM_SHA=b6381ced9c52271f799a8348fcc98c5f40528cdf
RUN git clone https://github.com/vllm-project/vllm.git && \
    cd vllm && git checkout ${VLLM_SHA}

WORKDIR /app/vllm/benchmarks
RUN wget https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered/resolve/main/ShareGPT_V3_unfiltered_cleaned_split.json

WORKDIR /app
ENTRYPOINT ["/bin/bash"]