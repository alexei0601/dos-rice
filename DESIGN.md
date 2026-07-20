# Design Decisions

## Why custom scripts?

This project uses custom scripts for several system functions instead of relying only on the default modules provided by Waybar.

The main reason is having more control over how information is collected, processed, and displayed.

Waybar's built-in modules are useful and work well for many common use cases. However, this rice is designed around a specific visual style and a high level of customization. Custom scripts make it easier to control the behavior and output of each component.

## Waybar modules

This rice intentionally uses only a small number of Waybar's built-in modules:

* `user`
* `cpu`
* `battery`
* `clock`

These modules are used directly because their functionality is sufficiently generic and does not require additional system-specific logic.

The rest of the system information displayed in Waybar is provided through custom scripts.

## Custom system scripts

Some of the current scripts are:

* `temperature.sh` -> CPU temperature monitoring
* `memory.sh` -> RAM usage monitoring
* `volume.sh` -> Audio information and control
* `network.sh` -> Network interface and traffic monitoring

These scripts are used as data providers for Waybar and collect information directly from the Linux system interfaces when possible:

* `/sys/class/thermal` for temperature sensors
* `/proc/meminfo` for memory information
* PipeWire/WirePlumber tools for audio
* `/sys/class/net` and `iproute2` for networking

The goal is to keep the visual interface separate from the logic that collects system information.

## Why not only use built-in modules?

Waybar modules are convenient, but custom scripts provide:

* More control over the output format
* A consistent DOS-style interface
* Easier debugging
* More control over how data is collected
* Better portability between different machines

For example, the network script detects the active network interface instead of depending on a specific interface name such as `enp4s0` or `wlp0s20f3`.

It can also recognize different naming schemes:

* `wl*` for WiFi
* `en*` and `eth*` for Ethernet
* Virtual interfaces

## Portability

The scripts try to avoid hardcoded hardware-specific values whenever possible.

For example:

* Temperature sensors are detected dynamically.
* The active network interface is detected through the default route.
* Memory usage is read directly from the Linux system.
* Audio information is obtained from the active audio system.

This makes the project easier to use on different machines.

## Project philosophy

This project is not only a collection of configuration files.

It is also an experiment in building a personal Linux desktop environment from individual components.

Waybar provides the visual interface.

The custom scripts provide the system information.

This separation makes the system easier to understand, debug, and customize.
