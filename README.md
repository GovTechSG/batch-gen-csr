# APEX L2 Certificate Generation Scripts

## Generate the CSR
1. Execute git command to get the scripts files
```text
git clone https://github.com/lim-ming-tat/batch-gen-csr.git
```
2. Duplicate parameters.config with a new file name and update with new configuration.
```text
cp parameters.config <fileName>.config
```
3. Inside <fileName>.config, modify all the required parameters on the right column
```text
fileName=<change this and the rest>
.
.
p12Password=<change and remember this for next step>
.
.
more ...
```
4. Execute generateCsr.sh will generate the private key and certificate signing request
```text
./generateCsr.sh <fileName>.config
```
5. The following files will be generated;
    - fileName.key
    - fileName.nopass.key
    - fileName.pkcs8.key
    - fileName.pkcs8.nopass.key
    - fileName.public.key
    - fileName.csr

## Upload the CSR to APEX for Signing
1. Upload the CSR to APEX App.
2. Download the Signed Certificate from APEX and save as <fileName>.cer
3. Copy the file to the same folder of the csr file (this project folder)
4. Execute generateP12.sh will generate the keystore in P12,PEM and JKS format
```text
./generateP12.sh <fileName>.config
```
5. The following files will be generated;
    - fileName.public.pem
    - fileName.p12
    - fileName.private.pem
    - fileName.nopass.pem
    - fileName.jks
6. Use those keystore files (.pem, .p12, .jks generated for Test Client or your client program to consume)
