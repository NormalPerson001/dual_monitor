# README.md

## Display Toggle Script

This script allows users to toggle between enabling or disabling the second display configuration on a system. It modifies the system configuration files to either turn on or turn off the secondary display upon reboot.

### Prerequisites

- Ensure you have `sudo` privileges as the script modifies system files.
- The script is intended for systems with NVIDIA GPUs and uses NVIDIA-specific tools like `nvidia-xconfig`.

### Usage

```bash
./<script_name> <on|off>
```

- Replace `<script_name>` with the name of the script file.
- Pass `on` to enable the second display, or `off` to disable it.

### Features

#### Turn on Second Display (`on`):
- Adds a configuration to blacklist the `nouveau` driver.
- Loads the `nvidia-drm` module.
- Generates an NVIDIA-specific Xorg configuration file for dual-display support.
- Adds autostart entries to initialize the second display automatically upon reboot.

#### Turn off Second Display (`off`):
- Removes the configurations added during the `on` operation.
- Restores the primary display configuration by deleting the Xorg and autostart files.

### Script Workflow

1. **Check for Arguments**
   - The script verifies that an argument (`on` or `off`) is provided.
   - If no argument is passed, it displays usage instructions and exits.

2. **On Argument: `on`**
   - Outputs a message indicating the second display is being configured.
   - Creates or updates the following files:
     - `/etc/modprobe.d/blacklist-nouveau.conf`: Blacklists the `nouveau` driver.
     - `/etc/X11/xorg.conf.d/xorg.conf`: Configures Xorg for NVIDIA.
     - `/etc/xdg/autostart/optimus.desktop` and `/usr/share/gdm/greeter/autostart/optimus.desktop`: Sets up autostart for dual-display initialization.
   - Prompts the user to reboot the system.

3. **Off Argument: `off`**
   - Outputs a message indicating the main display is being configured.
   - Deletes the configuration files created during the `on` operation.
   - Prompts the user to reboot the system.

4. **Invalid Arguments**
   - Displays an error message if the argument is not `on` or `off`.

### Example

#### Enable Second Display:
```bash
sudo ./display_toggle.sh on
```
Output:
```
Turning on the second display NOTE: This will turn on the second display when rebooted
Done!, Please reboot your system
```

#### Disable Second Display:
```bash
sudo ./display_toggle.sh off
```
Output:
```
Turning on the main display NOTE: This will turn off the second display when rebooted
Done!, Please reboot your system
```

### Notes
- **Reboot Required**: Changes take effect only after a reboot.
- **Caution**: Ensure you understand the modifications to system files before running the script.
- **Backup**: It is advisable to backup your existing configuration files.

### Author
NormalPerson001
GitHub: [NormalPerson001](https://github.com/NormalPerson001)
