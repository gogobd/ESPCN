FROM nvidia/cuda:latest

# Install system dependencies
RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
        build-essential \
        curl \
        git \
    && apt-get clean

# Install python miniconda3 + requirements
ENV MINICONDA_HOME="/opt/miniconda"
ENV PATH="${MINICONDA_HOME}/bin:${PATH}"
RUN curl -o Miniconda3-latest-Linux-x86_64.sh https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh \
    && chmod +x Miniconda3-latest-Linux-x86_64.sh \
    && ./Miniconda3-latest-Linux-x86_64.sh -b -p "${MINICONDA_HOME}" \
    && rm Miniconda3-latest-Linux-x86_64.sh

# COPY environment.yml environment.yml
# RUN conda env update -n=root --file=environment.yml
# RUN conda clean -y -i -l -p -t && \
#    rm environment.yml

RUN conda install pytorch torchvision -c soumith && \
	conda install pytorch torchvision cuda80 -c soumith && \
	pip install git+https://github.com/pytorch/tnt.git@master && \
	conda install opencv && \
	conda install -c anaconda jupyter && \
	conda install -c conda-forge jupyterlab && \
	conda install -c anaconda nb_conda

# Clone
# RUN git clone git@github.com:gogobd/ESPCN.git

# Copy
COPY . /ESPCN
WORKDIR /ESPCN

# Start container in notebook mode
CMD jupyter-lab --ip="*" --no-browser --allow-root
