FROM gcr.io/cloudshell-images/cloudshell:latest

# Install Ansible (and its dependencies) from Debian packages repository.
RUN apt-get -y install --no-install-recommends ansible

# Update `$PATH` to make it contain `~/bin` (Tidal Tools) and `~/.local/bin`
# (Machine Stats) even if the directories do not exist yet.
# It overrides the default `$PATH` settings performed in `~/.profile`.
COPY update_path.sh /google/devshell/bashrc.google.d/
