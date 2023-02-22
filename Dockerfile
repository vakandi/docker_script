FROM debian:bullseye

RUN apt update
RUN apt install iptables lnav curl sudo vim apache2 ssh zsh git wget python3 python -y
RUN apt install mariadb-client mariadb-server net-tools -y
RUN apt install php libapache2-mod-php php7.4-mysql npm composer -y
EXPOSE 22 80 3306
