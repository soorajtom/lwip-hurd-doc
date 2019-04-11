## Journey of a packet ##

LwIP is a free TCP/IP stack aimed to embedded systems and carefully designed to be highly portable. 

At the basic level, applications use glibc for standard networking functions (eg. socket create operation). In Hurd, glibc uses IPC to send messages to the lwIP translator that implements the function. The lwIP translator uses IPC to communicate with the device driver corresponding to the network device to send or receive data.

### Incoming packet ###

We are considering a packet that is coming in to the computer via an ethernet interface we had configured when the translator was attached. Each interface has its input function that is called on incoming data...<Wait.. read startup>