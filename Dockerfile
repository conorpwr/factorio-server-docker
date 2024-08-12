FROM amazonlinux:2023 AS build
RUN yum install -y wget shadow-utils gzip xz tar util-linux
RUN useradd -r factorio -d /opt/factorio
RUN wget "https://www.factorio.com/get-download/1.1.109/headless/linux64" -O /tmp/factorio-server
RUN tar xvf /tmp/factorio-server -C /opt

FROM amazonlinux:2023 AS gameserver
COPY --from=build /etc/passwd /etc/passwd
COPY --from=build /etc/shadow /etc/shadow
COPY --from=build /etc/group /etc/group
COPY --from=build /opt/factorio /opt/factorio

RUN mkdir /opt/factorio-data
RUN chown -R factorio:factorio /opt/factorio /opt/factorio-data
VOLUME /opt/factorio-data

COPY start-server.sh /opt/

USER factorio
EXPOSE 34197/udp
ENTRYPOINT /opt/start-server.sh
