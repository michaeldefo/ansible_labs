# Rôle Ansible : install_node_exporter

Ce rôle permet d'installer le node exporter prometheus sur une machine de type *NIX

## Variables

- `node_exporter_version`: Version du client node exporter
- `prometheus_server`: Serveur de collecte de données pour node exporter 
- `node_exporter_port`: Port d'écoute pour node exporter
- `node_exporter_user`: Utilisateur Systeme pour le service prometheus node exporter

## Exemple d'utilisation

```yaml
---
# Playbook Ansible pour joindre un hôte Linux à un domaine Active Directory
- name: Deploy Node Exporter on *NIX Hosts
  hosts: all
  become: true
  vars:
    node_exporter_version: "{{ version }}"                           ############## node_exporter_version: "1.7.0"
    prometheus_server: "{{ prometheus_url_server }}"             ############## prometheus_server: "http://your.prometheus.server:9090" 
    node_exporter_port: "{{ port_number }}"                                  ############## node_exporter_port: 9100   
    node_exporter_user: "{{ user }}"                    ############## node_exporter_user: "node_exporter"  
  roles:
    - install_node_exporter


# Update Value with your's values
ansible-playbook -i inventory.ini install_prometheus_exporter.yml -e "ad_unode_exporter_versionser=#node_exporter_version# prometheus_server=#prometheus_server# node_exporter_port=#node_exporter_port# node_exporter_user=#node_exporter_user#"




