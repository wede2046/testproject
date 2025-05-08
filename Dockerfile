# 阶段1：构建依赖阶段 (Builder Stage)
FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04 AS builder

# 设置环境变量，避免交互式安装
ENV DEBIAN_FRONTEND=noninteractive

# 安装系统依赖
RUN apt-get update && apt-get install -y \
    python3.9 \
    python3.9-dev \
    python3-pip \
    git \
    wget \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置Python默认版本
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# 安装Python依赖
RUN pip3 install --no-cache-dir \
    torch==1.12.1+cu116 \
    torchvision==0.13.1+cu116 \
    torchaudio==0.12.1 \
    --extra-index-url https://download.pytorch.org/whl/cu116

RUN pip3 install --no-cache-dir \
    transformers \
    diffusers \
    accelerate \
    datasets \
    pillow \
    numpy

# 创建工作目录
WORKDIR /app

# 复制代码和配置文件
COPY train.py /app/
COPY requirements.txt /app/

# 安装额外依赖（如果有）
RUN pip3 install -r requirements.txt

# 可选：预下载预训练模型（减少运行时下载时间）
RUN python3 -c "from diffusers import StableDiffusionPipeline; StableDiffusionPipeline.from_pretrained('runwayml/stable-diffusion-v1-5', cache_dir='/app/cache')"

# 阶段2：中间清理阶段 (Intermediate Stage)
FROM builder AS intermediate

# 清理不必要的文件（例如pip缓存、临时文件）
RUN rm -rf /root/.cache/pip \
    && find / -name "__pycache__" -exec rm -rf {} + \
    && apt-get autoremove -y \
    && apt-get clean

# 阶段3：最终运行阶段 (Runtime Stage)
FROM nvidia/cuda:11.6.2-cudnn8-runtime-ubuntu20.04 AS runtime

# 设置环境变量
ENV DEBIAN_FRONTEND=noninteractive

# 安装最小的系统依赖（仅运行时所需）
RUN apt-get update && apt-get install -y \
    python3.9 \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# 设置Python默认版本
RUN update-alternatives --install /usr/bin/python3 python3 /usr/bin/python3.9 1
RUN update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

# 设置工作目录
WORKDIR /app

# 从中间阶段复制必要的文件
COPY --from=intermediate /usr/local/lib/python3.9/dist-packages /usr/local/lib/python3.9/dist-packages
COPY --from=intermediate /usr/local/bin /usr/local/bin
COPY --from=intermediate /app /app

# 确保GPU支持和必要的库存在
COPY --from=intermediate /usr/local/cuda /usr/local/cuda
COPY --from=intermediate /usr/lib/x86_64-linux-gnu/libcuda* /usr/lib/x86_64-linux-gnu/
COPY --from=intermediate /usr/lib/x86_64-linux-gnu/libcudnn* /usr/lib/x86_64-linux-gnu/

# 设置入口命令（可选）
CMD ["bash"]
