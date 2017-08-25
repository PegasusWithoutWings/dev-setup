#!/usr/bin/env bash

# Install Python & Data Science Environment with Anaconda.
#
# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Miniconda,
# Install if we don't have it
if test ! $(which conda); then
  echo "Installing Miniconda..."
  wget https://repo.continuum.io/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
  bash Miniconda3-latest-MacOSX-x86_64.sh -bf
  echo 'export PATH="$HOME/miniconda3/bin:$PATH"' >> $HOME/.zshenv
  rm -f Miniconda3-latest-MacOSX-x86_64.sh
fi

# Update conda to make sure we have the most up-to-date version
conda update -y conda

# Install Anaconda3 and create py3k environment with conda
conda create -ny py3k anaconda python=3

# Install Anaconda2 and create py2k environment with conda
conda create -ny py2k anaconda python=2
