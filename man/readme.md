# Create a bootable sd-card
```
xz -dc /path/to/uui.img.xz | sudo dd of=/dev/sdX bs=1M conv=fsync
```

# Interactive Update
## Turn on the device, stop in U-boot and issue:
```
env default -a; saveenv;
```

## Insert sd-card into a boot slot and issue:
```
reset
```

Let the U-boot get updated,wait for:
```
Remove the sd-card and reset the board
```
## Done

# Non-Interactive Update

Note: The device can be updated w/out any user interactions in case that the default boot environment was not changed.

## Insert sd-card into a boot slot.
## Turn on the device.
Let the U-boot get updated,wait for:
```
Remove the sd-card and reset the board
```
## Done
