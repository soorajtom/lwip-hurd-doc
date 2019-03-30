Fsysopts and command line option parsing.

#### parse_hook_add_interface() ####

    static error_t
    parse_hook_add_interface (struct parse_hook *h)

Adds an empty interface to the *parse_hook* `h` and sets it as the current interface.

#### parse_opt() ####

    static error_t
    parse_opt (int opt, char *arg, struct argp_state *state)

This function parses the command line options. A few macros are defined here for handling error.

* RETURN(\_err) - Returns from the routine with \_err.
* PERR(err, fmt, args...) - Parse error.
* FAIL(rerr, status, perr, fmt, args...) - Errors other than parsing errors.
* ADDR(str, type) - Parses str and returns the address

A switch-case statement runs over the allowed options.

* 'i' - sets the interface: checks if the interface provided was already specified. If yes, returns normally. Else, it adds a new interface (if needed) and sets the name of the interface.
* 'a' - sets the IP address: makes sure the address provided not an invalid or a multicast address and sets it. If no address is provided, the default address is set (0.0.0.0).
* 'm' - sets the netmask
* 'p' - sets the peer address
* 'g' - sets the gateway for the current address
* '4' - make ipv4 translator
* '6' - make ipv6 translator
* 'A' - sets ipv6 address: The address provided is validated(how?) and set.
* ARGP_KEY_INIT - This value is passed by the parsing lib before any parsing is done. At this point, the initialisations are done. A new *parse_hook* is allocated and attached to the *state* variable. A new empty interface is also added to the hook.
* ARGP_KEY_ERROR - This value is recieved at a parsing error. The interfaces allocated and the parse hook are freed.

#### trivfs_append_args() ####

    error_t
    trivfs_append_args (struct trivfs_control * fsys, char **argz,
    		    size_t * argz_len)

This function is used to list the arguments accepted by the translator. see [argx_add()](http://man7.org/linux/man-pages/man3/argz_add.3.html).
