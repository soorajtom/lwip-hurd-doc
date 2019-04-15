
Operations offered by the stack.

#### dev_ifconf() ####

	static void
	dev_ifconf (struct ifconf *ifc)

Get all the data requested by SIOCGIFCONF for a particular interface.  
When ifc->ifc_ifreq == NULL, this function is being called for getting the needed buffer length and not the actual data.

#### lwip_S_pfinet_siocgifconf() ####

	error_t
	lwip_S_pfinet_siocgifconf (io_t port,
				   vm_size_t amount,
				   char **ifr, mach_msg_type_number_t * len)

Return the list of devices in the format provided by SIOCGIFCONF in IFR, but don't return more then AMOUNT bytes. If AMOUNT is negative, there is no limit.
