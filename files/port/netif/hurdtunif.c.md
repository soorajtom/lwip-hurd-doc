Tunnel devices module

#### enqueue() ####

	static void
	enqueue (struct pbufqueue *q, struct pbuf *p)

Adds an new pbuf to the end of the queue.

#### dequeue() ####

	static struct pbuf *
	dequeue (struct pbufqueue *q)

Gets from the head of the queue.

#### hurdtunif_device_update_mtu() ####

	static error_t
	hurdtunif_device_update_mtu (struct netif *netif, uint32_t mtu)

Updates the interafce's MTU.

#### hurdtunif_device_set_flags() ####

	static error_t
	hurdtunif_device_set_flags (struct netif *netif, uint16_t flags)

Sets the device flags.

#### hurdtunif_device_terminate() ####

	static error_t
	hurdtunif_device_terminate (struct netif *netif)

Releases all resources of this interface.

#### hurdtunif_output() ####

	static err_t
	hurdtunif_output (struct netif *netif, struct pbuf *p,
			  const ip4_addr_t * ipaddr)

Enqueues the data.

#### hurdtunif_device_init() ####

	err_t
	hurdtunif_device_init (struct netif *netif)

Sets up the tunnel device.

#### hurdtunif_module_init() ####

	error_t
	hurdtunif_module_init ()



#### check_open_hook() ####

	static error_t
	check_open_hook (struct trivfs_control *cntl, struct iouser *user, int flags)



#### pi_destroy_hook() ####

	static void
	pi_destroy_hook (struct trivfs_protid *cred)



#### trivfs_S_io_read() ####

	error_t
	trivfs_S_io_read (struct trivfs_protid *cred,
			  mach_port_t reply, mach_msg_type_name_t reply_type,
			  char **data, mach_msg_type_number_t * data_len,
			  loff_t offs, size_t amount)



#### trivfs_S_io_write() ####

	error_t
	trivfs_S_io_write (struct trivfs_protid * cred,
			   mach_port_t reply,
			   mach_msg_type_name_t replytype,
			   char *data,
			   mach_msg_type_number_t datalen,
			   off_t offset, mach_msg_type_number_t * amount)



#### trivfs_S_io_readable() ####

	kern_return_t
	trivfs_S_io_readable (struct trivfs_protid * cred,
			      mach_port_t reply, mach_msg_type_name_t replytype,
			      mach_msg_type_number_t * amount)



#### io_select_common() ####

	static error_t
	io_select_common (struct trivfs_protid *cred,
			  mach_port_t reply,
			  mach_msg_type_name_t reply_type,
			  struct timespec *tsp, int *type)



#### trivfs_S_io_select() ####

	error_t
	trivfs_S_io_select (struct trivfs_protid * cred,
			    mach_port_t reply,
			    mach_msg_type_name_t reply_type, int *type)



#### trivfs_S_io_select_timeout() ####

	error_t
	trivfs_S_io_select_timeout (struct trivfs_protid * cred,
				    mach_port_t reply,
				    mach_msg_type_name_t reply_type,
				    struct timespec ts, int *type)



#### trivfs_S_io_seek() ####

	error_t
	trivfs_S_io_seek (struct trivfs_protid * cred,
			  mach_port_t reply, mach_msg_type_name_t reply_type,
			  off_t offs, int whence, off_t * new_offs)



#### trivfs_S_file_set_size() ####

	error_t
	trivfs_S_file_set_size (struct trivfs_protid * cred,
				mach_port_t reply, mach_msg_type_name_t reply_type,
				off_t size)



#### trivfs_S_io_set_all_openmodes() ####

	error_t
	trivfs_S_io_set_all_openmodes (struct trivfs_protid * cred,
				       mach_port_t reply,
				       mach_msg_type_name_t reply_type, int mode)



#### trivfs_S_io_set_some_openmodes() ####

	error_t
	trivfs_S_io_set_some_openmodes (struct trivfs_protid * cred,
					mach_port_t reply,
					mach_msg_type_name_t reply_type, int bits)



#### trivfs_S_io_clear_some_openmodes() ####

	error_t
	trivfs_S_io_clear_some_openmodes (struct trivfs_protid * cred,
					  mach_port_t reply,
					  mach_msg_type_name_t reply_type, int bits)



#### trivfs_S_io_get_owner() ####

	error_t
	trivfs_S_io_get_owner (struct trivfs_protid * cred,
			       mach_port_t reply,
			       mach_msg_type_name_t reply_type, pid_t * owner)



#### trivfs_S_io_mod_owner() ####

	error_t
	trivfs_S_io_mod_owner (struct trivfs_protid * cred,
			       mach_port_t reply, mach_msg_type_name_t reply_type,
			       pid_t owner)



#### trivfs_S_io_map() ####

	error_t
	trivfs_S_io_map (struct trivfs_protid * cred,
			 mach_port_t reply,
			 mach_msg_type_name_t replyPoly,
			 memory_object_t * rdobj,
			 mach_msg_type_name_t * rdtype,
			 memory_object_t * wrobj, mach_msg_type_name_t * wrtype)


