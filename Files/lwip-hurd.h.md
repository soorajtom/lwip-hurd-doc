This file contains the global declarations of port classes, structures and functions for the translator.

#### Address family port class ####

    enum
    {
      PORTCLASS_INET,
      PORTCLASS_INET6,
    }

Enum used while binding translator to specify the address family (IPv4 or IPv6).

#### socket ####

    struct socket
    {
      int sockno;
      mach_port_t identity;
      refcount_t refcnt;
    }

The socket structure.

#### sock_user ####

    struct sock_user
    {
      struct port_info pi;
      int isroot;
      struct socket *sock;
    }

The user using the socket. Multiple sock_user's can point to the same socket.

#### sock_addr ####

    struct sock_addr
    {
      struct port_info pi;
      union
      {
        struct sockaddr_storage storage;
        struct sockaddr sa;
      } address;
    }

Socket address ports.

#### uid_t lwip_owner ####

Owner of the underlying node.

#### uid_t lwip_group ####

User group of the underlying node.
