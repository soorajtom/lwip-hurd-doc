Fsysopts and command line option parsing.

#### parse_hook_add_interface() ####

    static error_t
    parse_hook_add_interface (struct parse_hook *h)

#### parse_opt() ####

    static error_t
    parse_opt (int opt, char *arg, struct argp_state *state)

This function parses the command line options. A few macros are defined here for handling error.

* RETURN(\_err) - Returns from the routine with \_err.
* PERR(err, fmt, args...) - Parse error.
* FAIL(rerr, status, perr, fmt, args...) - Errors other than parsing errors.
* ADDR(str, type) - Parses str and returns the address

A switch-case statement runs over the allowed options.

* 'i' - checks if the interface provided was already specified. If yes, returns normally. Else, it adds a new interface (if needed) and sets the name of the interface.

#### trivfs_append_args() ####

    error_t
    trivfs_append_args (struct trivfs_control * fsys, char **argz,
    		    size_t * argz_len)

