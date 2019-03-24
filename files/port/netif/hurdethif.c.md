The ethernet devices module

#### hurdethif_device_get_flags() ####

    static error_t
    hurdethif_device_get_flags (struct netif *netif, uint16_t * flags)

#### hurdethif_device_set_flags() ####

    static error_t
    hurdethif_device_set_flags (struct netif *netif, uint16_t flags)

#### hurdethif_device_open() ####

    static error_t
    hurdethif_device_open (struct netif *netif)

#### hurdethif_device_close() ####

    static error_t
    hurdethif_device_close (struct netif *netif)

#### hurdethif_output() ####

    static error_t
    hurdethif_output (struct netif *netif, struct pbuf *p)

#### hurdethif_input() ####

    void
    hurdethif_input (struct netif *netif, struct net_rcv_msg *msg)

This function attaches the new packet to the pbuf chain and calls input function of the netif. TODO: attaching to pbuff chain

#### hurdethif_demuxer() ####

    int
    hurdethif_demuxer (mach_msg_header_t * inp, mach_msg_header_t * outp)

This is the demuxer function that handles all the incoming RPCs from the device.
First, it extracts the local port to which the mesasge was sent. This port is then matched with available interfaces. If a matching interface is not found, 1 is returned. Otherwise, *hurdethif_input* is called with the corresponding interafce and the message.

#### hurdethif_device_update_mtu() ####

    static error_t
    hurdethif_device_update_mtu (struct netif *netif, uint32_t mtu)

#### hurdethif_device_terminate() ####

    static error_t
    hurdethif_device_terminate (struct netif *netif)

#### hurdethif_device_init() ####

    error_t
    hurdethif_device_init (struct netif * netif)

#### hurdethif_input_thread()

    static void *
    hurdethif_input_thread (void *arg)

Attaches *hurdethif_demuxer* to handle messages to *ethport-bucket*.

#### hurdethif_module_init()

    error_t
    hurdethif_module_init ()

This function initializes the thread for incoming data. It creates *etherport-bucket* and its port class. It then creates a pthread and links *hurdethif_input_thread* to it. The pthread is then detached.