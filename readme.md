# Load Balanced Nginx Servers with HAProxy

This project sets up two Nginx web servers and an HAProxy load balancer using Terraform and Ansible. The load balancer distributes incoming requests to the two Nginx servers in a round-robin fashion.

## Prerequisites

* Terraform installed
* Ansible installed.
* AWS CLI configured with valid AWS credentials.

## Setup

- Clone this repository and navigate to the root directory.
- Run terraform init and terraform apply in the infrastructure/terraform folder to create the AWS instances.
- Terraform local exec will populate hosts.ini with the instance ip-s 
- Run ansible-playbook -i ansible/hosts.ini ansible/site.yml to configure the instances with HAProxy and Nginx.

## Testing

- Navigate to the public IP address of the HAProxy instance in a web browser.
- Refresh the page a few times to see the load balancer distribute the requests to the two Nginx servers.

## Cleanup

- Run terraform destroy in the infrastructure/terraform folder to destroy the AWS instances.

## Project structure
```
.
├── ansible
│   ├── ansible.cfg
│   ├── hosts.ini
│   ├── new_key
│   ├── new_key.pub
│   ├── pwd.txt
│   ├── roles
│   │   ├── haproxy
│   │   │   ├── handlers
│   │   │   │   └── main.yml
│   │   │   ├── tasks
│   │   │   │   └── main.yml
│   │   │   └── templates
│   │   │       └── haproxy.cfg
│   │   └── nginx
│   │       ├── handlers
│   │       │   └── main.yml
│   │       ├── tasks
│   │       │   └── main.yml
│   │       └── templates
│   │           └── nginx.conf
│   ├── site.yml
│   └── vault.yml
├── readme.md
└── terraform
    ├── main.tf
    ├── new-key.pem
    ├── outputs.tf
    ├── terraform.tfstate
    ├── terraform.tfstate.backup
    └── variables.tf
```
