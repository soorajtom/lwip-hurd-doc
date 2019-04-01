This is the translator entry point.

#### trivfs_goaway() ####

    error_t trivfs_goaway (struct trivfs_control *fsys, int flags)

* If it is a forced goaway, exit(0) is called.
* Else, all further requests are blocked.
* If there are still ports in the `socketport_class` or `addrport_class`, the RPCs are resumed and the goaway is not going to happen.
* Otherwise, exit(0) is called.

#### lwip_demuxer()* ####

    int lwip_demuxer (mach_msg_header_t * inp, mach_msg_header_t * outp)

Messages to the `lwip_bucket` are handled and demultiplexed here.

#### translator_bind() ####

    void translator_bind (int portclass, const char *name)

Installs portclass on node NAME. This is called on command line options `4` and `6` for installing IPv4 and IPv6 translators respectively.

#### main ####

    int main (int argc, char **argv)
This is where the transator begins execution.

* creates the [lwip_bucket](/files/lwip-hurd.h) and the port classes.
* allocates receive right to the fsys_identity port.
* initializes the device modules. see [hurdethif_module_init()](/files/port/netif/hurdethif.c).
* parses the command line arguments. This step also configures the interfaces. see [options.c](/files/options.c).
* arranges for a system shutdown notification. see [startup.c](/files/startup.c).
* attaches the [lwip_demuxer()](/files/main.c) to [lwip_bucket](/files/lwip-hurd.h).

