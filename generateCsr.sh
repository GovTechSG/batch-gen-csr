#!/bin/bash

# setup the environment
function prop {
    grep -w "${1}" parameters.config|cut -d'=' -f2
}

# Generate new PKI key pair, with key encryption - pcks1
openssl genrsa -aes256 -out $(prop 'fileName').key -passout pass:$(prop 'keyPassword') 2048

# remove passphrase from key file - pkcs1
openssl rsa -in $(prop 'fileName').key -out $(prop 'fileName').nopass.key -passin pass:$(prop 'keyPassword')

# output public key
openssl rsa -in $(prop 'fileName').key -pubout -out $(prop 'fileName').public.key -passin pass:$(prop 'keyPassword')

# convert pkcs1 to pkcs8 without passphrase
openssl pkcs8 -topk8 -in $(prop 'fileName').nopass.key -out $(prop 'fileName').nopass.pkcs8.key -nocrypt

# convert pkcs1 to pkcs8 with passphrase
openssl pkcs8 -topk8 -in $(prop 'fileName').nopass.key -out $(prop 'fileName').pkcs8.key -passout pass:$(prop 'keyPassword')

# Generate Signing Request
openssl req -new \
    -key $(prop 'fileName').key \
    -passin pass:$(prop 'keyPassword') \
    -out $(prop 'fileName').csr \
    -subj "/C=SG/ST=$(prop 'stateName')/L=$(prop 'localityName')/O=$(prop 'organizationName')/OU=$(prop 'organizationUnit')/CN=$(prop 'commonName')/emailAddress=$(prop 'email')"
