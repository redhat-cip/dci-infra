DCI_EMAIL_SERVER='{{ dci_worker_email_server }}'
DCI_EMAIL_ACCOUNT='{{ dci_worker_email_account }}'
{% if dci_worker_email_password|default('') %}DCI_EMAIL_PASSWORD='{{ dci_worker_email_password }}'{% endif %}

export DCI_EMAIL_SERVER
export DCI_EMAIL_ACCOUNT
{% if dci_worker_email_password|default('') %}export DCI_EMAIL_PASSWORD{% endif %}

DCI_DLRN_LOGIN='{{ dci_worker_dlrn_login }}'
DCI_DLRN_PASSWORD='{{ dci_worker_dlrn_password }}'

export DCI_DLRN_LOGIN
export DCI_DLRN_PASSWORD

UMB_KEY_FILE_PATH='{{ umb_key_file_path }}'
UMB_CRT_FILE_PATH='{{ umb_crt_file_path }}'
UMB_CA_FILE_PATH='{{ umb_ca_file_path }}'
UMB_BROKERS='{{ umb_brokers }}'

export UMB_KEY_FILE_PATH
export UMB_CRT_FILE_PATH
export UMB_CA_FILE_PATH
export UMB_BROKERS
