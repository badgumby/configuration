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
# Matrix domain name (this should be the base domain)
matrix_domain: example.com

# The Matrix homeserver software to install.
# See:
#  - `roles/custom/matrix-base/defaults/main.yml` for valid options
# - the `docs/configuring-playbook-IMPLEMENTATION_NAME.md` documentation page, if one is available for your implementation choice
matrix_homeserver_implementation: synapse

# A secret used as a base, for generating various other secrets.
# You can put any string here, but generating a strong one is preferred (e.g. `pwgen -s 64 1`).
matrix_homeserver_generic_secret_key: "ENTER_FIRST_SECRET_FROM_PWGEN"

# Email for LetsEncrypt registration
matrix_ssl_lets_encrypt_support_email: "email@example.com"

# Postgres super user password
devture_postgres_connection_password: "some_master_password"

#Serve base domain
matrix_nginx_proxy_base_domain_serving_enabled: true
# Voice/video
matrix_coturn_turn_external_ip_address: external_ip_address

# Auto-join the following rooms:
auto_join_rooms:
  - "#general:badgum.by"

# Create the auto_join_rooms, if they don't exist
autocreate_auto_join_rooms: true

# Enable matrix registration with token only
matrix_registration_enabled: true
matrix_registration_admin_secret: "ENTER_SECOND_SECRET_FROM_PWGEN"

# Force email on registration
#registrations_require_3pid:
#  - email

email:
  smtp_host: localhost
  notif_from: "Matrix - hostname <matrix@hostname>"
  subjects:
    message_from_person_in_room: "[%(app)s] You have a message on %(app)s from %(person)s in the %(room)s room..."
    message_from_person: "[%(app)s] You have a message on %(app)s from %(person)s..."
    messages_from_person: "[%(app)s] You have messages on %(app)s from %(person)s..."
    messages_in_room: "[%(app)s] You have messages on %(app)s in the %(room)s room..."
    messages_in_room_and_others: "[%(app)s] You have messages on %(app)s in the %(room)s room and others..."
    messages_from_person_and_others: "[%(app)s] You have messages on %(app)s from %(person)s and others..."
    invite_from_person_to_room: "[%(app)s] %(person)s has invited you to join the %(room)s room on %(app)s..."
    invite_from_person: "[%(app)s] %(person)s has invited you to chat on %(app)s..."
    password_reset: "[%(server_name)s] Password reset"
    email_validation: "[%(server_name)s] Validate your email"

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

# Server level retention policy
# https://matrix-org.github.io/synapse/latest/usage/configuration/config_documentation.html
retention:
  enabled: true
  default_policy:
    min_lifetime: 1d
    max_lifetime: 1y
  allowed_lifetime_min: 1d
  allowed_lifetime_max: 1y
  purge_jobs:
    - longest_max_lifetime: 3d
      interval: 12h
    - shortest_max_lifetime: 3d
      interval: 1d

# Limit room by complexity
limit_remote_rooms:
  enabled: true
  complexity: 0.5
  complexity_error: "Shit be complex, my guy."
  admins_can_join: true
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