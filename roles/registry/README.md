install registry
    
    ansible-playbook -i ./hosts openshift-ansible/playbooks/byo/config.yml
    
uninstall registry

    ansible-playbook -i ./hosts openshift-ansible/playbooks/adhoc/uninstall.yml
    
