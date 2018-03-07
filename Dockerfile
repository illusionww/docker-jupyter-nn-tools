FROM nvidia/cuda:9.0-cudnn7-devel

MAINTAINER Vladimir Ivashkin illusionww@gmail.com

RUN apt-get clean && apt-get update && apt-get install -y \
        build-essential cmake gcc apt-utils python3 python3-pip python3-dev \
        wget unzip git vim nano \
        gfortran libatlas-base-dev libatlas-dev libatlas3-base libhdf5-dev \
        libfreetype6-dev libpng12-dev pkg-config libxml2-dev libxslt-dev \
        libjpeg-dev xvfb libav-tools xorg-dev libsdl2-dev swig \
        libboost-program-options-dev zlib1g-dev libboost-all-dev libboost-python-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN pip3 install -U pip cython joblib vowpalwabbit tqdm && \
    pip3 install -U jupyter scipy numpy scikit-learn pandas xlrd pandas-profiling \
                    matplotlib plotly seaborn Pillow scikit-image imgaug opencv-python opencv-contrib-python \
                    nltk gensim pymorphy2[fast] pymorphy2-dicts-ru \
                    tensorflow-gpu keras h5py xgboost catboost && \
    pip3 install -U html5lib==0.999999999 && \
    python3 -m ipykernel.kernelspec && \
    jupyter nbextension enable --py --sys-prefix widgetsnbextension

ADD jupyter_notebook_config.py /jupyter/jupyter_notebook_config.py
ENV JUPYTER_CONFIG_DIR="/jupyter"

WORKDIR /notebook
COPY notebook.sh /notebook.sh
CMD ["/notebook.sh"]
