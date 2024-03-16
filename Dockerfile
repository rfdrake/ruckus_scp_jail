FROM debian:bookworm-slim

# Install SSH server
RUN apt-get update && \
    apt-get install -y openssh-server && \
    apt-get clean

# Enable password authentication
RUN sed -i 's/#PasswordAuthentication yes/PasswordAuthentication yes/' /etc/ssh/sshd_config
COPY allow_old_ciphers.conf /etc/ssh/sshd_config.d/

COPY entrypoint.sh /usr/local/bin/
WORKDIR /files

EXPOSE 22

CMD ["/usr/local/bin/entrypoint.sh"]
