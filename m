From: Jim Cromie <jim.cromie@gmail.com>
Date: Tue, 15 Jul 2008 07:56:00 +0000
Subject: Re: [lm-sensors] superio lock coordinator
Message-Id: <487C5810.3030205@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

hi Hans,

thanks for the personal invite to this thread. 
I messed up a laptop update last nov, and lost my mail folders
(several gig had piled up so the purge was needed anyway)

hi everyone else too,
apologies for being out of it for so long, and for things left half done.

> David Hubbard wrote:
>> Hi Hans,
>>
>> I can pick it up again and push it forward. IIRC we wanted to know
>> what was the best way to encode the enter and exit sequences for a
>> SuperIO because the w83627ehf is different than pretty much any other.
>> That was the tricky part.
>>
>
> If you look at the latest version posted by Jim:
> http://lists.lm-sensors.org/pipermail/lm-sensors/2007-October/021562.html
>
> You will see that it already has configurable enter / exit sequences. 
> AFAIK the winbond chips are not unique in having differen enter / exit 
> sequences as other superio's have, so having to specify the enter / 
> exit sequence in the driver using the super io coordinator seems correct.
>

I have recently been revisiting the patches, but havent been entirely 
happy with them,
and didnt really like them enough to propose again.

This thread certainly ups it from a background muse.
Happily, I got my soekris back, and have a box that can actually
use 2 superio-client-drivers (ghod this needs a shorter name)


these are on my current todo / partly done

- struct superio_common - stuff thats copied from struct superio-search 
to struct superio when reservation is taken

- add a u8 flags to struct superio
-- carries bit for tracking enter/exit state -
    should support warnings on situations like enter-on-entered, 
exit-on-exited
 - could carry a toggle bit for a union superio_exit { fnptr; 
exit_seq[X] } or somesuch.

-- following another thread - we'd
--- reserve region when reservation taken, after devid is validated,
    might help keep other semi-rogue drivers out.

= sort out enter / exit

As David noted in this thread, the ehf driver has an odd exit sequence,

The combined combined superio_exit() function I have coded currently is 
really quite hideous,
and has me thinking towards  David's function-pointer idea.

- the other alternative is that David's driver should include its own 
custom exit-fn, which
he would use instead of the regular superio_exit().  It could use the 
superio_enter routine as-is iirc.

my stall points - (fishing for answers;)

- enter / exit should be tracked by superio-locks, in flags bit.   
(recent idea, seems sound)
- enter / exit should be vaguely discouraged in kernel-doc - due to 
expectations of isadump etc.


I guess I gotta stop overcomplicating things, and get busy on the patch-set.


> More interesting questions IMHO are:
> 1) is hwmon the correct subsystem to put the .c file in (somewhat 
> superfical
>   really, but we need a place to put the lock coordinator (and enable 
> / disable
>   its building).

I put it here for proximity to the center-of-mass of the drivers I found.

> 2) non hwmon drivers need to be edited for superio register use too, 
> and then
>   modified to use the lock coordinator if they touch the superio 
> registers.
>   This will also be a good exercise to see if our API is generic enough.
>
I guess there are drivers I missed ?


> Regards,
>
> Hans
>

thanks again Hans for pulling me back into this, I'll commit to staying 
with it now.
Should I infer from your comments that the code at the link incorporates 
your feedback ?
They seem to have aquired some momentum recently 8-)

Jean, you raised the idea of a sysfs interface.
Does the October patchset look to fit with what youre thinking ?
- the most simple I can think of :
--expose the kzalloced array of superio-fields as readonly attributes.
--values go non-zero when superio-port is registered by some user-driver
--it would be nice to see client-drivers list on each slot, but that 
involves more code and mem

David,
do you have a preference wrt fn-ptr ? and if so, a single fn with 1 arg 
:  0,1,2 for enter/exit/query ?
do you have any use for a flag bit ?  is there generality in it ?

does anyone think s/superio/sio/g is appropriate ?
anything else ?


thanks
Jim


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
