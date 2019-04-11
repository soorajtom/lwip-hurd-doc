## How it all begins.. ##

*For each supported PF_\* protocol family (domain), there is a file /servers/socket/N where N is the numeric value for the PF_\* symbol.*  
-- [Hurd networking](https://www.gnu.org/software/hurd/hurd/networking.html)

For using the lwIP stack for networking, the translator is attached to the corresponding `/servers/socket/N` node.

For example, for an IPv4 translator,

	settrans -fgap /servers/socket/2 ~/path/to/build/lwip/lwip -i /dev/eth0 -a a.b.c.d -g e.f.g.h -m i.j.k.l

attaches the translator where `a.b.c.d` is the IP address for the device, `e.f.g.h` is the default gateway and `i.j.k.l` is the netmask.

#### Translator startup ####

The execution starts in [[main.c]] where the [[ethernet and tunneling modules are initialized|Files/port/netif/hurdethif.c#hurdethif_module_init.28.29]]. Then it moves on to option parsing which is where the interafces get initialized (See below).

#### Argument parsing ####

The details of the interface are specified in the argumets while the translator is attached. The argument parsing step also [[initializes the interface|Files/lwip-util.c/#init_ifs.28.29]] and the tcp_thread.

The [[init_ifs()|Files/lwip-util.c/#init_ifs.28.29]] function initializes the interface. It calls [[create_netif_state()|Files/lwip-util.c/#create_netif_state.28.29]] which sets the init callback, [[hurdethif_device_init|Files/port/netif/hurdethif.c/#hurdethif_device_init.28.29]] if it is an ethernet interface.

#### Device initialization ####

See [[hurdethif.c#hurdethif_device_init|Files/port/netif/hurdethif.c/#hurdethif_device_init.28.29]] for the detailed description of the function. It calls the [[hurdethif_device_open|Files/port/netif/hurdethif.c/#hurdethif_device_open.28.29]] function which sets a filter to forward filtered messages to the netif's port.

When a message at the device arrives in the ethernet port bucket, it gets demuxed to the [[input|Files/port/netif/hurdethif.c/#hurdethif_input.28.29]] function for pushing it onto the stack. 

A detailed picture of the journey of a packet can be seen at [[Journey_of_a_packet]].