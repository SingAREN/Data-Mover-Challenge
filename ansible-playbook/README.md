Ansible script that performs the following:

- Installation of iperf3, singularity v3.2.1 and netdata
- Configures netdata to filter out cpu, memory, disk and interface statistics when sending data to Prometheus
- Tunes network interfaces
- Tunes kernel parameters

The script is written for CentOS 7.6 and Ansible >2.5

## Running the script

1. Enable EPEL Repository

    ```
    # yum install epel-release
    ```

2. Install Ansible via yum

    ```
    # yum install ansible
    ```
  
3. Check Ansible versionl

    ```
    $ ansible --version
    ansible 2.8.2
      config file = /etc/ansible/ansible.cfg
      configured module search path = [u'/home/simon/.ansible/plugins/modules', u'/usr/share/ansible/plugins/modules']
      ansible python module location = /usr/lib/python2.7/site-packages/ansible
      executable location = /usr/bin/ansible
      python version = 2.7.5 (default, Jun 20 2019, 20:27:34) [GCC 4.8.5 20150623 (Red Hat 4.8.5-36)]
    ```
