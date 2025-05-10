# 🗃️ Backup Script Overview

This backup script is intended to perform a **compressed backup** of your specified folder.

---

## ⚙️ Configuration

Before using the script, please edit the following variables inside the script:

```bash
backup_directory="/var/db"        # Edit: directory to be backed up
backup_destination="/var/backup"  # Edit: archived backup destination
retain_time=7                     # Optional: number of days to keep backups (default is 7)
```

---

## 📜 Log Rotation

The script also implements **log rotation** to conserve space.  
It keeps a maximum of **5 rotated logs**, in addition to the latest log.

You can change the **log location** by editing:

```bash
mkdir -p /var/log/backup
log_file="/var/log/backup/backup.log"
```

---

## ▶️ How to Run

1. **Make the script executable**:
   ```bash
   chmod u+x ./backup.sh
   ```

2. **Run it manually**:
   ```bash
   bash ./backup.sh
   ```

