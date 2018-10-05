#Please update the following parameters
SET fileName=myFirstL2Cert
SET keyPassword=keypassword
SET commonName=www.test.com
SET organisationUnit=OrgUnit
SET organisationName=OrgName
SET localityName=SG
SET stateName=SG

#Navigate to the SSL exe folder. Amend Path accordingly
cd C:/OpenSSL-Win64/bin

#Generate new PKI Key Pair with key encryption
openssl.exe genrsa -aes256 -out %fileName%.key -passout pass:%keyPassword% 2048

#Generate Certificate Signing Request
openssl-exe req -new -key %fileName%.key -passin pass:%keyPassword% -out %fileName%.csr -sha256 -subj "/C=SG/ST=%stateName%/L=%localityName%/O=%organisationName%/OU=%organisationUnit%/CN=%commonName%"
