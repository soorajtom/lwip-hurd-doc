
[[!toc]]

#### begin_using_socket_port() ####

	static inline struct sock_user * __attribute__ ((unused))
	begin_using_socket_port (mach_port_t port)

Calls [`ports_lookup_port()`](https://www.gnu.org/software/hurd/doc/hurd_4.html#SEC22).

#### begin_using_socket_payload() ####

	static inline struct sock_user * __attribute__ ((unused))
	begin_using_socket_payload (unsigned long payload)

Calls [`ports_lookup_payload()`](https://www.gnu.org/software/hurd/doc/hurd_4.html)

#### end_using_socket_port() ####

	static inline void __attribute__ ((unused))
	end_using_socket_port (struct sock_user *user)

Calls ports_port_deref(). See [the mail thread](https://marc.info/?l=hurd-bug&m=121966329010773&w=2) for details.

#### begin_using_sockaddr_port() ####

	static inline struct sock_addr * __attribute__ ((unused))
	begin_using_sockaddr_port (mach_port_t port)

Calls [`ports_lookup_port()`](https://www.gnu.org/software/hurd/doc/hurd_4.html#SEC22).

#### begin_using_sockaddr_payload() ####

	static inline struct sock_addr * __attribute__ ((unused))
	begin_using_sockaddr_payload (unsigned long payload)

Calls [`ports_lookup_payload()`](https://www.gnu.org/software/hurd/doc/hurd_4.html)

#### end_using_sockaddr_port() ####

	static inline void __attribute__ ((unused))
	end_using_sockaddr_port (struct sock_addr *addr)

Calls ports_port_deref(). See [the mail thread](https://marc.info/?l=hurd-bug&m=121966329010773&w=2) for details.
