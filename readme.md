# Load Balanced Nginx Servers with HAProxy

This project sets up two Nginx web servers and an HAProxy load balancer using Terraform and Ansible. The load balancer distributes incoming requests to the two Nginx servers in a round-robin fashion.

## Prerequisites

* Terraform installed
* Ansible installed.
* AWS CLI configured with valid AWS credentials.

## Setup

- Clone this repository and navigate to the root directory.
- Run terraform init and terraform apply in the infrastructure/terraform folder to create the AWS instances.
- Replace <haproxy_public_ip_from_terraform>, <nginx1_public_ip_from_terraform>, and <nginx2_public_ip_from_terraform> in ansible/hosts.ini with the actual public IP addresses from the Terraform output.
- Run ansible-playbook -i ansible/hosts.ini ansible/site.yml to configure the instances with HAProxy and Nginx.

## Testing

- Navigate to the public IP address of the HAProxy instance in a web browser.
- Refresh the page a few times to see the load balancer distribute the requests to the two Nginx servers.

## Cleanup

- Run terraform destroy in the infrastructure/terraform folder to destroy the AWS instances.

## Project structure

.
├── infrastructure
│   └── terraform
│       ├── main.tf
│       ├── outputs.tf
│       └── variables.tf
└── ansible
    ├── hosts.ini
    ├── site.yml
    └── roles
        ├── haproxy
        │   ├── tasks
        │   │   └── main.yml
        │   ├── handlers
        │   │   └── main.yml
        │   └── templates
        │       └── haproxy.cfg
        └── nginx
            ├── tasks
            │   └── main.yml
            ├── handlers
            │   └── main.yml
            └── templates
                └── nginx.conf
