# Matrix Synapse Server Setup

### Required software

  - python3
  - ansible-core (recommend 2.10 or newer)
  - make

### Ports

The playbook will open ports on the system, but you will need to open these ports on any external firewall (AWS, router, etc)

  - 80 (TCP)
  - 443 (TCP)
  - 3478 (TCP/UDP)
  - 5349 (TCP/UDP)
  - 8448 (TCP)
  - 49152-49172 (UDP)

### Initial deployment

```sh
git clone https://github.com/spantaleev/matrix-docker-ansible-deploy/
cd matrix-docker-ansible-deploy
mkdir inventory/host_vars/matrix.$domain
cp examples/vars.yml inventory/host_vars/matrix.$domain/vars.yml
cp examples/hosts inventory/hosts
vim inventory/hosts
# put most settings here in vars.yml, read following sections for some ideas
vim inventory/host_vars/matrix.$domain/vars.yml
```

### Some variables to set in `vars.yaml`

First, generate two strong secrets. These will be used in `vars.yml`

```sh
pwgen -s 64 2
```

```sh
#Serve base domain
matrix_nginx_proxy_base_domain_serving_enabled: true
# Voice/video
matrix_coturn_turn_external_ip_address: $instance_external_ip_address
# Enable matrix registration with token only
matrix_registration_enabled: true
matrix_registration_admin_secret: "ENTER_SECRET_FROM_pwgen"

 # If set to 'true', removes the need for authentication to access the server's 
 # public rooms directory through the client API, meaning that anyone can 
 # query the room directory. Defaults to 'false'. 
 # 
 allow_public_rooms_without_auth: false

# If set to 'true', allows any other homeserver to fetch the server's public 
 # rooms directory via federation. Defaults to 'false'. 
 # 
 allow_public_rooms_over_federation: false

# Restrict federation to the following whitelist of domains. 
 # N.B. we recommend also firewalling your federation listener to limit 
 # inbound federation traffic as early as possible, rather than relying 
 # purely on this application-layer restriction.  If not specified, the 
 # default is to whitelist everything. 
 # 
 #federation_domain_whitelist: 
 #  - lon.example.com 
 #  - nyc.example.com 
 #  - syd.example.com 
```

### Make roles and run playbooks

```sh
cd matrix-docker-ansible-deploy
make roles
# you'll need to rerun setup-all and start tags again if you edit vars later
ansible-playbook -i inventory/hosts setup.yml --tags=setup-all,start
ansible-playbook -i inventory/hosts setup.yml --tags=self-check
```

### Register Users

Register initial admin user.

```sh
sudo /matrix/synapse/bin/register-user <your-username> <your-password> <admin access: 0 or 1>
```

Generate token link for self-registration.

```sh
cd matrix-docker-ansible-deploy
ansible-playbook -i inventory/hosts setup.yml --tags=generate-matrix-registration-token --extra-vars="one_time=yes ex_date=2022-12-31"
```

List existing user registration tokens.

```sh
cd matrix-docker-ansible-deploy
ansible-playbook -i inventory/hosts setup.yml --tags=list-matrix-registration-tokens
```

Change user administrator privileges

```sh
sudo /usr/local/bin/matrix-change-user-admin-status <username> <0/1>
```