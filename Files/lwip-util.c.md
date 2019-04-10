LwIP management module.

[[!toc]]

#### create_netif_state() ####
    static error_t
    create_netif_state (char *name, struct ifcommon *ifc)

Detects the proper module for the given device name and sets its init callback ([hurdtunif_device_init](../../files/port/netif/hurdtunif.c) or [hurdethif_device_init](../../files/port/netif/hurdethif.c)).

#### ipv4config_is_valid() ####
    static int
    ipv4config_is_valid (uint32_t addr, uint32_t netmask,
                 uint32_t gateway, uint32_t broadcast)

Validates the given addresses.

* Checks the netmask
* Checks if the gateway is in the same network as that of the address.
* Checks if the broadcast address given is the default broadcast address.

#### init_loopback() ####
    static void
    init_loopback ()

Configures the loopback interface. It sets the init function as [hurdloopif_device_init](../../files/port/netif/hurdloopif.c) and calls [if_init](../../files/port/netif/ifcommon.c).

#### remove_ifs() ####
    void remove_ifs ()

Removes interfaces other than the loopback interface. The common [if_terminate](../../files/port/netif/ifcommon.c) function is called which will close, terminate and free its resources.

#### init_ifs() ####
    void init_ifs (void *arg)

Initializes the interfaces given by the user through the command line.

* If the *netif_list* contains only one interface, the loopback interface is initialized. If it contains more than one interface, the interface other than loopback is removed.
* The loop goes through the list of interfaces backwards.
* The interface is ignored if it has not been completely configures or the addresses are invalid.
* [create_netif_state](../../files/lwip-util.c) is called to set the init function.
* [netifapi_netif_add](https://www.nongnu.org/lwip/2_1_x/group__netifapi__netif.html#gacc063c5a3071e34eec7376651e35a519) is called with the parameters to create the new interface.
* The IPv6 configuration is then added.
* The interface is set up and it is set as the default interface if its address is valid. This way, the last one to be set(first on the list) becomes the default interface.
* The hook is freed and the control is returned from the function.

#### update_if() ####
    static error_t
    update_if (struct netif *netif, uint32_t addr, uint32_t netmask,
           uint32_t peer, uint32_t broadcast, uint32_t gateway,
           uint32_t * addr6, uint8_t * addr6_prefix_len)

Updates the IP configuration of an interface. Uses [netifapi_netif_set_addr](https://www.nongnu.org/lwip/2_1_x/group__netifapi__netif.html#ga31755ea6dbb213236bfce19bcbe8c973) to set the new IP addresses. [netif_ip6_addr_set](https://www.nongnu.org/lwip/2_1_x/group__netif__ip6.html#gae21572fdbd8664d22a1b281a6c31c9bb) and [netif_ip6_addr_set_state](https://www.nongnu.org/lwip/2_1_x/group__netif__ip6.html#ga9cde7286535c7f037a9b16052561b91f) are used to set the IPv6 addresses.

#### inquire_device() ####
    void
    inquire_device (struct netif *netif, uint32_t * addr, uint32_t * netmask,
            uint32_t * peer, uint32_t * broadcast, uint32_t * gateway,
            uint32_t * addr6, uint8_t * addr6_prefix_len)

Gets the IP configuration of a device. [netif_ip4_addr](https://www.nongnu.org/lwip/2_1_x/group__netif__ip4.html#gac9b6e63b5dd2968fe0a4813f3eefb55d), [netif_ip4_netmask](https://www.nongnu.org/lwip/2_1_x/group__netif__ip4.html#ga952d1436f2428b92fc8197bcf2f8fca3), [netif_ip4_gw](https://www.nongnu.org/lwip/2_1_x/group__netif__ip4.html#ga86d69faf416765b7f8faf60a43cc50da) and [netif_ip6_addr](https://www.nongnu.org/lwip/2_1_x/group__netif__ip6.html#ga7ec0623f1a858a0cdb187beaa89df365) are used to get the addresses properly.

#### configure_device() ####
    error_t
    configure_device (struct netif *netif, uint32_t addr, uint32_t netmask,
              uint32_t peer, uint32_t broadcast, uint32_t gateway,
              uint32_t * addr6, uint8_t * addr6_prefix_len)

Checks and changes the IP configuration of an interface. [ipv4config_is_valid](.) checks the validity of the addresses and [update_if](.) sets them.
