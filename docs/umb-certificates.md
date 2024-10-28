# Generate UMB certificate for DCI

Following <https://source.redhat.com/groups/public/identity-access-management/it_iam_pki_rhcs_and_digicert/rhcs_v2_start_your_certificate_journey_here_2023#new-style-service-account-certificates->

The service account *distributed-ci* has already been created.

## Generate a new pair of certificates

We are going to generate a new pair of certificates.
A dci.key certificate (the private key) and a public key (.crt) file.

To do so we neew to generate the private key and a signing request certificate:

    cd /tmp
    openssl req -verbose -newkey rsa:4096 -out dci.csr -subj "/UID=distributed-ci/OU=serviceaccounts/O=rhds/" -nodes -keyout dci.key

This command generates two files:

- `dci.csr` the certificate signing request
- `dci.key`: the private key

## Certificate profile

/!\ Note:
For next regeneration, try the following snippet: <https://gitlab.com/-/snippets/3714580>

We are going to generate the public certificate with our signing request file on [RHCS v2](https://ca2.corp.redhat.com/ca/ee/ca/profileSelect?profileId=caDirAppUserCert).

On this page, you need to enter the service account and its password.

The service account is *distributed-ci* and the password is saved in the passstore: dci/ldap/distributed-ci

The Certificate Request Type is PKCS#10 and the Certificate Request is the content of dci.csr

After validating the page, we can copy and save the public certificate generated in a /tmp/dci.crt file.

*Now we can use this dci.crt and dci.key to authenticate distributed-ci on UMB*

## Save dci.csr, dci.crt and dci.key in Bitwarden

DCI/UMB
├── dci.crt
├── dci.csr
└── dci.key

## Update the certificate on dci-infra

This certificate is used in dci-infra for dci-umb and dci-worker.

They're currently stored in `dci-infra-data-prod/group_vars/all/umb_certificates`.
