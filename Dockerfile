FROM python
RUN sudo apt-get update
RUN sudo apt-get install git -y 
RUN git lfs install
RUN git clone https://huggingface.co/SUFE-AIFLM-Lab/Fin-R1
# A
