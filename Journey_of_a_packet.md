## Journey of a packet ##

LwIP is a free TCP/IP stack aimed to embedded systems and carefully designed to be highly portable. 

At the basic level, applications use glibc for standard networking functions (eg. socket create operation). In Hurd, glibc uses IPC to send messages to the lwIP translator that implements the function. On the other end, lwIP translator uses IPC to communicate with the device driver corresponding to the network device to send or receive data.

Please note that this is a very crude depiction of the journey of a packet. Most of the advanced machinery (segmentation, checksum, congestion control, etc) are not described here. This page is to get an overview of the flow of data. Please feel free to add to this page.

### When data is sent through a socket ###

Assume that we have established tcp connection with a remote device on network and are about to send data. We have to send the data using the corresponding socket.

When an application wishes to send data to a socket, the standard function [`send`](https://linux.die.net/man/2/send) is called with the socket and the data as parameters.
Gilbc then forwards the request using RPC to the lwIP translator. The [[`lwip_S_socket_send`|Files/socket-ops.c/#lwip_S_socket_send.28.29]] handles the send operation. It calls the lwip library function, `lwip_sendmsg` to send the data.

The `lwip_sendmsg` function calls the [`netconn_write_partly`](https://www.nongnu.org/lwip/2_1_x/group__netconn__tcp.html#gacf9ce6f71652739d6be2ca83f7c423bf) to send the data over a TCP connection. Here the data is placed in an [`api_msg`](https://www.nongnu.org/lwip/2_1_x/structapi__msg.html) structure for further processing. The message is then posted to the global mailbox `mbox`.

The tcpip_thread will call the 'api function' of the message, [`lwip_netconn_do_write`](https://www.nongnu.org/lwip/2_1_x/api__msg_8h.html#aca4545a471ead1bc673ea93fe85f7e5c) which was set by [`netconn_write_partly`](https://www.nongnu.org/lwip/2_1_x/group__netconn__tcp.html#gacf9ce6f71652739d6be2ca83f7c423bf). The [`tcp_write`](https://www.nongnu.org/lwip/2_1_x/group__tcp__raw.html#ga6b2aa0efbf10e254930332b7c89cd8c5) function then takes the pcb and prepares it for sending. First the pcb is copied directly into an oversized pbuff, then it is segmented to appropriate segments.

[`tcp_write`](https://www.nongnu.org/lwip/2_1_x/group__tcp__raw.html#ga6b2aa0efbf10e254930332b7c89cd8c5) does not send the data immediately. [`tcp_output`](https://www.nongnu.org/lwip/2_1_x/group__tcp__raw.html#ga0cbcc6d628f644a530daf629fa3e5f7f) is called after `tcp_write` to send the packets that are ready to be sent. Next, `tcp_output_segment` is called to send the TCP segment over IP.

Since it is an IPv4 packet, [`ip4_output_if`](https://www.nongnu.org/lwip/2_1_x/ip4_8c.html#ab220bc4ce4f48bdbba447358b3594917) is called to send it to a network interface. Next, the `output` function for the interface is called. It is set to [`etharp_output`](https://www.nongnu.org/lwip/2_1_x/lwip_2etharp_8h.html#a19258c75a3778b6ed0c82f63a419502d). It resolves and fills-in Ethernet address header for outgoing IP packet. This function then calls [`ethernet_output`](https://www.nongnu.org/lwip/2_1_x/group__ethernet.html#gac9cad5802bfa3d885f13d2ba0f40b778) to send the ethernet packet to the network using `linkoutput` function of the netif.

The `linkoutput` is set to [[`hurdethif_output`|Files/port/netif/hurdethif.c/#hurdethif_output.28.29]] function during the device init. Now we are back in the lwip translator code. The `hurdethif_output` then writes the packet to the device using [`device write`](https://www.gnu.org/software/hurd/gnumach-doc/Device-Write.html#Device-Write) and the device will send it over the network.

### When a packet is coming through a netif ###

We are considering a TCP data packet that is coming in to the computer via an ethernet interface we had configured when the translator was attached. Each interface has its input function that handles an incoming packet. It is set as the `input` parameter in the interface structure when it is initialized. For ethernet interfaces, it is [`tcpip_input`](https://www.nongnu.org/lwip/2_1_x/group__lwip__os.html#gae510f195171bed8499ae94e264a92717).

During the [[hardware intialization|Files/port/netif/hurdethif.c/#hurdethif_device_init.28.29]], a filter is set on the device to forward the specified kind of messages to the ethernet port bucket.  
The driver sends the packet to that port. The port is set to send all incoming messages to [[hurdethif_demuxer|Files/port/netif/hurdethif.c/#hurdethif_demuxer.28.29]]. The demuxer function calls the [[hurdethif_input|Files/port/netif/hurdethif.c/#hurdethif_input.28.29]]. It allocates memory for the packet, copies the data and calls the `netif->input` function assigned (currently [`tcpip_input`](https://www.nongnu.org/lwip/2_1_x/group__lwip__os.html#gae510f195171bed8499ae94e264a92717)).  

The packet is now in the core lwip libraries. B)

The flags of the netif is checked to see if the packet has an ethernet header. If it does, [tcpip_inpkt](https://www.nongnu.org/lwip/2_1_x/tcpip_8h.html#a93043b3c66dbe4a15a60299c6199d102) is called with [`ethernet_input`](https://www.nongnu.org/lwip/2_1_x/group__lwip__nosys.html#ga6a10c58b82c56d02c48b3cfa2c2494ff) as the input function. In `ethernet_input`, the packet type is determined to call the corresponding function (IP, ARP, PPPoE discovery, etc.).

[`ip4_input()`](https://www.nongnu.org/lwip/2_1_x/ip4_8c.html#aff1f784c9f05f3d79cc1a921d840501b) is called for IPv4 packets. After some basic checks of the IP header such as packet size being at least larger than the header size, etc, it is sent to the next layer for processing corresponding to the protocol.

For TCP packets, [`tcp_input()`](https://www.nongnu.org/lwip/2_1_x/tcp__in_8c.html#ae70c3c99d9dd6b07f7e11f7ba5eedcb5) is called. It verifies the TCP header, demultiplexes the segment between the PCBs and passes it on to `tcp_process()`, which implements the TCP finite state machine. Since the packet is data for an application, `tcp_process()` sets the `recv_data` which points to the pbuff that goes to the application. The `tcp_input()` then call the `TCP_EVENT_RECV` which notifies the application that the data has been recieved. The `recv` callback for the pcb is then called which must be set to `recv_tcp` which posts the pbuff to the recieve mailbox, [`recvmbox`](https://www.nongnu.org/lwip/2_1_x/structnetconn.html#a9f2bf6a3865b6a22a8a71ec2f3e770da).

The next time the application calls `recv` function on the socket, the data is read from the mailbox and it is given to the application.