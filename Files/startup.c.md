startup.c

#### sigterm_handler() ####

    static void
    sigterm_handler (int signo)

The SIGTERM handler for the translator. It destroys the port rights, sets the SIGTERM handler to the default and raises a SIGTERM.

#### arrange_shutdown_notification() ####

    void
	arrange_shutdown_notification ()

Arranges to get notified when the system goes down. It sets the SIGTERM handler to [sigterm_handler](.).