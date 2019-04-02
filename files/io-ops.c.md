General input / output operations

#### lwip_S_io_write() ####

	error_t
	lwip_S_io_write (struct sock_user *user,
			 char *data,
			 size_t datalen,
			 off_t offset, mach_msg_type_number_t * amount)

Sends data to a socket.

#### lwip_S_io_read() ####

	error_t
	lwip_S_io_read (struct sock_user * user,
			char **data,
			size_t * datalen, off_t offset, mach_msg_type_number_t amount)

Recieves AMOUNT length of data from the socket.

#### lwip_S_io_seek() ####

	error_t
	lwip_S_io_seek (struct sock_user * user,
			off_t offset, int whence, off_t * newp)

Returns ESPIPE (Illegal seek) if user is not null and EOPNOTSUPP (Operation not supported) otherwise.?

#### lwip_S_io_readable() ####

	error_t
	lwip_S_io_readable (struct sock_user * user, mach_msg_type_number_t * amount)

Gets the amount of data that can be read from the socket without blocking.

#### lwip_S_io_set_all_openmodes() ####

	error_t
	lwip_S_io_set_all_openmodes (struct sock_user * user, int bits)

Sets or clears nonblocking I/O for a socket.

#### lwip_S_io_get_openmodes() ####

	error_t
	lwip_S_io_get_openmodes (struct sock_user * user, int *bits)

Gets the openmodes of the socket.

#### lwip_S_io_set_some_openmodes() ####

	error_t
	lwip_S_io_set_some_openmodes (struct sock_user * user, int bits)

Sets nonblocking I/O for a socket.

#### lwip_S_io_clear_some_openmodes() ####

	error_t
	lwip_S_io_clear_some_openmodes (struct sock_user * user, int bits)

Clears nonblocking I/O for a socket.

#### lwip_io_select_common()* ####

	static error_t
	lwip_io_select_common (struct sock_user *user,
			       mach_port_t reply,
			       mach_msg_type_name_t reply_type,
			       struct timespec *tv, int *select_type)

Arrange things to call lwip_poll().

#### lwip_S_io_select() ####

	error_t
	lwip_S_io_select (struct sock_user * user,
			  mach_port_t reply,
			  mach_msg_type_name_t reply_type, int *select_type)

Calls lwip_io_select_common().

#### lwip_S_io_select_timeout() ####

	error_t
	lwip_S_io_select_timeout (struct sock_user * user,
				  mach_port_t reply,
				  mach_msg_type_name_t reply_type,
				  struct timespec ts, int *select_type)

Calls lwip_io_select_common() after updating timeout.

#### lwip_S_io_stat() ####

	error_t
	lwip_S_io_stat (struct sock_user * user, struct stat * st)

Returns the current status of the socket.

#### lwip_S_io_reauthenticate()* ####

	error_t
	lwip_S_io_reauthenticate (struct sock_user * user, mach_port_t rend)

Gets a reauthenticated port to the socket.

#### lwip_S_io_restrict_auth() ####

	error_t
	lwip_S_io_restrict_auth (struct sock_user * user,
				 mach_port_t * newobject,
				 mach_msg_type_name_t * newobject_type,
				 uid_t * uids, size_t uidslen,
				 uid_t * gids, size_t gidslen)

Return another port which has been restricted to do only those things which both the current user and the newly specified user can do.

#### lwip_S_io_duplicate() ####

	error_t
	lwip_S_io_duplicate (struct sock_user * user,
			     mach_port_t * newobject,
			     mach_msg_type_name_t * newobject_type)

Returns a new port with the same semantics as the existing port.

#### lwip_S_io_identity() ####

	error_t
	lwip_S_io_identity (struct sock_user * user,
			    mach_port_t * id,
			    mach_msg_type_name_t * idtype,
			    mach_port_t * fsys,
			    mach_msg_type_name_t * fsystype, ino_t * fileno)

Return the identity port for the socket.

****
The rest of the functions are not supported yet.

	





	



	


