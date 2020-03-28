#!/bin/bash
function is_installed()
{
    which $1 > /dev/null 2>&1
}

function curl_dl()
{
    $(is_installed curl) && \
    curl http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20200219.zip \
    --output plink.zip
}

function wget_dl()
{
    $(is_installed wget) && \
    wget -O plink.zip \
    http://s3.amazonaws.com/plink1-assets/plink_linux_x86_64_20200219.zip
}

function unzip_pl()
{
    $(is_installed unzip) && unzip plink.zip -d plink
}

chmod +x run

{ [ -f plink.zip ] || [ -d plink ] ; } || \
{ { curl_dl || wget_dl ; } || \
  { echo "Please install curl or wget from your repos" && exit 1 ; } ; }

[ -d plink ] || \
{ { unzip_pl && rm plink.zip ; } || \
  { echo "Please install unzip from your repos" && exit 1 ; } ; }

