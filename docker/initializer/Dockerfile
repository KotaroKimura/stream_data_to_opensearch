FROM python:3.8

ARG USERNAME=user
ARG GROUPNAME=user
ARG UID=1000
ARG GID=1000

RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME

USER $USERNAME
WORKDIR /home/$USERNAME

COPY ./docker/initializer/scripts/ ./
COPY ./mapping/search.json ./

CMD ["/bin/sh"]
