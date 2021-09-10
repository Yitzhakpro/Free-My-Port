# Free My Port

Tired of getting:

```
Port [PORT] is already in use
```

use this tool to free your port

## Compile & Run

Install ps2exe Module

```bash
Install-Module ps2exe

# output:
# Untrusted repository
#  You are installing the modules from an untrusted repository. If you trust this repository, change
#  its InstallationPolicy value by running the Set-PSRepository cmdlet. Are you sure you want to
#  install the modules from 'PSGallery'?
#  [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "N"): Y
```

Compile the powershell script

```bash
Invoke-ps2exe .\free_my_port.ps1 .\free_my_port.exe
```
