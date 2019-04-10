
Datastructure definitions and function declarations for [[hurdtunif.c]]


#### struct pbufqueue ####

	struct pbufqueue
	{
	  struct pbuf *head;
	  struct pbuf **tail;
	  uint8_t len;
	};

This is the queue of the data in the tunnel.

#### struct hurdtunif ####

	struct hurdtunif
	{
	  struct ifcommon comm;
	  struct trivfs_control *cntl;	/* Identify the tunnel device in use */
	  file_t underlying;		/* Underlying node where the tunnel is bound */
	  struct iouser *user;		/* Restrict the access to one user at a time */
	  struct pbufqueue queue;	/* Output queue */
	  /* Concurrent access to the queue */
	  pthread_mutex_t lock;
	  pthread_cond_t read;
	  pthread_cond_t select;
	  uint8_t read_blocked;
	};

Extension of the common device interface to store tunnel metadata.