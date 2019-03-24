This file contains the global declarations of port classes, structures, etc for the translator.

#### struct port_bucket *lwip_bucket ####

The port bucket for lwip. All messages recieved are processed by the [lwip_demuxer()](/main.c).

#### struct port_class *socketport_class ####


#### struct port_class *addrport_class ####


#### struct port_class *shutdown_notify_class ####


#### struct port_class *lwip_protid_portclasses[2] ####


#### struct port_class *lwip_cntl_portclasses[2] ####


#### int lwip_bootstrap_portclass ####


#### mach_port_t fsys_identity ####


#### struct trivfs_control *lwipcntl ####


#### Address family port class ####

    enum
    {
      PORTCLASS_INET,
      PORTCLASS_INET6,
    }

#### socket ####

    struct socket
    {
      int sockno;
      mach_port_t identity;
      refcount_t refcnt;
    }

#### sock_user ####

    struct sock_user
    {
      struct port_info pi;
      int isroot;
      struct socket *sock;
    }

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

#### uid_t lwip_owner ####


#### uid_t lwip_group ####


