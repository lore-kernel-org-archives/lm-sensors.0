From: johnpol@2ka.mipt.ru (Evgeniy Polyakov)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dallas 1-wire protocol implementation.
Message-Id: <1081260036.11597.88.camel@uganda>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
In-Reply-To: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 2004-04-06 at 04:49, Mark Studebaker wrote:

> >>On a dedicated bus the slaves won't get 'lost'.
> > 
> > 
> > Easily. Any search command may fail due to electro-magnetic noise.
> > It is very common to get wrong crc with long wires.
> > 
> > 
> 
> Only if the wires are longer than what Dallas specifies, or
> even if they are shorter?


"Linear Topology: The 1-Wire bus is a single pair, starting at the
master and extending to the farthest slave device. Other slave devices
are attached to the pair along its length without significant (>3m)
branches or "stubs"."

Dallas doesn't _specifies_ maximum length in any topology.
But AFIR errors appear with 3-5 meters of even crossed cable.

For the case of iButtons and "RELIABLE iButton COMMUNICATIONS"(and even
in "ultra-reliable" case) they say that 1-wire is only "reasonably
reliable". After this they discribe situation of totally bogus input
from 1-wire network.
So, we can easily get junk when reading from bus.

> >>The statistic file may be useful for debugging but shouldn't be
> >>built in normally.
> >>
> >>So I agree with Greg, I don't see the point of netlink.
> > 
> > 
> > So one needs
> > for(;;) 
> > { 
> > 	fopen();
> > 	fread();
> > 	num = parse_ascii();
> > 	if (num != old_num)
> > 	{
> > 		do_some_cruft();
> > 	}
> > 	fclose();
> > 	sleep(1);
> > }
> > 
> 
> We don't keep statistics on other busses. It sounds like 
> a debugging thing only to me.

At least we should have main statistic file to have general master's
info: number of masters, number of registered families and so on...
Network has /proc/net/dev, USB has /proc/bus/usb/devices, PCI -
/proc/bus/pci/devices.
Netlink will be disabled by default, but it is needed for network with
for example 20 different slaves. It is bad idea to parse 20 files to
find alarm condition for example.


> > And what about alarms or other asynchronous events? In this case one
> > needs to parse all slave's files to detect such condition.
> > For this you need to parse directories...
> > Wrong idea.
> > 
> 
> If slaves send something only on request then there aren't any alarms or
> asynchronous events, are there?

Master device can check alarm conditions.
After issuing ALARM SEARCH command _all_ slave devices which have alarm
condition will answer and we must follow long search algorithm to find
them. But only after master's command completed.

> > 
> >>Also not clear to me that you need all the threads.
> >>Can slaves send messages spontaneously? I didn't think so.
> > 
> > 
> > Slave can't, they send something only on request, but one can remove/add
> > slave while others are reading/writing or while search is in progress.
> > After adding sysfs processing to this bucket we get pretty nice
> > racy ball. It is absolutely like i2c layer, but with any(variable)
> > amount of i2c controllers.
> > 
> > We can disable netlink facility by default, but i do think such
> > mechanism must exist.
> > 
> I'm still not convinced. Just because a read or write may fail doesn't
> mean you need a thread. 

After any failure we may delete slave/master or create new one.
Actually we _MUST_ delete/create new entries.
I know that computer is a state machine and threads are for people who
can't program state machines. (c) Alan Cox
But here is another situation.


> The important thing is to handle read and write failures in your
> "chip" driver. You don't. Your w1_read_8() and w1_write_8() can't return
> a failure code.

They may not return such error code. 1-wire protocol doesn't specify any
acknowledge like i2c does.
Read and write always success but whole result may be not reliable.
And we may bound sleeping operations on this (now only for reliable)
result.
Actually not reliable result(or some non reliable series) should be
considered as significant event.

SCSI is better example: each request is processed in some "master"
thread.
USB storage has it's own thread.
In i2c we make sleeping operations _only_ in process context while
adding/removing new adapter/algo..., but in 1-wire network we may
create/remove objects asynchronously.

> And these functions are way to big to be inline in a .h file.

Ok, i will replace them.


> >>Could you send us the 18s20 driver so we can see how it all fits
> >>together?
> > 
> > 
> > Since i only have 1-wire termometers i implemented only part of their
> > commands.
> > Actually iButton is also 1-wire device and has different command set,
> > but code now is not clean enough for iButton since i put termometer
> > commands in one file with bus implementation.
> > So 18s20 is part of w1.c.
> > 
> > 
> I like what you did with family registration and separating the "chip" driver
> from the "bus" driver.
> 
> In the "chip" driver (w1-term), can you follow our standards in Documentation/i2c/sysfs-interface
> for the sysfs files? Then our userspace tools will work with only a simple change to
> look in the w1 tree.

Ok.

> Also, in English, it's "thermometer" so the best abbreviation is "therm";
> "term" will confuse people.

:) I just thought what is wrong with that name.
Sure, I rename it.

-- 
	Evgeniy Polaykov ( s0mbre )

Crash is better than data corruption. -- Art Grabowski
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 189 bytes
Desc: This is a digitally signed message part
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040406/4adc757c/attachment.bin
