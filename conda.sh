#!/usr/bin/env bash

# Install Python & Data Science Environment with Anaconda.
#
# Ask for the administrator password upfront.
sudo -v

# Keep-alive: update existing `sudo` time stamp until the script has finished.
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

# Check for Anaconda,
# Install if we don't have it
if test ! $(which conda); then
  echo "Installing Anaconda..."
  curl -fLo ~/Downloads/Anaconda3-4.4.0-MacOSX-x86_64.sh https://repo.continuum.io/archive/Anaconda3-4.4.0-MacOSX-x86_64.sh
  bash ~/Downloads/Anaconda3-4.4.0-MacOSX-x86_64.sh
  rm -f ~/Downloads/Anaconda3-4.4.0-MacOSX-x86_64.sh
fi
