# APEX L2 Certificate Generation Scripts

## Generate the CSR
1. Update parameters.config with your configurations
2. Execute generateCsr.sh will generate the private key and certificate signing request
```text
./generateCsr.sh
```
3. The following files will be generated;
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
4. Execute generateP12.sh will generate the keystore in P12,PEM and JKS format
```text
./generateP12.sh
```
5. The following files will be generated;
    - fileName.public.pem
    - fileName.p12
    - fileName.private.pem
    - fileName.nopass.pem
    - fileName.jks
