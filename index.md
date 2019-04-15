[[!sidebar content=""]]

LwIP-hurd is a port of [lwIP](https://www.nongnu.org/lwip/2_1_x/index.html) into [Hurd](https://www.gnu.org/software/hurd/index.html). It was designed to replace the pfinet translator. The development of the lwip-hurd was carried out by Joan Lledó as part of the Google Summer of Code(GSoC) 2017. He has documented the process as a blog [here](http://darnassus.sceen.net/~jlledom/en/).

[[!img img/Outer.png size="450x450" caption="Basic network control flow" align="right"]]

## Building the translator ##


### Installing the lwIP libraries ###

The core libraries of lwIP need to be installed before building the translator. The libraries can be installed by installing it as the Debian package [https://salsa.debian.org/debian/lwip](https://salsa.debian.org/debian/lwip).

### Building lwIP ###

The lwIP translator is built while building hurd from the source if the lwIP libraries had already been installed. To make the lwIP translator alone, follow the [steps to configure](https://www.gnu.org/software/hurd/hurd/building.html) the Hurd installation and use `make lwip`.
The translator can be tested using
`settrans -fgap /servers/socket/2 ~/path/to/build/lwip/lwip -i /dev/eth0 -a a.b.c.d -g e.f.g.h -m i.j.k.l`
where `a.b.c.d` is the IP address for the device, `e.f.g.h` is the default gateway and `i.j.k.l` is the netmask.

## Contents

* [[Startup]]
* [[Files]]
* [[Journey_of_a_packet]]