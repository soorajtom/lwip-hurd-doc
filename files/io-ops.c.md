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

####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	



####  ####

	





	



	


