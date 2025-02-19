import subprocess
import os

def get_backlight_device():
    """
    Detects and returns the first available backlight device.

    Returns:
        str: The name of the first available backlight device.
        None: If no backlight device is found.
    """
    backlight_dir = "/sys/class/backlight"
    if os.path.isdir(backlight_dir):
        devices = os.listdir(backlight_dir)
        if len(devices) > 0:
            return devices[0]
    return None

def get_wireless_interface():
    """
    Dynamically detect the wireless network interface.

    Returns:
        str: Name of the wireless network interface.
    """
    result = subprocess.run(["ip", "link"], capture_output=True, text=True, check=True)
    for line in result.stdout.split("\n"):
        if "wlan" in line or "wlp" in line:
            return line.split(":")[1].strip()
    return "wlan0"
