# Configuration Variables

Below is an exhaustive list of the variables the ansible-playbook installer understands. They are specified in [dci-infra-data-quickstart/group\_vars/all](https://gitlab.cee.redhat.com/dci/dci-infra-data-quickstart/blob/master/group_vars/all)

+---------------+-------------+----------------------------------------+
| Variable      | Default     | Description                            |
|               | Value       |                                        |
+===============+=============+========================================+
| hostname      | localhost   | The server hostname                    |
+---------------+-------------+----------------------------------------+
| adminpassword | admin       | The admin account password             |
+---------------+-------------+----------------------------------------+
| dbname        | dci         | The DB name to store DCI related data  |
+---------------+-------------+----------------------------------------+
| dbuser        | dci         | The DB user dci will rely on           |
+---------------+-------------+----------------------------------------+
| dbpassword    | dci         | The DB password for the dci DB user    |
+---------------+-------------+----------------------------------------+
| dbhost        | 127.0.0.1   | The IP address on which the database   |
|               |             | can be reached                         |
+---------------+-------------+----------------------------------------+
| dbbackuppath  | /var/tmp    | The path where to store the DB dump    |
+---------------+-------------+----------------------------------------+
| apihost       | 127.0.0.1   | The IP address on which the DCI API    |
|               |             | can be reached                         |
+---------------+-------------+----------------------------------------+
| servername    | dci.example | Global domain name for DCI             |
|               | .com        |                                        |
+---------------+-------------+----------------------------------------+
| api\_serverna | api.dci.exa | The domain name on which the DCI API   |
| me            | mple.com    | can be reached                         |
+---------------+-------------+----------------------------------------+
| doc\_serverna | doc.dci.exa | The domain name on which the DCI DOC   |
| me            | mple.com    | can be reached                         |
+---------------+-------------+----------------------------------------+
| ui\_servernam | dci.example | The domain name on which the DCI UI    |
| e             | .com        | can be reached                         |
+---------------+-------------+----------------------------------------+
| serveradmin   | <distribute | The serveradmin that should be         |
|               | d-ci@exampl | contacted if there is any issue with   |
|               | e.com>      | the web server                         |
+---------------+-------------+----------------------------------------+


