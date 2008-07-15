From: "Jim Cromie" <jim.cromie@gmail.com>
Date: Tue, 15 Jul 2008 23:04:57 +0000
Subject: Re: [lm-sensors] superio lock coordinator
Message-Id: <cfe85dfa0807151604x4bcc0ab7p2134727b1090441@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <487C5810.3030205@gmail.com>
In-Reply-To: <487C5810.3030205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On 7/15/08, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Jim,
>
>
>  On Tue, 15 Jul 2008 01:56:00 -0600, Jim Cromie wrote:

>  > -- following another thread - we'd
>  > --- reserve region when reservation taken, after devid is validated,
>  >     might help keep other semi-rogue drivers out.
>
>
> Actually, _before_ devid is validated. You shouldn't make _any_ I/O
>  access without first requesting the region. You can always release the
>  region afterwards if you didn't find anything interesting.

ACK.

>
>
>  >
>  > = sort out enter / exit
>  >
>  > As David noted in this thread, the ehf driver has an odd exit sequence,
>  >
>  > The combined combined superio_exit() function I have coded currently is
>  > really quite hideous,
>  > and has me thinking towards  David's function-pointer idea.
>  >
>  > - the other alternative is that David's driver should include its own
>  > custom exit-fn, which
>  > he would use instead of the regular superio_exit().  It could use the
>  > superio_enter routine as-is iirc.
>
>
> Please read my reply to David's concern, and why having a per-chip exit
>  sequence doesn't make that much sense. I would use the same exit
>  function as isadump and sensors-detect have been using for months, as
>  this appears to work fine.

OK, quoting

As I recall, the rationale for the code above is that you do not
necessarily recognize a known Super-I/O chip after the init sequence.
As different chips have different exit sequences, there are definitely
cases where you just don't know what to do. So we need a universal exit
sequence, which is the code above. And once you have that and it
appears to work with all known chips, there's simply no reason to not
use it for all chips even when we know their exit sequence.

I dont understand what you mean by :
"not necessarily recognize a known Super-I/O chip after the init sequence"

recognize =? known device id ?
init sequence =? superio-enter sequence ?

>
>
>  > my stall points - (fishing for answers;)
>  >
>  > - enter / exit should be tracked by superio-locks, in flags bit.
>  > (recent idea, seems sound)
>  > - enter / exit should be vaguely discouraged in kernel-doc - due to
>  > expectations of isadump etc.
>

What I meant here was that we should discourage use of superio-exit(),
leaving the port enabled for normal operations.  ISTM that this is the same
effect as the "universal exit sequence" - ie a harmless sequence of bytes
that does NOT disable the port, leaving it working for anyone, and
not interfering with drivers which resend the superio_enter() sequence.

IOW - if we send enter_sequence when registering port, and never send
exit-sequence,
we should get the current working behavior.



>
> Which expectations?

Mostly that isadump continues to work - if drivers are aggressive with
enter/exit sequences, we're more likely to leave the port in a
disabled state, and isadump
and friends would need correct enter-sequences to re-enable.

I'll take a peek at coreboot RSN.  thanks for that link.

User-space should stay away from I/O ports the
>  kernel has requested. There's little point in trying to sort out
>  concurrent accesses which simply shouldn't happen in the first place.
>
>






>  > I put it here for proximity to the center-of-mass of the drivers I found.
>
>
> That's not necessarily a bad initial location. We can have superio live
>  in drivers/hwmon at first, and once all hwmon drivers use it, move it
>  to a neutral ground and convert the other drivers in the kernel tree
>  (mainly watchdog drivers I think.)
>

Good - Ill stick with it for now, and move if/when appropriate.


>  > Jean, you raised the idea of a sysfs interface.
>  > Does the October patchset look to fit with what youre thinking ?
>
>
> I don't think your patch offered a sysfs interface? I'm not really
>  thinking of anything in particular anyway.

Thats correct - it did not.    Im just trying to use the idea as
a probe to see what the patchset might have missed.
Following comments are intended for consideration in an additional patch..


 We just want a way for
>  sensors-detect to identify supported Super-I/O chips without actually
>  accessing the I/O ports if a kernel driver already requested them.
>
>
>  > - the most simple I can think of :
>  > --expose the kzalloced array of superio-fields as readonly attributes.
>  > --values go non-zero when superio-port is registered by some user-driver
>  > --it would be nice to see client-drivers list on each slot, but that
>  > involves more code and mem
>
>
> What we really need for sensors-detect is simply the value of registers
>  0x20 and 0x21, and values of registers 0x30, 0x60 and 0x61 for a
>  selected logical device. In what form we export these, needs to be
>  discussed.
>

Ok - those are familiar addys - I'll come up with candidate names for
these attrs.

I note you left out DevID, is that an accident ?
ISTM that it would be needed for a user-space sensor-module loader,
which would know device ids supported by drivers.

Also, this implies that Locks-Coordinator should actively scan for
common superio-ports (based upon superio_locks.scan_on_load=1), an



>  > does anyone think s/superio/sio/g is appropriate ?
>
>
> No. This was discussed before and I have always objected to the name
>  "sio". It's too short and could mean about anything (starting with
>  "synchronous I/O", as opposed to "asynchronous I/O" which is very often
>  spelled AIO.)
>

ACK.  I'll not ask again (I dont recall that I did, but thats irrelevant)


>
> Jean Delvare
>

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
