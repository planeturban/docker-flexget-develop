FROM lsiobase/alpine.python:3.7


ENV PYTHONIOENCODING="UTF-8"

WORKDIR /opt/flexget
RUN apk add --update python py-pip ca-certificates git 
RUN git clone https://github.com/Flexget/Flexget.git
RUN cd Flexget && pip install paver && pip install -e . 
RUN apk del git
RUN rm -rf /var/cache/apk/*
VOLUME /config
COPY etc/ /etc
COPY templates /var/lib/templates
RUN chmod -v +x \
    /etc/cont-init.d/*  


# Ports and volumes.
VOLUME /config

EXPOSE 5050
