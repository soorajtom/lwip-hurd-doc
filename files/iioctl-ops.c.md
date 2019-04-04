Ioctls for network device configuration

#### get_if() ####

    static struct netif *
    get_if (char *name)

Returns the interface with the given NAME.

#### siocgifXaddr() ####

    static kern_return_t
    siocgifXaddr (struct sock_user *user,
              ifname_t ifnam, sockaddr_t * addr, enum siocgif_type type)

Returns the specified TYPE of address of the interface.

#### lwip_S_iioctl_siocsifflags() ####

    kern_return_t
    lwip_S_iioctl_siocsifflags (struct sock_user * user,
                    ifname_t ifnam,
                    short flags)

Sets flags for a network interface using [if_change_flags](../../files/port/netif/ifcommon.c).

#### lwip_S_iioctl_siocgifflags() ####

    kern_return_t
    lwip_S_iioctl_siocgifflags (struct sock_user * user, char *name, short *flags)

Get flags of a network interface.

#### lwip_S_iioctl_siocgifmetric() ####

    kern_return_t
    lwip_S_iioctl_siocgifmetric (struct sock_user * user,
                     ifname_t ifnam,
                     int *metric)

Returns the metric of the interface
#### lwip_S_iioctl_siocsifmetric() ####

    kern_return_t
    lwip_S_iioctl_siocsifmetric (struct sock_user * user,
                     ifname_t ifnam,
                     int metric)

Sets metric of a network interface. Not implemented yet.

#### lwip_S_iioctl_siocdifaddr() ####

    kern_return_t
    lwip_S_iioctl_siocdifaddr (struct sock_user * user,
                   ifname_t ifnam,
                   sockaddr_t addr)

Deletes interface address. Not implemented yet.

#### lwip_S_iioctl_siocgifhwaddr() ####

    error_t
    lwip_S_iioctl_siocgifhwaddr (struct sock_user * user,
                     ifname_t ifname,
                     sockaddr_t * addr)

Gets the hardware address of a network interface.

#### lwip_S_iioctl_siocgifmtu() ####

    error_t
    lwip_S_iioctl_siocgifmtu (struct sock_user * user, ifname_t ifnam, int *mtu)

Gets mtu of a network interface.

#### lwip_S_iioctl_siocsifmtu() ####

    error_t
    lwip_S_iioctl_siocsifmtu (struct sock_user * user, ifname_t ifnam, int mtu)

Sets mtu of a network interface.

#### lwip_S_iioctl_siocgifindex() ####

    error_t
    lwip_S_iioctl_siocgifindex (struct sock_user * user,
                    ifname_t ifnam,
                    int *index)

Gets index number of a network interface.

#### lwip_S_iioctl_siocgifname() ####

    error_t
    lwip_S_iioctl_siocgifname (struct sock_user * user,
                   ifname_t ifnam,
                   int *index)

Gets name of a network interface from index number.    
