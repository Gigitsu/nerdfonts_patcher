# Build with docker build -t carlosedp/nerdfonts-patch -f Nerdfonts-patch.dockerfile .
# Run with docker run -it --rm -v $(pwd):/fonts carlosedp/nerdfonts-patch [font file]

FROM ubuntu:18.04

ENV PYTHON python3.6
ENV FONTFORGE_VERSION 20200314
ENV PYTHONPATH $PYTHONPATH:/usr/local/lib/python3/dist-packages/:/root/

WORKDIR /root

RUN apt-get update && \
    apt-get install -y software-properties-common git python3 python3-pip libjpeg-dev libtiff5-dev libpng-dev libfreetype6-dev libgif-dev libgtk-3-dev libxml2-dev libpango1.0-dev libcairo2-dev libspiro-dev libuninameslist-dev python3-dev ninja-build curl cmake build-essential wget unzip zip rename && \
    add-apt-repository -y ppa:fontforge/fontforge && \
    apt-get update  && apt-get clean

RUN apt-get update \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y locales \
    && sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen \
    && dpkg-reconfigure --frontend=noninteractive locales \
    && update-locale LANG=en_US.UTF-8

RUN pip3 install configparser

RUN git clone https://github.com/ryanoasis/nerd-fonts nerdfonts --depth=1 && \
    cd nerdfonts && \
    touch __init__.py && \
    mv font-patcher font_patcher.py && \
    rm -rf .git patched-fonts src/unpatched-fonts

RUN curl -L https://github.com/fontforge/fontforge/releases/download/${FONTFORGE_VERSION}/fontforge-${FONTFORGE_VERSION}.tar.xz -o fontforge.tar.xz && \
    tar xf fontforge.tar.xz && \
    mv fontforge-${FONTFORGE_VERSION} fontforge && \
    mkdir fontforge/build && \
    cd fontforge/build && \
    cmake -GNinja .. && \ 
    ninja && \
    ninja install && \
    rm -rf /root/fontforge && \
    rm -r /root/fontforge.tar.xz

COPY gg-font-patcher nerdfonts/
    
ENV LANG en_US.UTF-8 
ENV LC_ALL en_US.UTF-8
ENV LANGUAGE en_US.utf8

WORKDIR /fonts
