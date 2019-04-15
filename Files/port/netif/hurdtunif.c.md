Standard functions for the tunnel interface. This file also implements the io interface. The functions with `trivfs_S_`  are implementation of this interface.

[[!toc]]

#### enqueue() ####

	static void
	enqueue (struct pbufqueue *q, struct pbuf *p)

	*q - the queue to which the new pbuf will be attached
	*p - the new pbuf

Adds an new pbuf `*p` to the end of the queue `*q`.

#### dequeue() ####

	static struct pbuf *
	dequeue (struct pbufqueue *q)

Gets a pbuf from the head of the queue. Returns NULL if the queue is empty.

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

* The pbuf is completely freed by calling [`pbuf_free`](https://www.nongnu.org/lwip/2_1_x/group__pbuf.html#gab0dd696fb4b6bc65e548944584f1738b) repeatedly.
* The condition variables are `read` and `select` are destroyed using [`pthread_cond_destroy`](https://linux.die.net/man/3/pthread_cond_destroy).
* The mutex lock object is destroyed using [`pthread_mutex_destroy`](https://linux.die.net/man/3/pthread_mutex_destroy).
* The network interface hook is freed.

#### hurdtunif_output() ####

	static err_t
	hurdtunif_output (struct netif *netif, struct pbuf *p,
			  const ip4_addr_t * ipaddr)

	*netif  - the interface in question
	*p      - the pbuf about to be attached to the interface's queue
	*ipaddr - not used

Enqueues the data.

* A copy of the `pbuf` is made.
* The interface mutex lock is set.
* If the pbuff chain is longer than 128, the oldest pbuff is dequeued and freed.
* The new pbuff is enqueued.
* If the `read_blocked` is set on the interface, it is set to 0 and the pthread conditions `read` and `select` are set to unblock using [`pthread_cond_broadcast`](https://linux.die.net/man/3/pthread_cond_broadcast).
* The interface mutex lock is unset.

#### hurdtunif_device_init() ####

	err_t
	hurdtunif_device_init (struct netif *netif)

Sets up the tunnel device.

* Allocates memory for the interface.
* The state for the interface is copied to the state parameter.
* The device type is set as `ARPHRD_TUNNEL` (more about the flags [here](http://man7.org/linux/man-pages/man7/netdevice.7.html)).
* The MTU for the device is set to `TCP_MSS + 20 + 20` (MTU = MSS + IP header + TCP header).
* The callbacks for the interface is set. (The open and close callbacks are NULL?)
* Binds the translator to the device file.
* A new control port is created using [`trivfs_create_control`](http://www.hep.by/gnu/hurd/hurd_49.html).
* [`file_set_translator`](https://www.gnu.org/software/hurd/hurd/interface/fs/27.html) sets the translator for future lookups to the interface file.
* The output queue, mutex lock object and [`pthread condition variables`](https://linux.die.net/man/3/pthread_cond_init) are initialized.

#### hurdtunif_module_init() ####

	error_t
	hurdtunif_module_init ()

Sets the libports classes.

#### check_open_hook() ####

	static error_t
	check_open_hook (struct trivfs_control *cntl, struct iouser *user, int flags)

	*cntl  - identifies the node being opened. Used for identifying the right tunif
	*user  - user requesting access
	*flags - flags from the open

Assigned to [`*trivfs_check_open_hook`](https://www.gnu.org/software/hurd/doc/hurd_6.html#IDX116). Checks if the interface is available for exclusive usage and opens it. Returns `EBUSY` if a user is already using it.

#### pi_destroy_hook() ####

	static void
	pi_destroy_hook (struct trivfs_protid *cred)

Assigned to [`*trivfs_protid_destroy_hook`](https://www.gnu.org/software/hurd/doc/hurd_6.html#IDX119). Checks if it is the current user that is using the interface. If yes, releases the interface for other users.

#### trivfs_S_io_read() ####

	error_t
	trivfs_S_io_read (struct trivfs_protid *cred,
			  mach_port_t reply, mach_msg_type_name_t reply_type,
			  char **data, mach_msg_type_number_t * data_len,
			  loff_t offs, size_t amount)

Reads data from an IO object.  If offset is -1, read from the object maintained file pointer. If the object is not seekable, offset is ignored. The amount desired to be read is in AMOUNT.

* Gets the interface state.
* Sets the mutex lock.
* If the openmode was set to [`O_NONBLOCK`](https://www.gnu.org/software/libc/manual/html_node/Open_002dtime-Flags.html), [`EWOULDBLOCK`](http://man7.org/linux/man-pages/man3/errno.3.html) is returned.
* Waits for the `read` pthread condition variable. The mutex lock is released and [`EINTR`](http://man7.org/linux/man-pages/man3/errno.3.html) is returned in case of error.
* The pbuff is dequeued and memory for the pbuf is allocated.
* The pbuff is copied to the allocated memory and the pbuff is freed.
* The mutex lock is released.

#### trivfs_S_io_write() ####

	error_t
	trivfs_S_io_write (struct trivfs_protid * cred,
			   mach_port_t reply,
			   mach_msg_type_name_t replytype,
			   char *data,
			   mach_msg_type_number_t datalen,
			   off_t offset, mach_msg_type_number_t * amount)

Writes data to an IO object. If offset is -1, writes at the object maintained file pointer. If the object is not seekable, offset is ignored. The amount successfully written is returned in amount. A given user should not have more than one outstanding io_write on an   object at a time; servers implement congestion control by delaying responses to io_write.  Servers may drop data (returning ENOBUFS) if they receive more than one write when not prepared for it.

* The caller credentials are checked. If not valid, returns with `EOPNOTSUPP`.
* Checks if the openmode is set to `O_WRITE`. If not, returns with `EBADF`.
* Checks if the port class is correct.
* Memory is allocated for the pbuff.
* The data is copied onto the pbuff chain.
* The input function of the interface is called to pass it to the stack.

#### trivfs_S_io_readable() ####

	kern_return_t
	trivfs_S_io_readable (struct trivfs_protid * cred,
			      mach_port_t reply, mach_msg_type_name_t replytype,
			      mach_msg_type_number_t * amount)

Calculates the amount of data that can be read without blocking for a 'long time'. The mutex lock is set and the length of the interface's queue is read. This value is copied to AMOUNT.

#### io_select_common()* ####

	static error_t
	io_select_common (struct trivfs_protid *cred,
			  mach_port_t reply,
			  mach_msg_type_name_t reply_type,
			  struct timespec *tsp, int *type)

SELECT_TYPE is the bitwise OR of SELECT_READ, SELECT_WRITE, and SELECT_URG.
Blocks until one of the indicated types of i/o can be done "quickly", and return the types that are then available. ID_TAG is returned as passed; it is just for the convenience of the user in matching up reply messages with specific requests sent.

#### trivfs_S_io_select() ####

	error_t
	trivfs_S_io_select (struct trivfs_protid * cred,
			    mach_port_t reply,
			    mach_msg_type_name_t reply_type, int *type)

Calls [`io_select_common()`](../../../io-ops.c).

#### trivfs_S_io_select_timeout() ####

	error_t
	trivfs_S_io_select_timeout (struct trivfs_protid * cred,
				    mach_port_t reply,
				    mach_msg_type_name_t reply_type,
				    struct timespec ts, int *type)

Calls [`io_select_common()`](../../../io-ops.c).

#### trivfs_S_io_seek() ####

	error_t
	trivfs_S_io_seek (struct trivfs_protid * cred,
			  mach_port_t reply, mach_msg_type_name_t reply_type,
			  off_t offs, int whence, off_t * new_offs)

Returns `ESPIPE` (Illegal seek). As per the [linux man page](https://linux.die.net/man/7/socket), ```Seeking, or calling pread(2) or pwrite(2) with a nonzero position is not supported on sockets.``` 

#### trivfs_S_file_set_size() ####

	error_t
	trivfs_S_file_set_size (struct trivfs_protid * cred,
				mach_port_t reply, mach_msg_type_name_t reply_type,
				off_t size)

If the value of size is 0, returns 0. Else, returns `EINVAL` (Invalid argument).

#### trivfs_S_io_set_all_openmodes() ####

	error_t
	trivfs_S_io_set_all_openmodes (struct trivfs_protid * cred,
				       mach_port_t reply,
				       mach_msg_type_name_t reply_type, int mode)

Does nothing. Returns 0.

#### trivfs_S_io_set_some_openmodes() ####

	error_t
	trivfs_S_io_set_some_openmodes (struct trivfs_protid * cred,
					mach_port_t reply,
					mach_msg_type_name_t reply_type, int bits)

Does nothing. Returns 0.

#### trivfs_S_io_clear_some_openmodes() ####

	error_t
	trivfs_S_io_clear_some_openmodes (struct trivfs_protid * cred,
					  mach_port_t reply,
					  mach_msg_type_name_t reply_type, int bits)

Does nothing. Returns 0.

#### trivfs_S_io_get_owner() ####

	error_t
	trivfs_S_io_get_owner (struct trivfs_protid * cred,
			       mach_port_t reply,
			       mach_msg_type_name_t reply_type, pid_t * owner)

Sets OWNER to NULL and returns 0.

#### trivfs_S_io_mod_owner() ####

	error_t
	trivfs_S_io_mod_owner (struct trivfs_protid * cred,
			       mach_port_t reply, mach_msg_type_name_t reply_type,
			       pid_t owner)

Returns `EINVAL` (Invalid argument).

#### trivfs_S_io_map() ####

	error_t
	trivfs_S_io_map (struct trivfs_protid * cred,
			 mach_port_t reply,
			 mach_msg_type_name_t replyPoly,
			 memory_object_t * rdobj,
			 mach_msg_type_name_t * rdtype,
			 memory_object_t * wrobj, mach_msg_type_name_t * wrtype)

Returns `EINVAL` (Invalid argument).
