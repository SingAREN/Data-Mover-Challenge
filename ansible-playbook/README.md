# DMC20 DTN Initialisation and Benchmarking with Ansible 

**The Ansible playbook performs the following:**

- Installation of iperf3, singularity v3.2.1 and netdata
- Setup DMCUser01 to DMCUser15
-
- Configures netdata to filter out cpu, memory, disk and interface statistics when sending data to Prometheus
- Tunes network interfaces
- Tunes kernel parameters

The script is written for CentOS 7.6 and Ansible >2.5. The user running the ansible-playbook must have administrator permissions.

## Pre-requisites

1. Requires CentOS 7.6
1. Setup storage for DMC which has to be found at `/DMC`
  1. Create `/DMC/data` directory with `0755` permissions
  1. Create `/DMC/test` directory with `0777` permissions


## Running the script

1. Enable EPEL Repository

    ```
    # yum install epel-release
    ```

2. Install Ansible via yum

    ```
    # yum install ansible
    ```
  
3. Check Ansible version if it is greater than >=2.5

    ```
    $ ansible --version
    ansible 2.8.2
      config file = /etc/ansible/ansible.cfg
      configured module search path = [u'/home/simon/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
      ansible python module location = /usr/lib/python2.7/site-packages/ansible
      executable location = /usr/bin/ansible
      python version = 2.7.5 (default, Jun 20 2019, 20:27:34) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
    ```
4. Download Ansible script from GitHub

      ```
      $ curl -o dmc20-initialise-dtn.yml https://raw.githubusercontent.com/SingAREN/Data-Mover-Challenge/master/ansible-playbook/dmc20-initialise-dtn.yml
      ```

5. Edit the `DMC_INTERFACES` variables within `dmc20-initialise-dtn.yml` `vars` entry. 
    - `DMC_INTERFACES` is the network interface used during the DMC in list format, this is required for tuning the specific interfaces.
    
    ```
    $ vim dmc20-initialise-dtn.yml
    ```
    Example:
    
    ```
      vars:
        DMC_INTERFACES: ['ens33.1312']
    ```
    
6. Once the `DMC_INTERFACES` variables have been added, run the Ansible playbook with the `-b -K` flags. The flags indicate Ansible to run as administrator user.

    ```
    $ ansible-playbook -b -K dmc20-initialise-dtn.yml
    ``` 

### Notes:
- The ansible-playbook will take, at minimum, 30 minutes to completer during the first run. The two main culprits are `Annex C - Compile and Install Mellanox OFED` and `Annex D - Run sca20-fio.sh` tasks. The first task needs to compile many files from source and the second task will benchmark the `/DMC` storage. 
- It is safe to re-run the playbook 
- Installation log files will be found in `/tmp` as `dmc20-*.log` files by default.
