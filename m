From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 16 Jul 2008 07:10:24 +0000
Subject: Re: [lm-sensors] superio lock coordinator
Message-Id: <20080716091024.04021309@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <487C5810.3030205@gmail.com>
In-Reply-To: <487C5810.3030205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

On Tue, 15 Jul 2008 17:04:57 -0600, Jim Cromie wrote:
> On 7/15/08, Jean Delvare <khali@linux-fr.org> wrote:
> > Please read my reply to David's concern, and why having a per-chip exit
> >  sequence doesn't make that much sense. I would use the same exit
> >  function as isadump and sensors-detect have been using for months, as
> >  this appears to work fine.
> 
> OK, quoting
> 
> As I recall, the rationale for the code above is that you do not
> necessarily recognize a known Super-I/O chip after the init sequence.
> As different chips have different exit sequences, there are definitely
> cases where you just don't know what to do. So we need a universal exit
> sequence, which is the code above. And once you have that and it
> appears to work with all known chips, there's simply no reason to not
> use it for all chips even when we know their exit sequence.
> 
> I dont understand what you mean by :
> "not necessarily recognize a known Super-I/O chip after the init sequence"
> 
> recognize =? known device id ?

Yes.

> init sequence =? superio-enter sequence ?

Yes.

To take a concrete example: say that you issue the Winbond Super-I/O
enter sequence and it works. You know that you probably have some
Winbond chip (but you're not even sure). You check the device ID and it
doesn't match anything you know. Now you want to issue the exit
sequence. You can use the one of the W83627HF, or you can use the one
of the W83627EHF. Which one will you use, given that you have no idea
what chip you actually have?

This is the reason why sensors-detect etc. don't use per-chip exit
sequenced.

> (...)
> What I meant here was that we should discourage use of superio-exit(),
> leaving the port enabled for normal operations.  ISTM that this is the same
> effect as the "universal exit sequence" - ie a harmless sequence of bytes
> that does NOT disable the port, leaving it working for anyone, and
> not interfering with drivers which resend the superio_enter() sequence.
>
> IOW - if we send enter_sequence when registering port, and never send
> exit-sequence, we should get the current working behavior.

That's not OK. For one thing, some chips stop working while in
configuration mode. For another (probably related), some chips leave
configuration mode on their own after a number of configuration
register reads and/or period of time (that's why isadump reissues the
enter sequence every 16 reads or so). So you don't want to leave the
chip in configuration mode, and in some cases you couldn't even if you
wanted to.

In general, I strongly suggest that you look at what sensors-detect and
isadump are doing. These tools have been in use for years, we have
improved them over time, and I can't remember any problem report
related to Super-I/O.

> > Which expectations?
> 
> Mostly that isadump continues to work - if drivers are aggressive with
> enter/exit sequences, we're more likely to leave the port in a
> disabled state, and isadump
> and friends would need correct enter-sequences to re-enable.

isadump always had to issue the correct enter-sequence, we have an
option for that (-k). There's no reason for this to change (except for
the fact that it is considered bad practice to access I/O ports from
user-space that have been requested by a kernel driver.)

> > (...)
> > What we really need for sensors-detect is simply the value of registers
> >  0x20 and 0x21, and values of registers 0x30, 0x60 and 0x61 for a
> >  selected logical device. In what form we export these, needs to be
> >  discussed.
> 
> Ok - those are familiar addys - I'll come up with candidate names for
> these attrs.
> 
> I note you left out DevID, is that an accident ?
> ISTM that it would be needed for a user-space sensor-module loader,
> which would know device ids supported by drivers.

DevID is 0x20, I didn't leave it out. Or do you mean something else?

> Also, this implies that Locks-Coordinator should actively scan for
> common superio-ports (based upon superio_locks.scan_on_load=1), an

If we want hwmon drivers to load automatically, it will have to anyway.
I would even make it the default.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
