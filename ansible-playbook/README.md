# DMC23 DTN Initialisation and Benchmarking with Ansible 

**The Ansible playbook performs the following:**

- Installation of iperf3, singularity v3.7.3 and prometheus node_exporter
- Setup DMCUser01 to DMCUser15
- Configures `/etc/hosts` file
- Configures netdata to filter out cpu, memory, disk and interface statistics when sending data to Prometheus
- Tunes network interfaces
- Tunes kernel parameters

The script is written for Ubuntu 20.04.4 LTS and Ansible >2.5. The user running the ansible-playbook must have administrator permissions.

## Pre-requisites

1. Requires Ubuntu 20.04 LTS
1. Setup storage for DMC which has to be found at `/DMC`
    1. Create `/DMC/data` directory with `0755` permissions
    1. Create `/DMC/test` directory with `0777` permissions


## Initial Setup
### Ubuntu 20.04 LTS

1. Update Apt Repository Cache

    ```
    # apt update
    ```

2. Install Ansible via apt

    ```
    # apt install ansible git
    ```
  
3. Check Ansible version if it is greater than >=2.5

    ```
    $ ansible --version
    ```

## Running the Ansible Playbook for Initialise DTN
4. Git Clone Data-Mover Challenge Repository

      ```
      $ git clone https://github.com/SingAREN/Data-Mover-Challenge.git && cd Data-Mover-Challenge/ansible-playbook
      ```

5. Edit the `DMC_INTERFACES` variables within `dmc21-initialise.yml` `vars` entry. 
    - `DMC_INTERFACES` is the network interface used during the DMC in list format, this is required for tuning the specific interfaces.
    
    ```
    $ vi dmc21-initialise.yml
    ```
    Example:
    
    ```
      vars:
        DMC_INTERFACES: ['ens33']
    ```
    
6. Once the `DMC_INTERFACES` variables have been added, run the Ansible playbook with the `-b -K` flags. The flags indicate Ansible to become the administrator user.

    ```
    $ ansible-playbook -b -K dmc21-initialise.yml
    ``` 

### Notes:
- The ansible-playbook will take, at minimum, 30 minutes to complete during the first run. The two main culprits are `Annex C - Compile and Install Mellanox OFED` and `Annex D - Run sca20-fio.sh` tasks. The first task needs to compile many files from source and the second task will benchmark the `/DMC` storage. 
- It is safe to re-run the playbook 
- Benchmarking log files will be found in `/tmp/benchmarks/` as `*.log` files by default.
