FROM ubuntu:14.04
MAINTAINER Barend Fouché van Rooyen
EXPOSE 5432
RUN apt-get update && apt-get upgrade -y ;\
apt-get install postgresql-9.3 -y

USER postgres

RUN service postgresql start &&\
psql --command "CREATE USER docker WITH SUPERUSER PASSWORD 'docker';" &&\
createdb -O docker docker ;\
echo "host all all 0.0.0.0/0 md5" >> /etc/postgresql/9.3/main/pg_hba.conf &&\
echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

VOLUME ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

CMD ["/usr/lib/postgresql/9.3/bin/postgres", "--config-file=/etc/postgresql/9.3/main/postgresql.conf"]