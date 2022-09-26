FROM gitpod/workspace-full-vnc
USER gitpod

ARG release_name=gs952
ARG archive_name=ghostpcl-9.52-linux-x86_64

RUN pip install --no-cache-dir numpy
COPY requirements.txt /tmp/requirements.txt
RUN pip install --no-cache-dir -r /tmp/requirements.txt
WORKDIR    /
RUN sudo apt-get update && sudo apt-get install -y \
    imagemagick \
    tesseract-ocr \
    ghostscript \
    wget \
    libdmtx0b \
    software-properties-common \
    gettext-base \
    && sudo rm -rf /var/lib/apt/lists/*

RUN sudo wget -O /usr/share/tesseract-ocr/4.00/tessdata/eng.traineddata https://github.com/tesseract-ocr/tessdata/blob/main/eng.traineddata?raw=true \
    && sudo wget -O /usr/share/tesseract-ocr/4.00/tessdata/osd.traineddata https://github.com/tesseract-ocr/tessdata/blob/main/osd.traineddata?raw=true
          
RUN wget https://github.com/ArtifexSoftware/ghostpdl-downloads/releases/download/${release_name}/${archive_name}.tgz \
  && tar -xvzf ${archive_name}.tgz \
  && chmod +x ${archive_name}/gpcl6* \
  && cp ${archive_name}/gpcl6* ${archive_name}/pcl6 \
  && cp ${archive_name}/* /usr/bin

COPY policy.xml /etc/ImageMagick-6/