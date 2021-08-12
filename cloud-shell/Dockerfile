FROM gcr.io/cloudshell-images/cloudshell:latest

# Upgrade `pip` and install `ansible`
RUN python3 -m pip install --upgrade pip \
 && python3 -m pip install 'ansible<2.10'

# Update `$PATH` to make it contain `~/bin` (Tidal Tools) and `~/.local/bin`
# (Machine Stats) even if the directories do not exist yet.
# It overrides the default `$PATH` settings performed in `~/.profile`.
COPY update_path.sh /google/devshell/bashrc.google.d/
