# Rôle Ansible : add_node_exporter_to_prometeus

Ce rôle permet d'ajouter un node exporter prometheus sur une machine de type *NIX à un serveur Prometheus

## Variables 
- `node_exporter_port`: Port d'écoute pour node exporter
- `dns_prometheus_server`: Serveur Promotheus

## Exemple d'utilisation

```yaml
---
# Playbook Ansible pour ajouter un node exporter prometheus sur une machine de type *NIX à un serveur Prometheus
- name: Ajouter Node Exporter à Prometheus
  hosts: all
  become: true
  vars:
     node_exporter_port: "{{ node_exporter_port }}" 
     dns_prometheus_server: "{{ dns_prometheus_server }}" 

  roles:
    - add_node_exporter_to_promotheus


# Update Value with your's values
ansible-playbook -i inventory.ini add_node_exporter_to_prometheus.yml -e "node_exporter_port=#node_exporter_port#,     dns_prometheus_server=#dns_prometheus_server#"




