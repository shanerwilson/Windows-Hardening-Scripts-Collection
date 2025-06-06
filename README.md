# Windows Hardening Scripts Collection

[![PowerShell](https://img.shields.io/badge/Language-PowerShell-blue?logo=powershell)](https://docs.microsoft.com/en-us/powershell/)  
[![Windows Security](https://img.shields.io/badge/Windows-Security-blue?logo=windows)](https://learn.microsoft.com/en-us/windows/security/)  
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)

---

## Overview

Welcome to the **Windows Hardening Scripts Collection** — a curated set of PowerShell scripts designed to help detect, mitigate, and prevent common Windows security risks and attack vectors.

These scripts focus on key areas including:  
- WMI (Windows Management Instrumentation) monitoring and hardening  
- Startup and persistence point detection  
- Registry autorun analysis  
- Suspicious service detection  
- And more...

Each script is modular and self-contained, making it easy to run individual checks or combine them into larger automation workflows.

---

## Why Use These Scripts?

Windows environments are a common target for attackers leveraging persistence and lateral movement techniques. This repository empowers security professionals, system administrators, and auditors to:

- Identify potential compromises early  
- Enforce best practices for system hardening  
- Automate routine security audits  
- Increase visibility into suspicious activity  

---

Each folder contains the PowerShell script and a dedicated README explaining:  
- Purpose and functionality  
- How to run the script  
- Interpretation of results  
- Additional notes  

---

## Getting Started

Navigate to the folder of the script you want to run

## Powershell

cd Windows-Hardening\Check-WMI-Hijack
Run the script in PowerShell (you may need to set execution policy)

## Powershell

Set-ExecutionPolicy Bypass -Scope Process -Force
.\Check-WMI-Hijack.ps1

## Contributions & Feedback
Contributions, issues, and feedback are welcome! Feel free to open an issue or submit a pull request to improve scripts or add new functionality.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

Connect with me on LinkedIn to learn more.

Thank you for visiting!
