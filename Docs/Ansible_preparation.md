ANSIBLE
-------
Need for Ansible
----------------
* In organization QA Policy ,for every change submitted by a devloper ,we need to run functional test, unit test, performance test, so for this we need application to be up and running, and since we need to do more deployments doing manually is not sensible
* for this we need to do Automation
* 2 Automation options
   1. procedural - through scripts (tells each and every step to do)
   2. Declarative - through Ansible ( tells only exact requirement)

Ansible Architecture
--------------------
* components of Ansibles are
   1. ACN- Ansible control node - this is server where neccessary tools(ansible) are available to automate, it understands **desired state**
   2. Node - this is where we are going to run our application, we use acn to install softeares/applications in this
* Types of CM
   1. Pull Based CM
      * Nodes need to know about server which requires **agent** to be installed on the nodes.
      * Examples: chef and puppet
   2. Push Based CM
      * **CM Server** should be aware of the nodes
      * CM Server should be aware of the nodes, credentials and permissions are required.
      * Examples- Ansible, salt
* Ansible is an open source software developed in python.
* Ansible expects **python** to be installed on nodes.
* **Desired state** : what has to be done / requirement

What needs to provided for Ansible
----------------------------------
* Desired State: what has to be done / manual steps to be performed are written in YAML file called as **Play book**
* List of nodes: where the steps of playbook are performed by executing a playbook from ACN is called as **Inventory**
* Credentials: we may pass credentials as part of playbook/inventory/command line or we will go with key based approach (ssh-copy-id)

Ansible Setup with Key Based Authentication between ACN and Node
----------------------------------------------------------------
1. create 2 linux vm's as ACN and Node
2. login into ACN and set **password authentication** to **YES** , in                     `sudo vi /etc/ssh/sshd_config`
3. create a user (same user in node also- ex:devops)                                      `sudo adduser devops`
4. give sudo permissions to this user -add user in sudoer's file and no passwd:all        `sudo vi sudo` 
5. repeat the steps 2,3,4 in node also
6. now create ssh key pair in ACN by                                                      `ssh-keygen`
7. now copy publickey of ACN to nodes by                                                  `ssh-copy-id`
8. then try login from ACN to node with password 

Installation of Ansible
-----------------------
1. for any distribution we can install by python -pip
   ```
   python3 install pip3
   python3 -m pip install --user ansible
   ```
2. for specifi distribution
   [refer]https://docs.ansible.com/ansible/latest/installation_guide/installation_distros.html
   for ubuntu
   ```
   sudo apt update
   sudo apt install software-properties-common
   sudo add-apt-repository --yes --update ppa:ansible/ansible
   sudo apt install ansible
   ```

Ansible Play Book
-----------------
