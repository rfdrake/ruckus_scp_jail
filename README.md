# Image for using scp with ruckus switches.

Until very recently, ruckus switches used an old SSH cipher.  Because of this,
copying files to the box was filled with problems.  TFTP had timeouts with
long transfers, https required valid certificates.  SCP had errors on the
server which looked like this:

    Mar 15 21:19:32 fileserver sshd[407703]: Unable to negotiate with 10.123.123.4 port 7501: no matching key exchange method found. Their offer: diffie-hellman-group14-sha1,diffie-hellman-group1-sha1 [preauth]

You can workaround this on the server by adding the kexalgorithims to
/etc/ssh/sshd_config, but that means the server is less secure.

This docker container tries to minimize the issue by only allowing the SCP
client to access the served directory tree, and to make it readonly.

To install and run, use this:

    git clone https://github.com/rfdrake/ruckus_scp_jail
    cd ruckus_scp_jail
    editor docker-compose.yml
    editor scp.env
    docker-compose build
    docker-compose up

There are three ways to manage the user account.

1. You can use an environment variable in docker-compose.yml or scp.env. To use this you can uncomment the
"env_file" line in docker-compose.yml.

2. You can use docker secrets to securely put the password in the container.
To do this uncomment the "secrets" part of the ruckus_scp service.

3. If neither of these options are set, the user is "rouser" and the password
is randomly generated and written to the log when the docker image starts.  You can use this for
temporary containers.

Here is an example of how to use it:

    SSH@switch#copy scp flash 10.123.123.251 2222 /files/08095m/ICX7150/Images/SPS08095mufi.bin secondary
    User name:ruckus
    Password:

