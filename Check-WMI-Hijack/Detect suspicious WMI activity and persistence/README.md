# WMI Hijack Detection Script

[![PowerShell](https://img.shields.io/badge/Language-PowerShell-blue?logo=powershell)](https://docs.microsoft.com/en-us/powershell/)  
[![Windows Security](https://img.shields.io/badge/Windows-Security-blue?logo=windows)](https://learn.microsoft.com/en-us/windows/security/)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)  
[![WMI Security](https://img.shields.io/badge/WMI-Security-critical?style=flat&logo=windows)](https://learn.microsoft.com/en-us/windows/win32/wmisdk/wmi-start-page)  
[![Quick Start](https://img.shields.io/badge/Quick%20Start-Clone%20Instructions-blueviolet?style=for-the-badge)](#how-to-use)

---

## What is this?

This script was created after learning about WMI hacking techniques attackers use to gain persistence on Windows systems. It performs a series of checks against Windows Management Instrumentation (WMI) event filters, consumers, bindings, startup folders, registry autoruns, and suspicious services to detect signs of WMI hijacking and persistence abuse.

It has been tested on Windows 11 and provides output highlighting potential anomalies in red for easy review.

---

## Why?

WMI is a powerful Windows feature often abused by attackers for stealthy persistence. Traditional antivirus tools can miss such abuses, so this script helps security teams and managers identify suspicious WMI-related configurations and common startup persistence points.

---

## What does it check?

- **WMI Event Filters, Consumers, and Bindings**  
  Looks for WMI components that can trigger malicious scripts or commands.

- **Suspicious WMI Classes**  
  Enumerates classes in key WMI namespaces that could indicate tampering.

- **Startup Folders**  
  Scans user and all-users startup folders for suspicious executables.

- **Registry Autorun Keys**  
  Checks common registry paths for startup entries.

- **Suspicious Services**  
  Identifies services running unusual commands, especially involving PowerShell or WMI hosts.

---

## How to use?

1. Download the script: `Check-WMI-Hijack.ps1`  
2. Open PowerShell as Administrator.  
3. Run:

    ```powershell
    Set-ExecutionPolicy Bypass -Scope Process -Force
    .\Check-WMI-Hijack.ps1
    ```

4. Review output for any red-highlighted anomalies.

---

## Who is this for?

- IT Managers & Security Teams wanting to identify stealthy persistence threats.  
- Recruiters & Hiring Managers interested in practical cybersecurity detection skills.  
- Cybersecurity professionals and enthusiasts learning about WMI exploitation and detection.

---

## Tested on

- Windows 11 Pro (Fully patched)

---

## License

MIT License © 2025 Shane Wilson

---

## Contact

If you want to discuss WMI security, script improvements, or collaboration opportunities, feel free to reach out!

---

## 🤳 Connect With Me

<div align="left">
    <a href="https://www.linkedin.com/in/shane-wilson/"><img src="https://img.shields.io/badge/-LinkedIn-0072b1?&style=for-the-badge&logo=linkedin&logoColor=white" /></a>
</div>

[linkedin]: https://linkedin.com/in/shane-wilson
