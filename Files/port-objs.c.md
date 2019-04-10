Libports objects management.

[[!toc]]

#### make_sockaddr_port() ####

    error_t
    make_sockaddr_port (int sock,
                int peer,
                mach_port_t * addr, mach_msg_type_name_t * addrtype)

Creates a sockaddr port. Fills in \*ADDR and \*ADDRTYPE accordingly. The address should come from SOCK; PEER is 0 if we want this socket's name and 1 if we want the peer's name.

#### sock_alloc() ####

    struct socket *
    sock_alloc (void)

Allocates memory for a new socket.

#### sock_release() ####

    void
    sock_release (struct socket *sock)

Closes a socket and frees the memory. This is called from the port cleanup function below, and on a newly allocated socket when something went wrong in its creation.

#### make_sock_user() ####

    struct sock_user *
    make_sock_user (struct socket *sock, int isroot, int noinstall, int consume)

Create a sock_user structure, initialized from SOCK and ISROOT. If NOINSTALL is set, don't put it in the portset.

#### clean_socketport() ####

    void
    clean_socketport (void *arg)

Release the referenced socket. [sock_release](.) is called here.

#### clean_addrport() ####

    void
    clean_addrport (void *arg)

Nothing is done here.