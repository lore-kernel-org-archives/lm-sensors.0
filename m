From: Jim Cromie <jim.cromie@gmail.com>
Date: Wed, 11 Jul 2007 18:34:58 +0000
Subject: Re: [lm-sensors] [ patch 0/4 RFC for 2.6.23-rc0 ] superio-locks
Message-Id: <469522D2.8040408@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <4690A311.3090407@hhs.nl>
In-Reply-To: <4690A311.3090407@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hans de Goede wrote:

Hi Hans,

thanks for stepping up.


> Personally I would like to see the following changes to the API:
>
> 1) Make the cmdreg_addrs and device_ids members of the superio_search 
> struct fixed size arrays instead of pointers, using [2] for 
> cmdreg_addrs and [8] for device_ids, stopping at a 0 addr/id or end of 
> array.
>

Yes - completely sensible - Doing it.


> Also the superio_search structs in the using drivers should be 
> declared on the stack as they are not needed anymore after the 
> superio_find call.
>
This too - Doing so.

> 2) make superio_find return the device_id which was found through a by 
> reference param, this way drivers who support multiple id's do not 
> need to read the device_id registers again, but can use the returned 
> value.
>

No - devid is available via gate->devid     (modulo spelling)
will provide inline wrapper

> 3) move superio_select from the drivers to the superio code.
>
disagreed at 1st, but added ld_addr field to superio_search,
and copied it into gate in superio_find.

>
> > CAVEATS
> > - see 4
> Explain?
>
Basic hedge since only 1 client driver tested with it.
All others compile-tested only, and just barely.

Now have 2nd chip, which has real enter/exit, so next version
will be known to work with both. 

Other drivers still rather sloppy ATM ..


> > - Ive not thought much about the 16-bit device-id check
>     ( I need hardware to sharpen this focus )
> I can check that on / with the f71882fg
>
I'll leave that patch to you - as an API clarity test.
If the API is confusing to you (non-newbie), then its flawed.

And after I get rev 3 out ( Im calling last one rev2 - postfacto),
I'll review your driver.  Can you send me the datasheet ?

> > - superio_get() feels clumsy.
> It looks fine to me
>
> > - superio_{enter,exit} are no-ops on my natsemi chip, so again the code
> > is {}
> >
> > the prob is (of course) that every chip does it differently,
> > and superio_locks shouldnt care.  Probably best to drop them
> > from superio-locks API, and expect drivers to do them themselves.
>
> I think its fine to leave any additional handshaking to the drivers, 
> besides that, as you say with this locking that won't be necessary 
> anymore.
>
my reasoning as commented in superio_locks.h is questionable.
enter/exit is orthogonal to mutex, it gives no protection to drivers
that properly use enter/exit.

drivers could reasonably just enter, never exit (since theres no protection)
mutexs must be used to give transaction guarantees.

Maybe more to say later..

> > - no device knowledge (digression - for later)
> >
> > its tempting to (create another module) to have a Logical-device table,
> > with strings to describe the LDs, etc.  I dont want to dwell on it now,
> > except to avoid foreclosing design options by bad choices now (in
> > superio_locks).
> >
> > struct sio_logical_device pc87366_units[] = {
> >        { 8,    "Floppy Disk Controller (FDC)" },
> >        { 8,    "Parallel Port (PP)" },         /* also 6 more at 
> 0x400 */
> >        { 8,    "Serial Port 2 with IR (SP2)" },
> >       ...
> >
> > I suspect that a pointer field in struct superio could
> > carry whatever info a notional pc8736x_sio.ko would need,
> > but might pose some reclamation issues.
> >
> > such a module should support interrogating the LD's config-regs,
> > extracting ISA addresses, etc, and could for example, add a bit
> > more detail for display in /proc/ioports, which currently shows:
>
> Why all this trouble ? Remember most superio devices are already in 
> /proc/ioports with proper descriptions through there resp. drivers, 
> for example floppy, serial, parallel_pc, kbd, etc.
>

it would be nice to see the LD-name appended to these lines

6620-662f : pc87360
6640-664f : pc87360


> I can see added value in a get superio_get_base_address(gate, 
> logical_device, base_address_no) function, but I think more then that 
> is more trouble then its worth. 

Probably true.  ATM I just want to avoid painting myself into a corner.

maybe superio_get_isa_baseaddr is worth adding to superio_locks,
subject to what (new) fields such support requires..

<aside> s/then/than/  
since English is your 2nd or 3rd language, it might not just be a typo.

> Its important here to realize that most superio logical devices are 
> being driven by legacy drivers and that those drivers do not care (and 
> should not need to care) wether the legacy device is in an lpc 
> connected superio, or truely on the isa bus.
>

> Regards,
>
> Hans
>
>
>
>
thanks again.
-jimc

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
