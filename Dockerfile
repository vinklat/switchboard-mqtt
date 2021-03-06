FROM python:3-alpine

COPY requirements.txt /

RUN apk --update add --virtual build-dependencies build-base libffi-dev tzdata \
  && cp /usr/share/zoneinfo/Etc/UTC /etc/localtime \
  && pip install -r /requirements.txt \
  && apk del build-dependencies tzdata \
  && rm -fR /root/.cache

WORKDIR /tmp/x
COPY laporte_mqtt/*py ./laporte_mqtt/
COPY setup.py README.md MANIFEST.in LICENSE requirements.txt ./
RUN  pip install . 

WORKDIR /laporte-mqtt
COPY conf/*yml ./conf/

ENTRYPOINT [ "laporte-mqtt" ]
