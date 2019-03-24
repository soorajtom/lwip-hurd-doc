This file defines the [socket operations](https://www.nongnu.org/lwip/2_1_x/group__socket.html) for the lwIP stack. These functions are accessed via RPCs.

## lwip_S_socket_create() ##

    error_t
    lwip_S_socket_create (struct trivfs_protid *master,
    		      int sock_type,
    		      int protocol,
    		      mach_port_t * port, mach_msg_type_name_t * porttype)
creates an [lwip socket](https://www.nongnu.org/lwip/2_1_x/group__socket.html#ga862d8f4070c66dddb979540ce9ba6a83).

## lwip_S_socket_listen() ##

    error_t
    lwip_S_socket_listen (struct sock_user * user, int queue_limit)
listens to a socket.

## lwip_S_socket_accept() ##

    error_t
    lwip_S_socket_accept (struct sock_user * user,
    		      mach_port_t * new_port,
    		      mach_msg_type_name_t * new_port_type,
    		      mach_port_t * addr_port,
    		      mach_msg_type_name_t * addr_port_type)

## lwip_S_socket_connect() ##

    error_t
    lwip_S_socket_connect (struct sock_user * user, struct sock_addr * addr)
connects to a socket address.

## lwip_S_socket_bind() ##

    error_t
    lwip_S_socket_bind (struct sock_user * user, struct sock_addr * addr)
binds to a socket address.

## lwip_S_socket_name() ##

    error_t
    lwip_S_socket_name (struct sock_user * user,
    		    mach_port_t * addr_port,
    		    mach_msg_type_name_t * addr_port_name)

## lwip_S_socket_peername() ##

    error_t
    lwip_S_socket_peername (struct sock_user * user,
    			mach_port_t * addr_port,
    			mach_msg_type_name_t * addr_port_name)

## lwip_S_socket_connect2() ##

    error_t
    lwip_S_socket_connect2 (struct sock_user * user, struct sock_user * sock2)

## lwip_S_socket_create_address() ##

    error_t
    lwip_S_socket_create_address (mach_port_t server,
    			      int sockaddr_type,
    			      char *data,
    			      mach_msg_type_number_t data_len,
    			      mach_port_t * addr_port,
    			      mach_msg_type_name_t * addr_port_type)

## lwip_S_socket_fabricate_address() ##

    error_t
    lwip_S_socket_fabricate_address (mach_port_t server,
    				 int sockaddr_type,
    				 mach_port_t * addr_port,
    				 mach_msg_type_name_t * addr_port_type)

## lwip_S_socket_whatis_address() ##

    error_t
    lwip_S_socket_whatis_address (struct sock_addr * addr,
    			      int *type,
    			      char **data, mach_msg_type_number_t * datalen)
Receive a libports object and return its data

## lwip_S_socket_shutdown() ##

    error_t
    lwip_S_socket_shutdown (struct sock_user * user, int direction)

## lwip_S_socket_getopt() ##

    error_t
    lwip_S_socket_getopt (struct sock_user * user,
    		      int level, int option, char **data, size_t * datalen)

## lwip_S_socket_setopt() ##

    error_t
    lwip_S_socket_setopt (struct sock_user * user,
    		      int level, int option, char *data, size_t datalen)

## lwip_S_socket_send() ##

    error_t
    lwip_S_socket_send (struct sock_user * user,
    		    struct sock_addr * addr,
    		    int flags,
    		    char *data,
    		    size_t datalen,
    		    mach_port_t * ports,
    		    size_t nports,
    		    char *control,
    		    size_t controllen, mach_msg_type_number_t * amount)

## lwip_S_socket_recv() ##

    error_t
    lwip_S_socket_recv (struct sock_user * user,
    		    mach_port_t * addrport,
    		    mach_msg_type_name_t * addrporttype,
    		    int flags,
    		    char **data,
    		    size_t * datalen,
    		    mach_port_t ** ports,
    		    mach_msg_type_name_t * portstype,
    		    size_t * nports,
    		    char **control,
    		    size_t * controllen,
 		    int *outflags, mach_msg_type_number_t amount)
