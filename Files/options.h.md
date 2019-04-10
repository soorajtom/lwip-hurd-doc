
Data structures and variables for the option parsing.

#### struct parse_interface ####

	struct parse_interface
	{
	  char dev_name[DEV_NAME_LEN];
	  ip4_addr_t address, netmask, peer, gateway;
	  uint32_t addr6[LWIP_IPV6_NUM_ADDRESSES][4];
	};

Used to describe a particular interface during argument parsing.

* `char dev_name` : The network interface in question.  
* `ip4_addr_t address, netmask, peer, gateway` : New IPv4 address values to be set for the interface.  
* `uint32_t addr6[LWIP_IPV6_NUM_ADDRESSES][4]` : New IPv6 address values to be set for the interface.

#### struct parse_hook ####

	struct parse_hook
	{
	  struct parse_interface *interfaces;
	  size_t num_interfaces;
	  struct parse_interface *curint;
	};

* `struct parse_interface *interfaces` : A list of specified interfaces and their corresponding options.
* `struct parse_interface *curint` : Interface to which options apply.  If the device field isn't filled in, then it should be by the next --interface option.

#### static const struct argp_option options[] ####

	static const struct argp_option options[] = {
	  {"interface", 'i', "DEVICE", 0, "Network interface to use", 1},
	  {0, 0, 0, 0, "These apply to a given interface:", 2},
	  {"address", 'a', "ADDRESS", OPTION_ARG_OPTIONAL, "Set the network address"},
	  {"netmask", 'm', "MASK", OPTION_ARG_OPTIONAL, "Set the netmask"},
	  {"gateway", 'g', "ADDRESS", OPTION_ARG_OPTIONAL, "Set the default gateway"},
	  {"ipv4", '4', "NAME", 0, "Put active IPv4 translator on NAME"},
	  {"ipv6", '6', "NAME", 0, "Put active IPv6 translator on NAME"},
	  {"address6", 'A', "ADDR/LEN", OPTION_ARG_OPTIONAL,
	   "Set the global IPv6 address"},
	  {0}
	};

Lwip translator options.  Used for both startup and runtime.

#### static const char doc[] ####

	static const char doc[] = "Interface-specific options before the first \
	interface specification apply to the first following interface; otherwise \
	they apply to the previously specified interface.";

The documentation printed with the long help message.

