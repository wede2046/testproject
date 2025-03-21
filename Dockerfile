FROM alibaba-cloud-linux-2-registry.cn-hangzhou.cr.aliyuncs.com/alinux2/alinux2:latest
 
RUN sudo yum install wget -y 
RUN wget -q https://huggingface.co/SUFE-AIFLM-Lab/Fin-R1/resolve/main/model-00001-of-00004.safetensors
RUN wget -q https://huggingface.co/SUFE-AIFLM-Lab/Fin-R1/resolve/main/model-00002-of-00004.safetensors
RUN wget -q https://huggingface.co/SUFE-AIFLM-Lab/Fin-R1/resolve/main/model-00003-of-00004.safetensors
RUN wget -q https://huggingface.co/SUFE-AIFLM-Lab/Fin-R1/resolve/main/model-00004-of-00004.safetensors
  
  
# A
