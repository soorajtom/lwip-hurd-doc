## Journey of a packet ##

LwIP is a free TCP/IP stack aimed to embedded systems and carefully designed to be highly portable. 

At the basic level, applications use glibc for standard networking functions (eg. socket create operation). In Hurd, glibc uses IPC to send messages to the lwIP translator that implements the function. On the other end, lwIP translator uses IPC to communicate with the device driver corresponding to the network device to send or receive data.

### When data is sent through a socket ###



### Incoming packet ###

We are considering a TCP data packet that is coming in to the computer via an ethernet interface we had configured when the translator was attached. Each interface has its input function that handles an incoming packet. It is set as the `input` parameter in the interface structure when it is initialized. For ethernet interfaces, it is [`tcpip_input`](https://www.nongnu.org/lwip/2_1_x/group__lwip__os.html#gae510f195171bed8499ae94e264a92717).

During the [[hardware intialization|Files/port/netif/hurdethif.c/#hurdethif_device_init.28.29]], a filter is set on the device to forward the specified kind of messages to the ethernet port bucket.  
The driver sends the packet to that port. The port is set to send all incoming messages to [[hurdethif_demuxer|Files/port/netif/hurdethif.c/#hurdethif_demuxer.28.29]]. The demuxer function calls the [[hurdethif_input|Files/port/netif/hurdethif.c/#hurdethif_input.28.29]]. It allocates memory for the packet, copies the data and calls the `netif->input` function assigned (currently [`tcpip_input`](https://www.nongnu.org/lwip/2_1_x/group__lwip__os.html#gae510f195171bed8499ae94e264a92717)).  

The packet is now in the core lwip libraries. B)

The flags of the netif is checked to see if the packet has an ethernet header. If it does, [tcpip_inpkt](https://www.nongnu.org/lwip/2_1_x/tcpip_8h.html#a93043b3c66dbe4a15a60299c6199d102) is called with [`ethernet_input`](https://www.nongnu.org/lwip/2_1_x/group__lwip__nosys.html#ga6a10c58b82c56d02c48b3cfa2c2494ff) as the input function. In `ethernet_input`, the packet type is determined to call the corresponding function (IP, ARP, PPPoE discovery, etc.).

[`ip4_input()`](https://www.nongnu.org/lwip/2_1_x/ip4_8c.html#aff1f784c9f05f3d79cc1a921d840501b) is called for IPv4 packets. After some basic checks of the IP header such as packet size being at least larger than the header size, etc, it is sent to the next layer for processing corresponding to the protocol.

For TCP packets, [`tcp_input()`](https://www.nongnu.org/lwip/2_1_x/tcp__in_8c.html#ae70c3c99d9dd6b07f7e11f7ba5eedcb5) is called. It verifies the TCP header, demultiplexes the segment between the PCBs and passes it on to `tcp_process()`, which implements the TCP finite state machine. Since the packet is data for an application, `tcp_process()` sets the `recv_data` which points to the pbuff that goes to the application. The `tcp_input()` then call the `TCP_EVENT_RECV` which notifies the application that the data has been recieved.