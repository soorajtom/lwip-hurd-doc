This is the translator entry point.

#### trivfs_goaway() ####

    error_t trivfs_goaway (struct trivfs_control *fsys, int flags)

#### lwip_demuxer() ####

    int lwip_demuxer (mach_msg_header_t * inp, mach_msg_header_t * outp)

#### translator_bind() ####

    void translator_bind (int portclass, const char *name)

#### main ####

    int main (int argc, char **argv)
This is where the transator begins execution.

* creates the [lwip_bucket](/files/lwip-hurd.h) and the port classes.
* allocates receive right to the fsys_identity port.
* initializes the device modules. see [hurdethif_module_init()](/files/port/netif/hurdethif.c).
* parses the command line arguments. This step also configures the interfaces. see [options.c](/files/options.c).
* arranges for a system shutdown notification. see [startup.c](/files/startup.c).
* attaches the [lwip_demuxer()](/files/main.c) to [lwip_bucket](/files/lwip-hurd.h).

