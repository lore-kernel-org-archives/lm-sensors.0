From: jim.cromie@gmail.com (Jim Cromie)
Date: Tue, 06 Jun 2006 22:40:11 +0000
Subject: [lm-sensors] [RFC - strawman]  Sysfs & GPIO representation
Message-Id: <4486044B.8000500@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Sysfs GPIO representation of Hardware

We need a standard rep for GPIO in sysfs, I'll try to invent one.  IE,
to name and describe the 'files' in the sysfs device-dir.

GPIO pins have lots of hardware / architectural variations, which
makes this harder.  I imitate LM-sensors strategy for dealing with
this, and push as much as possible to user-space.

IOW, drivers should create sysfs 'files' only for attributes that are
pertinent for supported hardware, the absense/presense of files
communicates functionality, as does their readonlyness.  (this last
'behavior' may be different than lm-sensors)

I'll handwave a libsysfs relative/adaptation that uses the sysfs
directory contents accordingly.  In particular; support for things
like 3-bit sub-ports, masks, etc are strictly implmented in
user-space.

Basically, GPIO hardware design breaks on 2 factors; pin features, and
pin-to-port grouping.  These get mapped into filename prefixes &
suffixes.  In a sense, the pin/port addressing is a *infix*, which is
combined with prefix and suffix.

ASIDE
This composition of sysfs file-names as
  <prefix> + <infix> + <suffix>

seems to be a general rule. Is it ?
What part of Doc/* should say so ?
- Doc/hwmon/sysfs-interface ?
- something more general ?



Pin Features

Pin features are represented as _<suffixes> on the pin-name.  The
pin-name-prefix reflects grouping, so is deferred til next section.

1st there are 2 alternative reps:
state-name=value:    : pin_io = "enabled" / "disabled" / "tristate"
state-flag        : pin_enabled = 1 / 0

LM-sensors appears to favor latter, its simpler and less confusing.  I
agree - former doesnt communicate other states possible, only the
current state.

FWIW, scx200_gpio syslog msgs reflect this preference too:
[15510.384000]  pc8736x_gpio.0: io16: 0x0004 TS OD PUE  EDGE LO         
io:0/1
[15510.564000]  pc8736x_gpio.0: io17: 0x0004 TS OD PUE  EDGE LO         
io:1/1
[15510.744000]  pc8736x_gpio.0: io18: 0x0004 TS OD PUE  EDGE LO         
io:1/1
[15510.928000]  pc8736x_gpio.0: io19: 0x0004 TS OD PUE  EDGE LO         
io:1/1


# whether output-drive is on/off
_output_enable        # 1 or 0,
_tristate        # ! _output_enable, logically linked.
_readonly        # alias, overkill ?

# output circuit configuration
_opendrain        # only 1 transistor, can sink current from pin
_totempole        # has 2nd transistor, can drive pin hi.
_pushpull        # alias for _totempole

_pullup            # pin tied to power via resistor.
_pullup_off        # duh
_pullup_no        # how many aliases ?

_debounce        # present if supported, 0 if off, 1 if on.

It kinda works, but the pullup is a bit ugly, and all the aliases
suggest some semantic difficulty/mismatch/incompleteness, but adding
them all definitely creates clutter and has reached diminished
incremental value.


If hardware doesnt support a feature, like _opendrain, it:

 - sets _pushpull to 1, readonly ?
 - sets _opendrain to 0, readonly ?
    OR never creates _opendrain ?

Doing either of these works to communicate the feature-set to
user-space, but not creating _opendrain when pin doesnt do it means
that the file's presense communicates this; IOW, user issues 'ls', not
'ls -l' to find out.

(continuing strawman)

_value        # read the pin
(no-suffix)    # alias for _value

_current    # the value 'driven' by the pin (last written)

And here we can see some potential (user) difficulties;
under some conditions,
- read-value = current-value

but not on these:
- pin is input-only/tristate - (current is irrelevant, except as 'state')
- pin is over-driven by attached circuit
-- pin cannot sink/supply sufficient current

Detecting these situations is both hardware and circuit dependent, and
properly belongs in user-space.  It sounds a lot like what lm-sensors
does already.

For the 2 drivers Ive 'experienced', pin control was via device-file,
with this command-set.  Presumably the correspondence with the sysfs
strawman above is obvious.

case 'O':     output enabled
case 'o':     output disabled
case 'T':     output is push pull
case 't':     output is open drain
case 'P':     pull up enabled
case 'p':     pull up disabled




Port Organization.

My *vast* experience (with 1.5 GPIO architectures) suggests that all
chips organize their GPIOs into one or more ports.  Each port supports
reading and writing all bits simultaneously.

Some hardware also supports reading/writing pin-properties like
output-enable in a single-word (todo-research).  Drivers for these
hardwares could/should create attributes for each pin-property that is
accessible as a bit-vector.

Further, port (and pin) capabilities generally vary by port; hardware
will typically put a full set of features on 1 port, and less on
others, expecting a designer to allocate functions to pins
accordingly.  Forex, on the pc8736x chip, port 0 can issue interrupts,
so those pins should have extra properties.

These capabilities must be cleanly representable in any worthwhile
sysfs/GPIO model (and we continue to test this strawman)..


Port-names and Pin-names

# prefixes (note the trailing _)
port_[0..P]_
bit_[P]_[0..bits-per-word]_

Getting past the port/bit names, these files are populated by the
driver according to the device.  For the 2 drivers Ive touched, heres
the table:

driver:        ports    bits-per-port
scx200_gpio    1    32
pc8736x_gpio    4    8




Strawman tie-together:

bit_0_0_output_enable    # shows current output-drive of port 0 bit 0
bit_0_0_value
bit_0_0            # 2 reads of same bit

# lessee what happens :->
port_0_value_bin    # 1-4 bytes typically returned (depending on device)
port_0_value_hex    # converted to human readable, always printable
port_0_value        #

port_1_output_enable    # read/write vector of enable bits to port
port_1_<suffix_set>    #


The driver should know which properties are readable/writable in a
bit-vector basis, and expose those sysfs-attributes only.  Thus the
presense of the port_N_value* attrs implies that all the bits in that
port are readable at once.

If the driver doesnt expose forex: port_1_output_enable, user-space is
free to loop over each bit, in essence 'emulating' the port-wide
operation.


RESTATING - whats above kinda hangs together.

NEXT - muddles

pin_XY_output_state    # one-of( 'output_enable', 'tristate')

This might be convenient for some situations, but probably is needless
complication / obfuscation.


pin_XY_state_bin        # binary state reader

This is intended an 'escape-valve' for things that are turn out to be
cumbersome with the above.  This is probably tantamount to an IOCTL,
so might be a hugely bad idea.


pin_XY_interrupt_enable        #
pin_XY_interrupt_trigger_edge
pin_XY_interrupt_trigger_level
pin_XY_interrupt_trigger_edge_rising
pin_XY_interrupt_trigger_edge_falling
pin_XY_interrupt_trigger_level_hi
pin_XY_interrupt_trigger_level_lo

Well - heres a big one - Do we expose the ability to enable / disable
/ control hardware interrupt ? or is that insane meddling in such
affairs ?

OTOH, they could readily be RO values, and created/destroyed
accordingly; forex, when a pin is level-triggered (presumably
determined early in the boot process), the _edge_* attributes vanish,
and the _level_{hi,lo} attrs are set 1/0, and RO.

LAST, a request:

If youve got time, pls look at:

  http://www.selenic.com/pipermail/kernel-mentors/2006-May/000474.html

It would need big updates wrt all this sysfs chatter, but having it
reviewed properly would help me immensely, esp as it affects the topic
of this post, and its productive outcome :-D

OK - IM DONE.


Please respond and/or forward as you see fit.

Ive left off LKML, presuming it warrants at least a sanity check 1st,
and perhaps a > /dev/null ;)

tia
-jimc

