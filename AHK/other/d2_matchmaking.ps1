if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

New-NetFirewallRule -DisplayName "Destiny2-Solo-1" -Direction Outbound -RemotePort 27000-27200,3097 -Protocol TCP -Action Block

New-NetFirewallRule -DisplayName "Destiny2-Solo-2" -Direction Outbound -RemotePort 27000-27200,3097 -Protocol UDP -Action Block

New-NetFirewallRule -DisplayName "Destiny2-Solo-3" -Direction Inbound -RemotePort 27000-27200,3097 -Protocol TCP -Action Block

New-NetFirewallRule -DisplayName "Destiny2-Solo-4" -Direction Inbound -RemotePort 27000-27200,3097 -Protocol UDP -Action Block

Write-Host "Destiny 2 Solo mode activated. Press Enter to deactivate solo mode."

Read-Host

Remove-NetFirewallRule -DisplayName "Destiny2-Solo-1"

Remove-NetFirewallRule -DisplayName "Destiny2-Solo-2"

Remove-NetFirewallRule -DisplayName "Destiny2-Solo-3"

Remove-NetFirewallRule -DisplayName "Destiny2-Solo-4"