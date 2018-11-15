#!/bin/bash

configFile=${1}

# setup the environment
function prop {
    grep -w "${1}" $configFile|cut -d'=' -f2
}

openssl req -text -in "$(prop 'fileName').csr"
