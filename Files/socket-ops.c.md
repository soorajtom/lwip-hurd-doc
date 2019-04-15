This file defines the [socket operations](https://www.nongnu.org/lwip/2_1_x/group__socket.html) for the lwIP stack. These functions are accessed via RPCs.

[[!toc]]

#### lwip_S_socket_create() ####

    error_t
    lwip_S_socket_create (struct trivfs_protid *master,
                  int sock_type,
                  int protocol,
                  mach_port_t * port, mach_msg_type_name_t * porttype)
creates an [lwip socket](https://www.nongnu.org/lwip/2_1_x/group__socket.html#ga862d8f4070c66dddb979540ce9ba6a83).

#### lwip_S_socket_listen() ####

    error_t
    lwip_S_socket_listen (struct sock_user * user, int queue_limit)

Listens on a socket and prepares a socket of appropriate type for future accept operations. Uses [lwip_listen](https://www.nongnu.org/lwip/2_1_x/sockets_8c.html#abee6ee286147cf334a1ba19f19b2e08b).

#### lwip_S_socket_accept() ####

    error_t
    lwip_S_socket_accept (struct sock_user * user,
                  mach_port_t * new_port,
                  mach_msg_type_name_t * new_port_type,
                  mach_port_t * addr_port,
                  mach_msg_type_name_t * addr_port_type)

Return a new connection from a socket previously listened.

#### lwip_S_socket_connect() ####

    error_t
    lwip_S_socket_connect (struct sock_user * user, struct sock_addr * addr)

Connects to a socket address.

#### lwip_S_socket_bind() ####

    error_t
    lwip_S_socket_bind (struct sock_user * user, struct sock_addr * addr)

Binds a socket to an address.

#### lwip_S_socket_name() ####

    error_t
    lwip_S_socket_name (struct sock_user * user,
                mach_port_t * addr_port,
                mach_msg_type_name_t * addr_port_name)

Finds out the name of a socket.

#### lwip_S_socket_peername() ####

    error_t
    lwip_S_socket_peername (struct sock_user * user,
                mach_port_t * addr_port,
                mach_msg_type_name_t * addr_port_name)

Finds out the name of the socket's peer.

#### lwip_S_socket_connect2() ####

    error_t
    lwip_S_socket_connect2 (struct sock_user * user, struct sock_user * sock2)

Connect two sockets. This has not been implemented yet.

#### lwip_S_socket_create_address() ####

    error_t
    lwip_S_socket_create_address (mach_port_t server,
                      int sockaddr_type,
                      char *data,
                      mach_msg_type_number_t data_len,
                      mach_port_t * addr_port,
                      mach_msg_type_name_t * addr_port_type)

Receives address data, creates a libports object and returns its port.

#### lwip_S_socket_fabricate_address() ####

    error_t
    lwip_S_socket_fabricate_address (mach_port_t server,
                     int sockaddr_type,
                     mach_port_t * addr_port,
                     mach_msg_type_name_t * addr_port_type)

Create an address without any sockaddr.

#### lwip_S_socket_whatis_address() ####

    error_t
    lwip_S_socket_whatis_address (struct sock_addr * addr,
                      int *type,
                      char **data, mach_msg_type_number_t * datalen)

Finds the sockaddr name of an address. Receives a libports object and returns its data.

#### lwip_S_socket_shutdown() ####

    error_t
    lwip_S_socket_shutdown (struct sock_user * user, int direction)

Shutdown a socket for reading or writing. Uses [lwip_shutdown](https://www.nongnu.org/lwip/2_1_x/sockets_8c.html#ade85c68b6673296c8fb67127b93fa4c1).

#### lwip_S_socket_getopt() ####

    error_t
    lwip_S_socket_getopt (struct sock_user * user,
                  int level, int option, char **data, size_t * datalen)

Gets a socket option.

#### lwip_S_socket_setopt() ####

    error_t
    lwip_S_socket_setopt (struct sock_user * user,
                  int level, int option, char *data, size_t datalen)

Sets a socket option.

#### lwip_S_socket_send() ####

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

Sends data over a socket.

#### lwip_S_socket_recv() ####

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

Recieves data from a socket.