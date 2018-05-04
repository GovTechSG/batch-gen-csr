#!/bin/bash

params=${1}

# setup the environment
source $params

# Generate new PKI key pair, with key encryption - pcks1
openssl genrsa -aes256 -out ${fileName}.key -passout pass:${keyPassword} 2048

# remove passphrase from key file - pkcs1
openssl rsa -in ${fileName}.key -out ${fileName}.nopass.key -passin pass:${keyPassword}

# output public key
openssl rsa -in ${fileName}.key -pubout -out ${fileName}.public.key -passin pass:${keyPassword}

# convert pkcs1 to pkcs8 without passphrase
openssl pkcs8 -topk8 -in ${fileName}.nopass.key -out ${fileName}.nopass.pkcs8.key -nocrypt

# convert pkcs1 to pkcs8 with passphrase
openssl pkcs8 -topk8 -in ${fileName}.nopass.key -out ${fileName}.pkcs8.key -passout pass:${keyPassword}

# Generate Signing Request
openssl req -new \
    -key ${fileName}.key \
    -passin pass:${keyPassword} \
    -out ${fileName}.csr \
    -subj "/C=SG/ST=${stateName}/L=${localityName}/O=${organizationName}/OU=${organizationUnit}/CN=${commonName}/emailAddress=${email}"
