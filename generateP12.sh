#!/bin/bash

params=${1}

# setup the environment
source $params

# Convert public cert from der format to pem format
openssl x509 -in ${fileName}.cer -inform der -outform pem -out ${fileName}.public.pem

# Generate pkcs12 file (Windows)
openssl pkcs12 -export -clcerts -in ${fileName}.public.pem \
    -inkey ${fileName}.key -passin pass:${keyPassword} \
    -out ${fileName}.p12 -passout pass:${p12Password}

# Change alias in keystore, default alias is 1
keytool -changealias -keystore ${fileName}.p12 -storepass ${p12Password} -alias 1 -destalias ${alias}


# Generate pem file with private key
openssl pkcs12 \
    -in ${fileName}.p12 -passin pass:${p12Password} \
    -out ${fileName}.private.pem -passout pass:${pemPassword} -clcerts

# Generate pem file without password
openssl rsa -in ${fileName}.private.pem -passin pass:${pemPassword} -out ${fileName}.nopass.pem

# Convert p12 file to jks file (java)
keytool -importkeystore -srckeystore ${fileName}.p12 -srcstorepass ${p12Password} -srcstoretype pkcs12 \
    -srcalias ${alias} -destkeystore ${fileName}.jks \
    -deststoretype jks -deststorepass ${jksPassword} -destalias ${alias}