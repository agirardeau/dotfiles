
# * System
#   * Display
#     * Night Light (on)
#   * Sound
#     * Mono audio (On)
# * Personalization
#   * Background
#     * Personalize ("Picture", browse photos)
#   * Colors
#     * Dark Mode (on)
#     * Transparency effects (off)
#     * Theme color on taskbar (no)
#     * Theme color on borders (yes, optionally)
#   * Lock screen
#     * Personalize (picture)
#       * Picture
#       * Get fun facts (no)
#     * Lock screen status (None)
#     * Show the lock screen background picture on the sign in screen (on)
#   * Start
#     * Layout (more pins)
#     * Show ... (all off except recently opened items)
#   * Taskbar
#     * Widgets (off)
#     * Other system tray icons (all off, except "Hidden icon menu")
#     * Behaviors
#       * Alignment (Left)
# * Apps
#   * Installed apps (delete anything dumb)
#   * Startup (everything dumb off, optionally terminal on)
# * Privacy & security
#   * General (turn off dumb stuff)
#   * Inking and typing personalization (off)
#   * Activity history (off)
#   * Search permissions (everything off)

### System > Display

# Night Light
# From https://superuser.com/questions/1200222/configure-windows-creators-update-night-light-via-registry

Function Set-BlueLightReductionSettings {
    [CmdletBinding()]
    Param (
        [Parameter(Mandatory=$true)] [ValidateRange(0, 23)] [int]$StartHour,
        [Parameter(Mandatory=$true)] [ValidateSet(0, 15, 30, 45)] [int]$StartMinutes,
        [Parameter(Mandatory=$true)] [ValidateRange(0, 23)] [int]$EndHour,
        [Parameter(Mandatory=$true)] [ValidateSet(0, 15, 30, 45)] [int]$EndMinutes,
        [Parameter(Mandatory=$true)] [bool]$Enabled,
        [Parameter(Mandatory=$true)] [ValidateRange(1200, 6500)] [int]$NightColorTemperature
    )
    $data = (0x43, 0x42, 0x01, 0x00, 0x0A, 0x02, 0x01, 0x00, 0x2A, 0x06)
    $epochTime = [System.DateTimeOffset]::new((date)).ToUnixTimeSeconds()
    $data += $epochTime -band 0x7F -bor 0x80
    $data += ($epochTime -shr 7) -band 0x7F -bor 0x80
    $data += ($epochTime -shr 14) -band 0x7F -bor 0x80
    $data += ($epochTime -shr 21) -band 0x7F -bor 0x80
    $data += $epochTime -shr 28
    $data += (0x2A, 0x2B, 0x0E, 0x1D, 0x43, 0x42, 0x01, 0x00)
    If ($Enabled) {$data += (0x02, 0x01)}
    $data += (0xCA, 0x14, 0x0E)
    $data += $StartHour
    $data += 0x2E
    $data += $StartMinutes
    $data += (0x00, 0xCA, 0x1E, 0x0E)
    $data += $EndHour
    $data += 0x2E
    $data += $EndMinutes
    $data += (0x00, 0xCF, 0x28)
    $data += ($NightColorTemperature -band 0x3F) * 2 + 0x80
    $data += ($NightColorTemperature -shr 6)
    $data += (0xCA, 0x32, 0x00, 0xCA, 0x3C, 0x00, 0x00, 0x00, 0x00, 0x00)
    Set-ItemProperty -Path 'HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\CloudStore\Store\DefaultAccount\Current\default$windows.data.bluelightreduction.settings\windows.data.bluelightreduction.settings' -Name 'Data' -Value ([byte[]]$data) -Type Binary
}

Set-BlueLightReductionSettings `
  -StartHour 7 `
  -StartMinutes 0 `
  -EndHour 21 `
  -EndMinutes 15 `
  -Enabled $true `
  -NightColorTemperature 6000


### Personalization > Colors

# Dark mode

Set-Item-Property `
 -Path "HKCM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
 -Name "SystemUsesLightTheme" `
 -Value $false

Set-Item-Property `
 -Path "HKCM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
 -Name "AppsUseLightTheme" `
 -Value $false

# Transparency effects

Set-Item-Property `
 -Path "HKCM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
 -Name "EnableTransparency" `
 -Value $false

# Theme color on taskbar and start menu

Set-Item-Property `
 -Path "HKCM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" `
 -Name "ColorPrevalence" `
 -Value 0


### Personalization > Taskbar



