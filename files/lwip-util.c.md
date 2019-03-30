LwIP management module.

#### create_netif_state() ####
    static error_t
    create_netif_state (char *name, struct ifcommon *ifc)

#### ipv4config_is_valid() ####
    static int
    ipv4config_is_valid (uint32_t addr, uint32_t netmask,
                 uint32_t gateway, uint32_t broadcast)

#### init_loopback() ####
    static void
    init_loopback ()

#### remove_ifs() ####
    void remove_ifs ()

#### init_ifs()* ####
    void init_ifs (void *arg)

Initializes the interfaces given by the user through the command line.

* If the *netif_list* contains only one interface, the loopback interface is initialized. If it contains more than one interface, the interface other than loopback is removed.

#### update_if() ####
    static error_t
    update_if (struct netif *netif, uint32_t addr, uint32_t netmask,
           uint32_t peer, uint32_t broadcast, uint32_t gateway,
           uint32_t * addr6, uint8_t * addr6_prefix_len)

#### inquire_device() ####
    void
    inquire_device (struct netif *netif, uint32_t * addr, uint32_t * netmask,
            uint32_t * peer, uint32_t * broadcast, uint32_t * gateway,
            uint32_t * addr6, uint8_t * addr6_prefix_len)

#### configure_device() ####
    error_t
    configure_device (struct netif *netif, uint32_t addr, uint32_t netmask,
              uint32_t peer, uint32_t broadcast, uint32_t gateway,
              uint32_t * addr6, uint8_t * addr6_prefix_len)