
Common interface definitions for all kinds of devices.

#### struct ifcommon ####

	struct ifcommon
	{
	  uint16_t type;
	  device_t ether_port;
	  struct port_info *readpt;
	  mach_port_t readptname;
	  char *devname;
	  uint16_t flags;
	  /* Callbacks */
	    err_t (*init) (struct netif * netif);
	    error_t (*terminate) (struct netif * netif);
	    error_t (*open) (struct netif * netif);
	    error_t (*close) (struct netif * netif);
	    error_t (*update_mtu) (struct netif * netif, uint32_t mtu);
	    error_t (*change_flags) (struct netif * netif, uint16_t flags);
	};

Helper struct to hold private data used to operate the interface.

#### netif_get_state() ####

	#define netif_get_state(netif)  ((struct ifcommon *)netif->state)

Gets the state from a netif.