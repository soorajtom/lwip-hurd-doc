[[!img img/lwiphurd.png caption="Structure of lwIP" align="right"]]

## List of files

lwip  
├── [[iioctl-ops.c]]  
├── [[io-ops.c]]  
├── [[lwip-hurd.h]]  
├── [[lwip-util.c]]  
├── [[lwip-util.h]]  
├── [[main.c]]  
├── Makefile  
├── [[mig-decls.h]]  
├── [[mig-mutate.h]]  
├── [[options.c]]  
├── [[options.h]]  
├── [[pfinet-ops.c]]  
├── port/  
│&nbsp;&nbsp;&nbsp;├── include/  
│&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;└── netif/  
│&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── [[port/include/netif/hurdethif.h]]  
│&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── [[port/include/netif/hurdloopif.h]]  
│&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── [[port/include/netif/hurdtunif.h]]  
│&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── [[port/include/netif/ifcommon.h]]  
│&nbsp;&nbsp;&nbsp;└── netif/  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── [[port/netif/hurdethif.c]]  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── [[port/netif/hurdloopif.c]]  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├── [[port/netif/hurdtunif.c]]  
│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└── [[port/netif/ifcommon.c]]  
├── [[port-objs.c]]  
├── [[socket-ops.c]]  
├── [[startup.c]]  
├── [[startup.h]]  
└── [[startup-ops.c]]  
