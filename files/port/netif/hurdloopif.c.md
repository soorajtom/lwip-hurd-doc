Loopback devices module.

#### hurdloopif_device_set_flags() ####

    static error_t
    hurdloopif_device_set_flags (struct netif *netif, uint16_t flags)

Sets the device flags.

#### hurdloopif_device_update_mtu() ####

    static error_t
    hurdloopif_device_update_mtu (struct netif *netif, uint32_t mtu)

Updates the device MTU.

#### hurdloopif_device_terminate() ####

    static error_t
    hurdloopif_device_terminate (struct netif *netif)

Releases all resources of the netif.

#### hurdloopif_device_init() ####

    err_t
    hurdloopif_device_init (struct netif *netif)

Initializes the loopback interface.
