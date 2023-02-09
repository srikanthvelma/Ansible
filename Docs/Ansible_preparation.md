ANSIBLE
-------
Confiration Management
----------------------
* Configuration management is a process for maintaining computer systems, servers, and software in a desired, consistent state.
* The role of configuration management is to maintain systems in a desired state. Traditionally, this was handled manually or with custom scripting by system administrators.
* Automation is the use of software to perform tasks, such as configuration management, in order to reduce cost, complexity, and errors.
* Through automation, a configuration management tool can provision a new server within minutes with less room for error. You can also use automation to maintain a server in the desired state

Need for Ansible
----------------
* In organization QA Policy ,for every change submitted by a devloper ,we need to run functional test, unit test, performance test, so for this we need application to be up and running, and since we need to do more deployments doing manually is not sensible
* for this we need to do Automation
* 2 Automation options
   1. procedural - through scripts (tells each and every step to do)
   2. Declarative - through Ansible ( tells only exact requirement)

Ansible configuration files
---------------------------
* config file -`/etc/ansible/ansible.cfg`
* logs file - 
* adhoc commands uses -`/usr/bin/ansible`
* 

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
* ansible configuration

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
2. for specific distribution
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
* **Def**- 
* We create playbooks in YAML format which is collection of plays.
* List of modules to perform your automation where we describe the desired state
* Ensure you have valid manual steps (which are working)
* For each manual step find out an equivalent module
* Playbooks are expressed in YAML format (see YAML Syntax) and have a minimum of syntax
* [refer]https://docs.ansible.com/ansible/2.8/user_guide/playbooks_intro.html for ansible playbook docs

### YAML
* It is a Data Description Format, It is widely used to store
Data and Configurations
* Data can be categorized into 2 types
  * Simple/Scalar:
    * Text:    `name: Ansible`
    * Number : `version: 2.13`
    * Boolean: `opensource: yes`
  * Complex
    * list/array (plural)
      ```yaml
      colour:
        - blue
        - pink
        - red
      ```  
    * object/map/dictionary
       ```yaml
      address:
        flatno: 407
        building: mythrivanam
        city: Hyderabad
      ```
* JSON/YAML use Key-Value (Name Value) pairs.
* YAML Basic key value syntax is key: value
```yaml
---
- name: <purpose>
  hosts: <where to execute>
  become: yes # whether to run the tasks with sudo
  tasks:
    - name: <task description> # individual step
      <module-name>:
         <param-1>: <value-1>
         ..
         <param-n>: <value-n>
    - name: <task description>
      <module-name>:
         <param-1>: <value-1>
         ..
         <param-n>: <value-n>
         state: <desired-state>
```
Ansible ways of working
-----------------------
* list out the manual steps, which are working
* find the suitable modules for each and every manual step
* create a inventory file with hosts called as **hosts**
* try to write a playbook with modules in yaml ex: tomcat.yaml
* first try to check the ping from ansible commond
  ```
  ansible -i hosts -m ping all
  ```
* it should be success, even for localhost also configure and test connection 
* then try execute the playbook 
  ```
  ansible-playbook -i hosts --syntax-check tomcat.yaml   # it will check syntax
  ansible-playbook -i hosts tomcat.yaml                  # it should be executed in the where these 2 files will exist
  ```
* then here playbook should run without any errors
* if any error we have to resolve it, and also we have to check in the node so that desire state is done

Playbook stuff 
--------------
* **main** 
* here we header level details
  ```yaml
  ---
  - name: name of the playbook
    hosts: all
    become: yes
    tasks:
  ```
* **tasks** 
* we will have tasks for each step ,in task we have modules and in modules we have parameters and values
  ```yaml
  tasks:
  - name: install java
    apt:
      name: openjdk-11-jdk
      update_cache: yes
      state: present
  ```
* **Modules**
  1. apt
  2. yum
  3. file
  4. user
  5. group
  6. copy
  7. systemd
  8. get_url
  9. unarchive
  10. stat
  11. package
  12. template
  13. debug
  14. set_fact
  15. shell
  16. command
  17. apt_repository
  18. yum_repository
  19. apt_add_key
  20. setup
  21. git 
* **vars** 
* we can define variables in it ,where we can have chance of repeatability or version change or user and group change, user home ..etc
  ```yaml
  vars:
    group_name: wildfly
    user_name: wildfly
    user_home: /opt/wildfly
    user_shell: /sbin/nologin
    wildfly_version: 27.0.1.Final
    wildfly_service_name: wildfly.service
  tasks:
    - name: install java
      package:
        name: "{{ java_package_name }}"
        state: present
    - name: create a wildfly group
      group:
        name: "{{ group_name }}"
        system: yes
        state: present
  ```
* [refer]https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_variables.html#using-variables 
  
* **handlers**  
* Handlers are just like regular tasks in an Ansible playbook (see Tasks) but are only run if the Task contains a **notify** keyword and also indicates that it changed something
*  For example, if a config file is changed, then the task referencing the config file templating operation may notify a service restart handler.
*  mostly used for service - **start,restart,enable,stop,daemon-reload**
*  [refer](https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_handlers.html#handlers)
  
  ```yaml
  tasks:
  - name: change permissions to console dir
      file:
        dest: /var/run/wildfly
        recurse: yes
        owner: wildfly
        group: wildfly
        state: directory
      notify:
        - daemon reload and wildlfy restart
  handlers:
    - name: daemon reload and wildfly start
      systemd:
        name: "{{ wildfly_service_name }}"
        daemon_reload: yes
        enabled: yes
        state: started
  ```
* **loops** 
* loops allow a particular task to be repeated for multiple items in a list
* key words are - **item**, **item.src**, **item.dest**
  ```yaml
  - name: copy mgmt user & group files to dest1 & dest2
      copy:
        src: "{{ item.src }}"
        dest: "{{ item.dest }}"
      loop:
        - { src: 'wildfly.conf' , dest: '/etc/wildfly/wildfly.conf' }
        - { src: 'launch.sh' , dest: '/opt/wildfly/bin/launch.sh'}
  ```
* **Inventory**
* Inventory is list of hosts where the playbook has to be executed.
* Ansible allows groups in inventory, Inventory can be written in two formats- **ini file** and **yaml**
* ini file is text file, we can give all entries directly or we can add also specifi groups
  ```
  172.31.24.180
  172.31.24.181
  dev.internal.qt.com
  ```
  ```
  172.31.24.180
  localhost

  [ubuntu]
  172.31.24.180
  localhost

  [centos]
  20.121.55.193
  ```
* we can add variables at host level and also at group level,first group level priority and then host leve vars
* using variables at host level and group level we can run single playbook for multi distribution

* **ansible facts**
* ansible can collect information about the node where the playbook is under execution using facts
* To collect facts ansible uses setup module
* Lets use adhoc command to filter facts `ansible -i hosts -m setup -a "filter=*distribution*" all`
  ```json
  172.31.24.180 | SUCCESS => {
    "ansible_facts": {
        "ansible_distribution": "Ubuntu",
        "ansible_distribution_file_parsed": true,
        "ansible_distribution_file_path": "/etc/os-release",
        "ansible_distribution_file_variety": "Debian",
        "ansible_distribution_major_version": "22",
        "ansible_distribution_release": "jammy",
        "ansible_distribution_version": "22.04",
        "discovered_interpreter_python": "/usr/bin/python3"
    },
    "changed": false
  }
  20.121.55.193 | SUCCESS => {
    "ansible_facts": {
        "ansible_distribution": "CentOS",
        "ansible_distribution_file_parsed": true,
        "ansible_distribution_file_path": "/etc/redhat-release",
        "ansible_distribution_file_variety": "RedHat",
        "ansible_distribution_major_version": "8",
        "ansible_distribution_release": "NA",
        "ansible_distribution_version": "8.5",
        "discovered_interpreter_python": "/usr/libexec/platform-python"
    },
    "changed": false
   }
  ```

* **Adhoc command** 
* Adhoc command is a way of running ansible module by constructing command line using `/usr/bin/ansible`
* We use adhoc commands for activities which donot require automation.
* `ansible -i hosts -m setup -a "filter=distribution all`

* **conditionals**
* [refer]https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_conditionals.html
* In a playbook, you may want to execute different tasks, or have different goals, depending on the value of a fact (data about the remote system), a variable, or the result of a previous task , this is done by using conditionals
  ```yaml
   - name: Create a systemd unit file in centos
      ansible.builtin.copy:
        src: centos.tomcat.service
        dest: /etc/systemd/system/tomcat.service
        owner: "{{ user_name }}"
        group: "{{ group_name }}"
      when: ansible_facts['distribution'] == "CentOS"
    - name: Create a systemd unit file in ubuntu
      ansible.builtin.copy:
        src: ubuntu.tomcat.service
        dest: /etc/systemd/system/tomcat.service
        owner: "{{ user_name }}"
        group: "{{ group_name }}"
      when: ansible_facts['distribution'] == "Ubuntu"
  ```
* **ansible Templates**
* Ansible uses jinja2 for templating, In ansible to use the variables we use expression {{ variable_name }} which is derived from templating language jinja2
* We can use jinja2 in files so that the content can be dynamic

Ansible Roles
-------------
* Ansible Roles help in creating re-usable ansible assets
* Roles let you automatically load related vars, files, tasks, handlers, and other Ansible artifacts based on a known file structure. After you group your content in roles, you can easily reuse them and share them with other users.
* roles structure
  ```yaml
  roles/
    common/               # this hierarchy represents a "role"
        tasks/            #
            main.yml      #  <-- tasks file can include smaller files if warranted
        handlers/         #
            main.yml      #  <-- handlers file
        templates/        #  <-- files for use with the template resource
            ntp.conf.j2   #  <------- templates end in .j2
        files/            #
            bar.txt       #  <-- files for use with the copy resource
            foo.sh        #  <-- script files for use with the script resource
        vars/             #
            main.yml      #  <-- variables associated with this role
        defaults/         #
            main.yml      #  <-- default lower priority variables for this role
        meta/             #
            main.yml      #  <-- role dependencies
        library/          # roles can also include custom modules
        module_utils/     # roles can also include custom module_utils
        lookup_plugins/   # or other types of plugins, like lookup in this case

    webtier/              # same kind of structure as "common" was above, done for the webtier role
    monitoring/           # ""
    fooapp/               # ""
  ```
* By default, Ansible looks for roles in the following locations:
    * in collections, if you are using them
    * in a directory called roles/, relative to the playbook file
    * in the configured roles_path. The default search path is ~/.ansible/roles:/usr/share/ansible/roles:/etc/ansible/roles.
    * in the directory where the playbook file is located

**Ansible collections**
* In Ansible the reusable assets are - roles, modules
* In Ansible we can create custom modules as well by writing python code.
* Ansible collections are collections of - custom ansible modules & roles  



Ansible other terms
-------------------
* **Ansible Special Variables** - ansible while executing has lot of special variables defined by ansible [refer]https://docs.ansible.com/ansible/latest/reference_appendices/special_variables.html
* Ansible lookups
* Ansible Configuration file
* **custom facts**
* we can define custom facts of our own by using module - `ansible.builtin.set_fact`
  ```yaml
  ---
  - name: setting some fact
    become: yes
    hosts: all
    tasks:
        - name: set some facts
        ansible.builtin.set_fact:
            message: This is from ansible
            team: devops
        - name: get the facts
        ansible.builtin.debug:
            msg: "The facts are team = {{ team }} message = {{ message }}" 
  ```
* dynamic inventory
* ansible vault
* **flush handlers**
* Ansible handlers are executed based on consolidataion of all the tasks in ansible.
* If you want to execute handlers after some step immedietly we use flush_handlers as mentioned below
  ```yaml
  ---
  - name: flush handlers demo
    hosts: all
    tasks:
    - name: print something
      ansible.builtin.file:
        path: "/tmp/handle1"
        state: touch
      notify:
        - handle1
        - handle2
    - name: Force all notified handlers to run at this point, not waiting for normal sync points
      ansible.builtin.meta: flush_handlers
    - name: print something again
      ansible.builtin.file:
        path: "/tmp/handle2"
        state: touch
      notify:
        - handle1
        - handle2
    handlers:
    - name: handle1
      ansible.builtin.debug:
        msg: "handle1"
    - name: handle2
      ansible.builtin.debug:
        msg: "handle2"

  ```
* **parallesim** - **ansible forks**
* Ansible forks: This represents the number of hosts in which ansible will parallely execute the playbook
* The default number of forks are 5, This value can be changed while executing ansible command or in the configuration file.
* If you have the processing power available and want to use more forks, you can set the number in `ansible.cfg:`
  ```yaml
  [defaults]
  forks = 30
  ```
* Setting the batch size with **serial**
* By default, Ansible runs in parallel against all the hosts in the pattern you set in the `hosts:` field of each play. If you want to manage only a few machines at a time, for example during a rolling update, you can define how many hosts Ansible should manage at a single time using the `serial` keyword:  
  ```yaml
  ---
  - name: test play
  hosts: webservers
  serial: 3
  gather_facts: False

  tasks:
    - name: first task
      command: hostname
    - name: second task
      command: hostname
  ```

* In the above example, if we had 6 hosts in the group ‘webservers’, Ansible would execute the play completely (both tasks) on 3 of the hosts before moving on to the next 3 hosts:
  ```yaml
  PLAY [webservers] ****************************************

    TASK [first task] ****************************************
    changed: [web3]
    changed: [web2]
    changed: [web1]

    TASK [second task] ***************************************
    changed: [web1]
    changed: [web2]
    changed: [web3]

    PLAY [webservers] ****************************************

    TASK [first task] ****************************************
    changed: [web4]
    changed: [web5]
    changed: [web6]

    TASK [second task] ***************************************
    changed: [web4]
    changed: [web5]
    changed: [web6]

    PLAY RECAP ***********************************************
    web1      : ok=2    changed=2    unreachable=0    failed=0
    web2      : ok=2    changed=2    unreachable=0    failed=0
    web3      : ok=2    changed=2    unreachable=0    failed=0
    web4      : ok=2    changed=2    unreachable=0    failed=0
    web5      : ok=2    changed=2    unreachable=0    failed=0
    web6      : ok=2    changed=2    unreachable=0    failed=0
  ```
* **tags in ansible**
* we can apply at different level- for complete playbook level, for 1 tasks, for multiple tasks, at a block level by using block, to roles
* for more tags details [refer]https://docs.ansible.com/ansible/latest/playbook_guide/playbooks_tags.html#selecting-or-skipping-tags-when-you-run-a-playbook

* gather_facts
* ansible on windows
* ansible tower
* 
  
   