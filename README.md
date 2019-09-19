verontas
=====

A GRiSP application

Build
-----

    $ rebar3 compile

Deploy
------

    $ rebar3 grisp deploy


Custom OTP build
----------------

* The `$LIBS` variable of the used erl_xcomp-${OTP_VSN}.conf
must contain the `-lyggdrasil` flag after the library has been built.
* The build sub-section of the grisp section in `rebar.config` must
point to the RTEMS installation folder.

    $ rebar3 grisp build