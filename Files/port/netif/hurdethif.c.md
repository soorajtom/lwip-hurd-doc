The ethernet devices module

[[!toc  ]]

#### hurdethif_device_get_flags() ####

    static error_t
    hurdethif_device_get_flags (struct netif *netif, uint16_t * flags)

Gets the device flags. [device_get_status](https://www.gnu.org/software/hurd/gnumach-doc/Device-Status.html) gets the device status which contains the flags.

#### hurdethif_device_set_flags() ####

    static error_t
    hurdethif_device_set_flags (struct netif *netif, uint16_t flags)

Sets the device flags.

* Gets the device state.
* Checks if the device is closed. If yes, returns 0.
* Sets the device flags using [device_set_status](https://www.gnu.org/software/hurd/gnumach-doc/Device-Status.html).

#### hurdethif_device_open() ####

    static error_t
    hurdethif_device_open (struct netif *netif)

Opens the device using the [device interface](https://www.gnu.org/software/hurd/gnumach-doc/Device-Interface.html#Device-Interface).

* Gets the [netif state](../ifcommon.c).
* Creates a new port in the etherport_bucket and assigns it to netif->readpt.
* Inserts a port-send right to the port and sets the queue limit.
* [file_name_lookup](https://www.gnu.org/software/hurd/hurd/glibc/hurd-specific_api.html) on the `netif->devname` returns the port to the device file.
* If the lookup returns a port,
  * The device is then opened using [device_open](https://www.gnu.org/software/hurd/gnumach-doc/Device-Open.html) returning a port to the device to `ethif->etherport`.
  * Sets filter for the messages from the device using [device_set_filter](https://www.gnu.org/software/hurd/gnumach-doc/Device-Filter.html) to `bpf_ether_filter`(Explain).
* else
  * [get_privileged_ports](https://www.gnu.org/software/hurd/hurd/glibc/hurd-specific_api.html) fetches the device master port.
  * The device is then opened using [device_open](https://www.gnu.org/software/hurd/gnumach-doc/Device-Open.html) returning a port to the device to `ethif->etherport`.
  * Sets filter for the messages from the device using [device_set_filter](https://www.gnu.org/software/hurd/gnumach-doc/Device-Filter.html) to `ether_filter`(Explain).


#### hurdethif_device_close() ####

    static error_t
    hurdethif_device_close (struct netif *netif)

Closes the device and destroys the link to the device. It deallocates the port, destroys the port right and closes the device (using [device_close](https://www.gnu.org/software/hurd/gnumach-doc/Device-Close.html)).

#### hurdethif_output() ####

    static error_t
    hurdethif_output (struct netif *netif, struct pbuf *p)

This function is called when the outgoing data is ready to be sent to the device.

The [device_write](https://www.gnu.org/software/hurd/gnumach-doc/Device-Write.html#Device-Write) function writes the payload in the pbuff to the device. The write is repeated if it fails. A maximum of three retries are currently allowed. If the return value indicates that the device died, then it is closed and reopened.

#### hurdethif_input() ####

    void
    hurdethif_input (struct netif *netif, struct net_rcv_msg *msg)

This function attaches the new packet to the pbuf chain and calls input function of the netif. This gets called by the demuxer when the input data is ready. TODO: attaching to pbuff chain.

#### hurdethif_demuxer() ####

    int
    hurdethif_demuxer (mach_msg_header_t * inp, mach_msg_header_t * outp)

This is the demuxer function that handles all the incoming RPCs from the device.
First, it extracts the local port to which the mesasge was sent. This port is then matched with available interfaces. If a matching interface is not found, 1 is returned. Otherwise, *hurdethif_input* is called with the corresponding interafce and the message.

#### hurdethif_device_update_mtu() ####

    static error_t
    hurdethif_device_update_mtu (struct netif *netif, uint32_t mtu)

Updates the interface's MTU and the BPF filter.

#### hurdethif_device_terminate() ####

    static error_t
    hurdethif_device_terminate (struct netif *netif)

Releases all resources of this netif.

#### hurdethif_device_init() ####

    error_t
    hurdethif_device_init (struct netif * netif)

Initializes a single device.

* Allocates memory for the interface.
* Sets the parameters of the interface -- state, type and callbacks.
* Hardware intialization is done with [hurdethif_device_open](.)
* [device_get_status](https://www.gnu.org/software/hurd/gnumach-doc/Device-Status.html) fetches the network addresses.
* The network addresses are set for the interface.
* The MTU is set to MSS + IP header size + TCP header size (TCP_MSS + 20 + 20).
* Ethernet multicasting is enabled.
* The interface flags are updated.

#### hurdethif_input_thread()

    static void *
    hurdethif_input_thread (void *arg)

Attaches *hurdethif_demuxer* to handle messages to *ethport-bucket*.

#### hurdethif_module_init()

    error_t
    hurdethif_module_init ()

This function initializes the thread for incoming data. It creates *etherport-bucket* and its port class. It then creates a pthread and links *hurdethif_input_thread* to it. The pthread is then detached.