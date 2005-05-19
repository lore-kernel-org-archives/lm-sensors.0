From: Jester01@freemail.hu (Csaba Halasz)
Date: Thu, 19 May 2005 06:24:22 +0000
Subject: Works now (Re: my user-space work ? (3d attempt))
Message-Id: <9B4E9DA25A3DD41189B000508B5C0CEE214295@BOMBA>
List-Id: <lm-sensors.vger.kernel.org>
References: <1065896525.1059.14.camel@dell.roesel.skynet.be>
In-Reply-To: <1065896525.1059.14.camel@dell.roesel.skynet.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 2003-10-22 at 10:43, Danny Backx wrote:
> On Tue, 2003-10-21 at 03:12, Mark Studebaker wrote:
>> so you have 'sensors' working on 2.6?

> Yes

Me too. Got beaten by a couple of days :-)

>> I'm having trouble understanding what you did from looking at the diff.
>> Could you explain if this is a general fix compatible for both 2.4 and
>> 2.6 or is there much more to do...

> I saw several things that needed to be ported, I'll explain
> what I did and did not do.

> 2. /proc vs. sysfs

Yeah, me too.

> 3. I've duplicated some of the macros such as
>   add_sys_chips() (was add_proc_chips). Not sure
>   if this is useful. Also some duplicated structures
>   like sensors_sys_chips_entry (sensors_proc_chips_entry).
>   Again, please review.

I did something different. I just filled up the same
structures (chip and bus) from sysfs. Only trouble is
the algorithm, which I just left as "unknown" until
we have a way to get that info from sysfs as well.
(But nobody ever refers to it in their sensors.conf anyway :))

This way no other changes were necessary, making the
origin of the information completely transparent to
the rest of the library. 

> 4. In lib/access.c all the compares between sensor chip
>   names were case sensitive. That made it fail for me.
>   Changed all the calls of strcmp to strcasecmp for
>   this reason.

Didn't run into this one.

>  5. Didn't know what to do with bus types.
>   Similar for sensors_get_adapter_name() and
>   sensors_get_algorithm_name() where I didn't understand
>   what this should do so I basically disabled this
  
See 3. above.
Note that the adapter name _is_ available from sysfs.

> 6. The file names in /sys/bus/i2c/devices/0-0290 were
>   different than the ones described in lib/chips.c so
>   I changed some of them *for my adapter*. The files
>   I see are called in_max0 etc where the code expected
>   in0_max. I assume this is incompatibility between the
>   code in kernel 2.6 and previous versions.

Exactly what I did :)
If we want to keep compatibility, it might be a good idea
to introduce a new member, eg. sysfs_file_name.
(Or just change the sysfs names)

I came across two other problems though:

1) I don't know how to tell if a I2C device is a sensor.
   Maybe any device not mentioned in the config file
   should be ignored.

2) What about non-i2c devices? (ie. isa only) Where would
   they show up in sysfs?

Also, as far as I can tell, both Danny and I only fixed
the "sensors" prog (and similar 3rd party apps).
Other progs, for example sensors-detect, still don't work.

More precisely, we fixed the library. Therefore 
apps using _only_ the functions of the sensors library 
should work. Apps directly accessing /proc will not.

Patch coming sometime monday.

Greets,
	Csaba
