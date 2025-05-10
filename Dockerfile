# 基础镜像：包含 CUDA 和 cuDNN
FROM nvidia/cuda:11.6.2-cudnn8-devel-ubuntu20.04

# 安装 Python 和依赖
RUN apt-get update && apt-get install -y python3.9 python3-pip git
RUN pip3 install --upgrade pip

# 安装 PyTorch 和相关库
RUN pip3 install torch==1.12.0+cu116 torchvision==0.13.0+cu116 -f https://download.pytorch.org/whl/cu116/torch_stable.html

# 安装 Hugging Face 库
RUN pip3 install diffusers==0.11.1 transformers==4.25.1 accelerate==0.15.0

# 安装其他工具
RUN pip3 install numpy pillow matplotlib

# 设置工作目录
WORKDIR /app

# 复制训练代码
COPY train.py /app/train.py
COPY requirements.txt /app/requirements.txt
RUN pip3 install -r requirements.txt

# 环境变量
ENV PYTHONUNBUFFERED=1
