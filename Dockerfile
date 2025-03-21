FROM alibaba-cloud-linux-2-registry.cn-hangzhou.cr.aliyuncs.com/alinux2/alinux2:latest
 
RUN sudo yum install git -y 
RUN git lfs install
RUN git clone https://huggingface.co/SUFE-AIFLM-Lab/Fin-R1
# A
