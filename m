From: "David Hubbard" <david.c.hubbard@gmail.com>
Date: Tue, 15 Jul 2008 15:23:23 +0000
Subject: Re: [lm-sensors] superio lock coordinator
Message-Id: <4dfa50520807150823p68b7d6c0jdfe384509be36d5a@mail.gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <487C5810.3030205@gmail.com>
In-Reply-To: <487C5810.3030205@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Jim,

Glad to see you again on lm-sensors!

On Tue, Jul 15, 2008 at 4:40 AM, Jean Delvare <khali@linux-fr.org> wrote:
> Hi Jim,
>
> On Tue, 15 Jul 2008 01:56:00 -0600, Jim Cromie wrote:
>> these are on my current todo / partly done
>>
>> - struct superio_common - stuff thats copied from struct superio-search
>> to struct superio when reservation is taken
>>
>> - add a u8 flags to struct superio
>> -- carries bit for tracking enter/exit state -
>>     should support warnings on situations like enter-on-entered,
>> exit-on-exited
>>  - could carry a toggle bit for a union superio_exit { fnptr;
>> exit_seq[X] } or somesuch.
>>
>> -- following another thread - we'd
>> --- reserve region when reservation taken, after devid is validated,
>>     might help keep other semi-rogue drivers out.
>
> Actually, _before_ devid is validated. You shouldn't make _any_ I/O
> access without first requesting the region. You can always release the
> region afterwards if you didn't find anything interesting.
>
>>
>> = sort out enter / exit
>>
>> As David noted in this thread, the ehf driver has an odd exit sequence,
>>
>> The combined combined superio_exit() function I have coded currently is
>> really quite hideous,
>> and has me thinking towards  David's function-pointer idea.
>>
>> - the other alternative is that David's driver should include its own
>> custom exit-fn, which
>> he would use instead of the regular superio_exit().  It could use the
>> superio_enter routine as-is iirc.
>
> Please read my reply to David's concern, and why having a per-chip exit
> sequence doesn't make that much sense. I would use the same exit
> function as isadump and sensors-detect have been using for months, as
> this appears to work fine.

Here it is:
On Mon, Jul 14, 2008 at 2:12 AM, Jean Delvare <khali@linux-fr.org> wrote:
> sensors-detect doesn't pay much attention to custom exist sequences,
> and neither does isadump:
>
> void superio_reset(int addrreg, int datareg)
> {
>        /* Some chips (SMSC, Winbond) want this */
>        outb(0xaa, addrreg);
>
>        /* Return to "Wait For Key" state (PNP-ISA spec) */
>        outb(0x02, addrreg);
>        outb(0x02, datareg);
> }

That will certainly work for w83627ehf, so superio-locks would not
even need to store the enter and exit sequences. Every hwmon device
should work like this.

>> my stall points - (fishing for answers;)
>>
>> - enter / exit should be tracked by superio-locks, in flags bit.
>> (recent idea, seems sound)
>> - enter / exit should be vaguely discouraged in kernel-doc - due to
>> expectations of isadump etc.
>
> Which expectations? User-space should stay away from I/O ports the
> kernel has requested. There's little point in trying to sort out
> concurrent accesses which simply shouldn't happen in the first place.
>
>>
>>
>> I guess I gotta stop overcomplicating things, and get busy on the patch-set.
>>
>>
>> > More interesting questions IMHO are:
>> > 1) is hwmon the correct subsystem to put the .c file in (somewhat
>> > superfical
>> >   really, but we need a place to put the lock coordinator (and enable
>> > / disable
>> >   its building).
>>
>> I put it here for proximity to the center-of-mass of the drivers I found.
>
> That's not necessarily a bad initial location. We can have superio live
> in drivers/hwmon at first, and once all hwmon drivers use it, move it
> to a neutral ground and convert the other drivers in the kernel tree
> (mainly watchdog drivers I think.)

Sounds like a good plan. drivers/hwmon/superio-locks.

>> > 2) non hwmon drivers need to be edited for superio register use too,
>> > and then
>> >   modified to use the lock coordinator if they touch the superio
>> > registers.
>> >   This will also be a good exercise to see if our API is generic enough.
>> >
>> I guess there are drivers I missed ?
>
> Best way I think is to grep for each super-I/O chip name.
>
>> thanks again Hans for pulling me back into this, I'll commit to staying
>> with it now.
>> Should I infer from your comments that the code at the link incorporates
>> your feedback ?
>> They seem to have aquired some momentum recently 8-)
>>
>> Jean, you raised the idea of a sysfs interface.
>> Does the October patchset look to fit with what youre thinking ?
>
> I don't think your patch offered a sysfs interface? I'm not really
> thinking of anything in particular anyway. We just want a way for
> sensors-detect to identify supported Super-I/O chips without actually
> accessing the I/O ports if a kernel driver already requested them.
>
>> - the most simple I can think of :
>> --expose the kzalloced array of superio-fields as readonly attributes.
>> --values go non-zero when superio-port is registered by some user-driver
>> --it would be nice to see client-drivers list on each slot, but that
>> involves more code and mem
>
> What we really need for sensors-detect is simply the value of registers
> 0x20 and 0x21, and values of registers 0x30, 0x60 and 0x61 for a
> selected logical device. In what form we export these, needs to be
> discussed.

Should superio-locks enumerate the available logical device ID's,
perhaps as a sysfs interface?

>> David,
>> do you have a preference wrt fn-ptr ? and if so, a single fn with 1 arg
>> :  0,1,2 for enter/exit/query ?
>> do you have any use for a flag bit ?  is there generality in it ?

I think we could just use the same enter and exit sequences for
everything, and not make it customizable. Does that sound OK?

>> does anyone think s/superio/sio/g is appropriate ?
>
> No. This was discussed before and I have always objected to the name
> "sio". It's too short and could mean about anything (starting with
> "synchronous I/O", as opposed to "asynchronous I/O" which is very often
> spelled AIO.)

David

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
