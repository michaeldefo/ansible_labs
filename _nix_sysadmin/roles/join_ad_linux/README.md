# Rôle Ansible : join_ad_linux

Ce rôle permet de joindre une machine CentOS Stream 9 à un domaine Active Directory.

## Variables

- `domain_name`: Nom du domaine AD (ex: lab.local)
- `ad_user`: Utilisateur avec droits d'administration
- `ad_password`: Mot de passe de l'utilisateur
- `dns_server_ip`: Adresse IP du serveur DNS
- `realm_upper`: Nom du domaine en majuscules (ex: LAB.LOCAL)

## Exemple d'utilisation

```yaml
---
# Playbook Ansible pour joindre un hôte Linux à un domaine Active Directory
- name: Join Linux host to Active Directory
  hosts: all
  become: true
  vars:
    ad_user: "{{ ad_user }}"
    ad_password: "{{ ad_password }}"
    domain_name: "{{ domain_name }}"
    realm_upper: "{{ realm_upper }}"
    dns_server_ip: "{{ dns_server_ip }}"
  roles:
    - join_ad_linux


# Update Value with your's values
ansible-playbook -i inventory.ini join_ad.yml -e "ad_user=#AD_Admin# ad_password=#SuperSecret# domain_name=#domain.lab.local# realm_upper=#LAB.LOCAL# dns_server_ip=#192.168.1.103#"




