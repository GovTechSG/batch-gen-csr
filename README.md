# APEX L2 Certificate Generation Scripts

## Generate the CSR
1. Copy parameters.sh with a new name. i.e. myL2Cert.sh
2. Open the newly created script file and update the following parameters;
3. Execute generateCsr.sh
```text
./generateCsr.sh myL2Cert.sh
```
4. The following files will be generated;
    - fileName.key
    - fileName.nopass.key
    - fileName.pkcs8.key
    - fileName.pkcs8.nopass.key
    - fileName.public.key
    - fileName.csr

## Upload the CSR to APEX for Signing
1. Upload the CSR to APEX App.
2. Download the Signed Certificate from APEX.
3. Make sure that the cert file name is set to the filename set in the parameters file. i.e. fileName.cer
4. Execute generateP12.sh
```text
./generateP12.sh myL2Cert.sh
```
5. The following files will be generated;
    - fileName.public.pem
    - fileName.p12
    - fileName.private.pem
    - fileName.nopass.pem
    - fileName.jks
