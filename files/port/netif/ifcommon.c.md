Common interface functions for all kinds of devices.

#### if_open() #####
    static error_t
    if_open (struct netif *netif)

#### if_close() #####
    static error_t
    if_close (struct netif *netif)

#### if_init() #####
    error_t
    if_init (struct netif * netif)

Common initialization callback for all kinds of devices. 
This function doesn't assume there's a device nor tries to open it.
If a device is present, it must be opened from the `ifc->init()` callback.

#### if_terminate() #####
    error_t
    if_terminate (struct netif * netif)

Tries to close the device and frees the resources. The device is closed ([if_close](/files/port/netif/ifcommon.c)) and the terminate routine of the interface is called. It is set to [hurdethif_device_terminate](/files/port/netif/hurdethif.c) for interfaces other than loopback.

#### if_change_flags #####
    error_t
    if_change_flags (struct netif * netif, uint16_t flags)