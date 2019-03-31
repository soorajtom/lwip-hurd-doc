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

Configures the loopback interface. It sets the init function as [hurdloopif_device_init](/files/port/netif/hurdloopif.c) and calls [if_init](/files/port/netif/ifcommon.c).

#### remove_ifs() ####
    void remove_ifs ()

Removes interfaces other than the loopback interface. The common [if_terminate](/files/port/netif/ifcommon.c) function is called which will close, terminate and free its resources.

#### init_ifs()* ####
    void init_ifs (void *arg)

Initializes the interfaces given by the user through the command line.

* If the *netif_list* contains only one interface, the loopback interface is initialized. If it contains more than one interface, the interface other than loopback is removed.\
* The loop goes through the list of interfaces backwards.
* The interface is ignored if it has not been completely configures or the addresses are invalid.
* [create_netif_state](/files/lwip-util.c) is called to set the init function.
* [netifapi_netif_add](https://www.nongnu.org/lwip/2_1_x/group__netifapi__netif.html#gacc063c5a3071e34eec7376651e35a519) is called with the parameters to create the new interface.
* The IPv6 configuration is then added.
* The interface is set up and it is set as the default interface if its address is valid. This way, the last one to be set(first on the list) becomes the default interface.
* The hook is freed and the control is returned from the function.

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