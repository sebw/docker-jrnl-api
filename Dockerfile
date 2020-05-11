FROM fedora:32

RUN INSTALL_PKGS="python3-pip procps-ng net-tools" && \
    yum -y update-minimal --disablerepo "*" --enablerepo fedora --setopt=tsflags=nodocs \
      --security --sec-severity=Important --sec-severity=Critical && \
    yum -y install --disablerepo "*" --enablerepo fedora --setopt=tsflags=nodocs ${INSTALL_PKGS} && \
    pip install Flask && \
    pip install jrnl && \
    yum clean all && \
    mkdir -p /.config/jrnl && \
    mkdir -p /.local/share/jrnl

COPY jrnl.yaml /.config/jrnl
COPY jrnl-api.py /usr/local/bin

ENV APP_ROOT=/ \
    USER_NAME=default \
    USER_UID=10001

RUN useradd -l -u ${USER_UID} -r -g 0 -d ${APP_ROOT} -s /sbin/nologin -c "${USER_NAME} user" ${USER_NAME} && \
    chown -R ${USER_UID}:0 /.local/share/jrnl && \
    chown ${USER_UID}:0 /.config/jrnl/jrnl.yaml && \
    chown ${USER_UID}:0 /usr/local/bin/jrnl-api.py

USER 10001
WORKDIR ${APP_ROOT}
VOLUME /.local/share/jrnl

EXPOSE 5000

HEALTHCHECK --interval=60s --timeout=10s --retries=3 CMD curl -s "http://localhost:5000/ping" | grep "pong"

CMD python3 /usr/local/bin/jrnl-api.py

