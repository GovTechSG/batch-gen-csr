#!/bin/bash

# setup the environment
function prop {
    grep -w "${1}" parameters.config|cut -d'=' -f2
}

# Convert public cert from der format to pem format
openssl x509 -in $(prop 'fileName').cer -inform der -outform pem -out $(prop 'fileName').public.pem

# Generate pkcs12 file (Windows)
openssl pkcs12 -export -clcerts -in $(prop 'fileName').public.pem \
    -inkey $(prop 'fileName').key -passin pass:$(prop 'keyPassword') \
    -out $(prop 'fileName').p12 -passout pass:$(prop 'p12Password')

# Change alias in keystore, default alias is 1
keytool -changealias -keystore $(prop 'fileName').p12 -storepass $(prop 'p12Password') -alias 1 -destalias $(prop 'alias')


# Generate pem file with private key
openssl pkcs12 \
    -in $(prop 'fileName').p12 -passin pass:$(prop 'p12Password') \
    -out $(prop 'fileName').private.pem -passout pass:$(prop 'pemPassword') -clcerts

# Generate pem file without password
openssl rsa -in $(prop 'fileName').private.pem -passin pass:$(prop 'pemPassword') -out $(prop 'fileName').nopass.pem

# Convert p12 file to jks file (java)
keytool -importkeystore -srckeystore $(prop 'fileName').p12 -srcstorepass $(prop 'p12Password') -srcstoretype pkcs12 \
    -srcalias $(prop 'alias') -destkeystore $(prop 'fileName').jks \
    -deststoretype jks -deststorepass $(prop 'jksPassword') -destalias $(prop 'alias')