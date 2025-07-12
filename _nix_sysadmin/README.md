```markdown
# 🛠️ Ansible Labs: UNIX/Linux System Administration Automation

!Build Status
!License

**Version:** Refer to file `_nix_sysadmin/VERSION`  
**Author:** _Michael D_  
**Contact:** _dtmghislain@gmail.com  

This repository contains Ansible playbooks, roles, and configurations to automate common UNIX/Linux system administration tasks. It is designed as a learning project and a toolkit for real-world automation.

---

## 📁 Project Structure

```text
_nix_sysadmin/
├── playbooks/         # Main playbooks to execute
├── roles/             # Reusable Ansible roles
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

---

## 🧩 Roles Overview

| Role Name | Description |
|-----------|-------------|
| `join_ad` | Joins a Linux host to an Active Directory domain |
| `ad_auth` | Configures AD-based authentication on Linux hosts |
| *(More roles coming soon...)* | |

---

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
