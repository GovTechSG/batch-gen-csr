#File name has to be the same as the one previously defined
SET fileName=myFirstL2Cert

#Navigate to SSL exe folder. Amend the path accordingly
cd C:/OpenSSL-Win64/bin

#Set passwords for various file types
SET keyPassword=keypassword
SET p12Password=p12password
SET pemPassword=pempassword

#Convert public cert from der format to pem format
openssl.exe x509 -in %fileName%.cer -inform der -outform pem -out %fileName%.public.pem

#Generate pkcs12 file (Windows)
openssl.exe pkcs12 -export -clcerts -in %fileName%.public.pem -inkey %fileName%.key -passin pass:%keyPassword% -out %fileName%.p12 -passout pass:%p12Password%

#Generate pem file with private key
openssl.exe pkcs12 -in %fileName%.p12 -passin pass:%p12Password% -out %fileName%.private.pem -passout pass:%pemPassword% -clcerts

#Generate pem file without password
openssl.exe rsa -in %fileName%.private.pem -passin pass:%pemPassword% -out %fileName%.nopass.pem 
