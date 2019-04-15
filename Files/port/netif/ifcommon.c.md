Common interface functions for all kinds of devices.

[[!toc]]

#### if_open() #####
    static error_t
    if_open (struct netif *netif)

Opens the device and sets the interface up. If the `open` callback for the interface was set, it is called. Otherwise, the device flags are set for `IFF_UP` and `IFF_RUNNING` (more about the flags [here](http://man7.org/linux/man-pages/man7/netdevice.7.html)) and [netif_set_up](https://www.nongnu.org/lwip/2_1_x/group__netif.html#gaf19693be401a265a52d2a56c65753121) is called.

#### if_close() #####
    static error_t
    if_close (struct netif *netif)

Closes the device and sets the interface down. If the `close` callback for the interface was set, it is called. Otherwise, the device flags are unset for `IFF_UP` and `IFF_RUNNING` and [`netif_set_down`](https://www.nongnu.org/lwip/2_1_x/group__netif.html#ga641d07ed8c31fe5306bc01605a6790cf) is called.

#### if_init() #####
    err_t
    if_init (struct netif * netif)

Common initialization callback for all kinds of devices. 
This function doesn't assume there's a device nor tries to open it.
If a device is present, it must be opened from the `ifc->init()` callback.

#### if_terminate() #####
    error_t
    if_terminate (struct netif * netif)

Tries to close the device and frees the resources. The device is closed ([if_close](.)) and the terminate routine of the interface is called. It is set to [[`hurdethif_device_terminate`|hurdethif.c/#hurdethif_device_terminate.28.29]] for interfaces other than loopback.

#### if_change_flags() #####
    error_t
    if_change_flags (struct netif * netif, uint16_t flags)

Changes device flags for netif. It also closes or opens the device accordingly.
