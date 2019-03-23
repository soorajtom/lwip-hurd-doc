This is the translator entry point.

==trivfs_goaway()==
 error_t trivfs_goaway (struct trivfs_control *fsys, int flags)
==lwip_demuxer()==
 int lwip_demuxer (mach_msg_header_t * inp, mach_msg_header_t * outp)
==translator_bind()==
 void translator_bind (int portclass, const char *name)
==main==
 int main (int argc, char **argv)
This is where the transator begins execution.
* creates the [[Lwip-hurd.h#struct_port_bucket_.2Alwip_bucket|lwip bucket]] and the port classes.
* allocates receive right to the fsys_identity port.
* initializes the device modules. see [[Hurdethif.c#hurdethif_module_init.28.29|hurdethif_module_init()]].
* parses the command line arguments. This step also configures the interfaces. see [[Options.c|options.c]].
* arranges for a system shutdown notification. see [[Startup.c|arrange_shutdown_notification()]].
* attaches the [[Main.c#lwip_demuxer.28.29|lwip_demuxer()]] to [[Lwip-hurd.h#struct_port_bucket_.2Alwip_bucket|lwip bucket]].
