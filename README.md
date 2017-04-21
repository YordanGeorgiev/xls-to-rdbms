#  WRAPP


Table of Contents

  * [1. WHAT IS IT ?!](#1-what-is-it-)
  * [2. INSTALLATION AND CONFIGURATION](#2-installation-and-configuration)
    * [2.1. Prerequisites](#21-prerequisites)
    * [2.2. Fetch the source](#22-fetch-the-source)
    * [2.3. Build the first xls-to-rdbms instance](#23-build-the-first-xls-to-rdbms-instance)
    * [2.4. Create you local conf file](#24-create-you-local-conf-file)
    * [2.5. Start hacking](#25-start-hacking)


    

## 1. What is it ?!
A generic swiss knife wanna be bash / perl centric application xls-to-rdbmser for quicky packaging and deploying your tools, create new tools out of your existing ones , generating code for additonal functions, search and replace in both file paths and contents ... and all the rest not mentioned actions in the [sfw/bash/xls-to-rdbms/tests](sfw/bash/xls-to-rdbms/tests/all-xls-to-rdbms-tests.lst) file ...

    

## 2. INSTALLATION AND CONFIGURATION
The xls-to-rdbms instances and clones have been running on *Nix boxes with bash &gt; 3.0 … , but some actions require 4.0 and older …
Cygwin has been tested also … 

    

### 2.1. Prerequisites
The must have binaries are:
 bash, perl, zip

The nice to have are:
 tmux, vim ,ctags

The examples are for Ubuntu - use you OS package manager …

    apt-get autoclean
    apt-get install --only-upgrade bash
    
    sudo apt-get install -y perl
    
    # optionally 
    sudo apt-get install -y excuberant-ctags
    sudo apt-get install -y 7z
    
    apt-get upgrade

### 2.2. Fetch the source
Fetch the source from git hub as follows:

    # create your product dir:
    mkdir -p /opt/csitea/xls-to-rdbms
    cd /opt/csitea/xls-to-rdbms/
    
    # fetch the source
    git clone git@github.com:YordanGeorgiev/xls-to-rdbms.git

### 2.3. Build the first xls-to-rdbms instance
When doing for first time do exactly as shown bellow, otherwise no joy ... 
Each xls-to-rdbms instance has it's own version, environmnt type and owner. For now just follow the instruction - after half an hour you will be hacking this … 

    
    # build your product version dir - a kind of "this instance of the thingy dir"
    mv -v /opt/csitea/xls-to-rdbms/xls-to-rdbms /opt/csitea/xls-to-rdbms/xls-to-rdbms.1.1.5.dev.ysg
    

### 2.4. Create you local conf file
The default conf file provides only limited functionality ( this is by design ) , thus copy and configure the configuration file for your host

    # go to the product version dir
    cd /opt/csitea/xls-to-rdbms/xls-to-rdbms /opt/csitea/xls-to-rdbms/xls-to-rdbms.1.1.5.dev.ysg
    
    mv -v sfw/bash/xls-to-rdbms/xls-to-rdbms.set-your-host.conf sfw/bash/xls-to-rdbms/xls-to-rdbms.`hostname -s`.conf

### 2.5. Start hacking
Start hacking … or wait check at least the test call running all the functions of the tool … 

    # opionally if you are in the vim camp open the "project relative files list file"
    vim meta/.dev.xls-to-rdbms
    
    # Ctrl + Z , 
    bash sfw/bash/xls-to-rdbms/test-xls-to-rdbms.sh 
    
    # now clone your own instance
    bash sfw/bash/xls-to-rdbms/xls-to-rdbms.sh -a to-app=my-tool

