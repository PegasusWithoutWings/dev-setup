#!/usr/bin/env bash

# ~/aws.sh

# Removed user's cached credentials
# This script might be run with .dots, which uses elevated privileges
sudo -K

echo "------------------------------"
echo "Setting up AWS."
echo "This script requires pip and virtualenvwrapper to be installed."
echo "See the pydata.sh script."

echo "------------------------------"
echo "Source virtualenvwrapper from ~/.extra"
source ~/.extra

###############################################################################
# Python 2 Virtual Enviroment                                                 #
###############################################################################

echo "------------------------------"
echo "Updating py2k conda environment with AWS modules."

# Switch to Python2 data environment
source activate py2k

pip install boto
pip install awscli
pip install mrjob
pip install s3cmd

source deactivate

###############################################################################
# Python 3 Virtual Enviroment                                                 #
###############################################################################

echo "------------------------------"
echo "Updating py3-data virtual environment with AWS modules."

# Switch to Python3 data environment
source activate py3k

pip install boto
pip install awscli
pip install mrjob
pip install s3cmd
pip install aws-shell

source deactivate
###############################################################################
# System-Wide Packages                                                        #
###############################################################################

# Check for Homebrew,
# Install if we don't have it
if test ! $(which brew); then
  echo "Installing homebrew..."
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Make sure we’re using the latest Homebrew.
brew update

brew install apache-spark

###############################################################################
# Install IPython Notebook Spark Integration
###############################################################################

echo "------------------------------"
echo "Installing IPython Notebook Spark integration"

# Add the pyspark IPython profile
cp -r init/profile_pyspark/ ~/.ipython/profile_pyspark

ZSHENV_PATH=~/.zshenv
echo $ZSHENV_PATH
echo "" >> $ZSHENV_PATH
echo "" >> $ZSHENV_PATH
echo "# IPython Notebook Spark integration, added by aws.sh" >> $ZSHENV_PATH
# Run $ brew info apache-spark to determine the Spark install location
echo "export SPARK_HOME='/usr/local/Cellar/apache-spark/1.4.1'" >> $ZSHENV_PATH
echo "# Appending pyspark-shell is needed for Spark 1.4+" >> $ZSHENV_PATH
echo "export PYSPARK_SUBMIT_ARGS='--master local[2] pyspark-shell'" >> $ZSHENV_PATH
echo "" >> $ZSHENV_PATH
source $ZSHENV_PATH
echo "------------------------------"
echo "TODO: Update .aws/ with your AWS credentials and region, or run aws --configure."
echo "TODO: Update .mrjob.conf with your credentials, keypair, keypair location, region, and bucket info."
echo "TODO: Update .s3cfg with your credentials, location, and passphrase or run s3cmd --configure."
echo "Script completed."
