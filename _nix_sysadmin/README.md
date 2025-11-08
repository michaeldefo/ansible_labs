```markdown
# 🛠️ Ansible Labs: UNIX/Linux System Administration Automation

!Build Status
!License

**Version:** Refer to file `_nix_sysadmin/VERSION`  
**Author:** _Michael D_  
**Contact:** _dtmghislain@gmail.com  

This repository contains Ansible playbooks, roles, and configurations to automate common UNIX/Linux system administration tasks. It is designed as a learning project and a toolkit for real-world automation.

## 📁 Project Structure

```text
_nix_sysadmin/
├── playbooks/         # Main playbooks to execute
├── plabooks/roles/    # Reusable Ansible roles
├── inventory/         # Inventory files for different environments
├── group_vars/        # Group-level variable definitions
├── host_vars/         # Host-specific variable definitions
├── files/             # Static files used in roles/playbooks
├── templates/         # Jinja2 templates
├── logs/              # Output logs from playbook runs
└── VERSION            # Project version
```

---

## 🚀 Getting Started

### 1. Update Inventory

Edit the inventory file to reflect your target hosts:

```bash
_nix_sysadmin/inventory/hosts.ini
```

---

### 2. Run a Playbook

```bash
ansible-playbook -i _nix_sysadmin/inventory/hosts.ini _nix_sysadmin/playbooks/your_playbook.yml
```

---

## 🔐 Active Directory Integration

### 🔸 AD Join Role

**Syntax Check:**

```bash
ansible-playbook --syntax-check -vv _nix_sysadmin/playbooks/join_ad.yml
```

**Run Example:**

```bash
ansible-playbook -i _nix_sysadmin/inventory/hosts.ini _nix_sysadmin/playbooks/join_ad.yml \
  -e "ad_user=ad_admin ad_password='ad_admin_pwd' domain_name=domain.name realm_upper=DOMAIN.NAME dns_server_ip=127.0.0.1" \
  --limit ad_host \ #### optional to limit
  -vv | tee logs/join_ad_output.log
```

---

### 🔸 AD Authentication Role

**Syntax Check:**

```bash
ansible-playbook --syntax-check -vv _nix_sysadmin/playbooks/ad_auth.yml
```

**Run Example:**

```bash
ansible-playbook -i _nix_sysadmin/inventory/hosts.ini _nix_sysadmin/playbooks/ad_auth.yml \
  -e "domain=domain.name ad_admin_user=ad_admin dns_server_ip=127.0.0.1" \
  --limit auth_host \ #### optional to limit
  -vv | tee logs/ad_auth_output.log
```

### 🔸 Prometheus Node Exporter Installation on linux

**Syntax Check:**

```bash
ansible-playbook --syntax-check -vv _nix_sysadmin/playbooks/install_prometheus_exporter.yml
```

**Run Example:**

```bash
ansible-playbook -i _nix_sysadmin/inventory/hosts.ini _nix_sysadmin/playbooks/install_prometheus_exporter.yml \
  -e "node_exporter_version="{{ version }}" prometheus_server="{{ prometheus_url_server }}" node_exporter_port="{{ port_number }}" node_exporter_user="{{ user }}" \
  --limit auth_host \ #### optional to limit
  -vv | tee logs/ad_auth_output.log
```

### 🔸 Populate Prometheus config for scrapping nodes 

**Syntax Check:**

```bash
ansible-playbook --syntax-check -vv _nix_sysadmin/playbooks/add_node_exporter_promotheus.yml
```

**Run Example:**

```bash
ansible-playbook -i _nix_sysadmin/inventory/hosts.ini _nix_sysadmin/playbooks/add_node_exporter_promotheus.yml \
  -e "node_exporter_port="{{ node_exporter_port }}" dns_prometheus_server="{{ server_prometheus }}"   prometheus_server_port="{{ prometheus_server_port }}"" \
  --limit auth_host \ #### optional to limit
  -vv | tee logs/ad_auth_output.log
```
---

### 🔸 Installation of Control Pane node for K8S

**Syntax Check:**

```bash
ansible-playbook --syntax-check -vv _nix_sysadmin/playbooks/install_k8s_cluster_cp.yml
```

**Run Example:**

```bash
ansible-playbook -i _nix_sysadmin/inventory/hosts.ini _nix_sysadmin/playbooks/install_k8s_cluster_cp.yml \
  -e "url_endpoint_cp="{{ control_plane_endpoint }}" endpoint_port_cp="{{ cp_port }}"   cilium_network="{{ pod_subnet }}"" \
  kube_version="{{ kube_version }}" k8s_version="{{ k8s_version }}"
  --limit auth_host \ #### optional to limit
  -vv | tee logs/ad_auth_output.log
```
---

### 🔸 Installation of Worker node for K8S

**Syntax Check:**

```bash
ansible-playbook --syntax-check -vv _nix_sysadmin/playbooks/install_k8s_cluster_worker.yml
```

**Run Example:**

```bash
ansible-playbook -i _nix_sysadmin/inventory/hosts.ini _nix_sysadmin/playbooks/install_k8s_cluster_worker.yml \
  -e kubeadm_user="{{ k8s_user }}"  kube_version="{{ kube_version }}" k8s_version="{{ k8s_version }}"\
  join_cluster_cmd="{{ join_command }}"
  --limit auth_host \ #### optional to limit
  -vv | tee logs/ad_auth_output.log
```
---

## 🧩 Roles Overview

| Role Name | Description |
|-----------|-------------|
| `join_ad` | Joins a Linux host to an Active Directory domain |
| `ad_auth` | Configures AD-based authentication on Linux hosts |
| `install_node_exporter` | Install Prometheus Node Exporter on Host Linux |
| `add_node_exporter_prometheus` | Add Node Exporter Host to be scrapped by Prometheus Server |
| `install_k8s_cluster_cp` | Install a K8S Control Plane Cluster |
| `install_k8s_cluster_worker` | Install a K8S Worker Node |
|*(More Other Roles to come)*||
---

## 📌 Suivi des versions

| Version | Description                                                                                         | Date          | Auteur      |
|---------|-----------------------------------------------------------------------------------------------------|---------------|-------------|
| 1.0.0   | Initialisation du projet et organisation des fichiers                                               | Juillet 2025  | Michael D.  |
| 1.2.0   | Réorganisation des fichiers : déplacement du dossier `roles` vers `playbooks`                      | Octobre 2025  | Michael D.  |
| 1.3.0   | Ajout des `roles` et `playbooks` pour l'installation d'un control pane et de node worker K8S                     | Octobre 2025  | Michael D.  |

## 🤝 Contributing

Feel free to fork, modify, and contribute to this project. If you encounter issues or have suggestions, open an issue or contact me directly.

---

## 🐞 Feature Requests & Bug Tracking

To track development progress or report bugs:

- 📌 GitHub Issues
- 🗂️ Use labels like `bug`, `enhancement`, `help wanted`, etc.
- ✅ Check existing issues before submitting new ones.

---

## 📬 Need Help?

If you need assistance or have questions about using or extending this project, reach out via:

- 📧 Email: _dtmghislain@gmail_
- 🐙 GitHub: michaeldefo
```

---
