FROM python:3.12-slim as base

WORKDIR /app

COPY requirements.txt requirements.txt

RUN pip install --no-cache-dir -r requirements.txt

ARG VLLM_SHA=b6381ced9c52271f799a8348fcc98c5f40528cdf
RUN git clone https://github.com/vllm-project/vllm.git && \
    cd vllm && git checkout ${VLLM_SHA}

WORKDIR /app/vllm/benchmark
RUN wget https://huggingface.co/datasets/anon8231489123/ShareGPT_Vicuna_unfiltered/resolve/main/ShareGPT_V3_unfiltered_cleaned_split.json

ENTRYPOINT ["/bin/bash"]