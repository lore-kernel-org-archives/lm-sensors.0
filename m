From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dallas 1-wire protocol implementation.
Message-Id: <4071FEA7.7060000@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
In-Reply-To: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I'm looking at the update you sent today but I'll respond to this mail because it
has your responses in it. Thanks for replying to my questions.

Evgeniy Polyakov wrote:
> On Sat, 03 Apr 2004 11:13:05 -0500
> Mark Studebaker <mds4@verizon.net> wrote:
> 
> 
>>>Because sometimes it is not very comfortable to monitor whole sysfs
>>>tree, but very convenient to just get event, wake up and begin
>>>processing.
>>>Since any slave may appear and disappear(slave removing actually not
>>>turned on but only created in a code, since after connecting to DDC
>>>pin 1-wire protocol is filled with 90% of DDC video card <-> monitor
>>>data noise and master very frequently losts it's slaves)
>>>asynchronously, so we always need to monitor at least this events. I
>>>think netlink is the best for this kind of events. The whole hotplug
>>>is overhead here i think.
>>>Actually one can poll() master's statistic file and determine what
>>>slaves are connected/disconnected by parsing ascii output, but is
>>>think it is not very convenient.
>>>
>>>
>>
>>But that's a side-effect of using/sharing the DDC pins for 1-wire,
>>which I don't think is a realistic way to do it.
>>It may work but I don't think it's good. As you said you were
>>desperate to find some spare GPIO but you couldn't. 
>>
>>On a dedicated bus the slaves won't get 'lost'.
> 
> 
> Easily. Any search command may fail due to electro-magnetic noise.
> It is very common to get wrong crc with long wires.
> 
> 

Only if the wires are longer than what Dallas specifies, or
even if they are shorter?

>>The statistic file may be useful for debugging but shouldn't be
>>built in normally.
>>
>>So I agree with Greg, I don't see the point of netlink.
> 
> 
> So one needs
> for(;;) 
> { 
> 	fopen();
> 	fread();
> 	num = parse_ascii();
> 	if (num != old_num)
> 	{
> 		do_some_cruft();
> 	}
> 	fclose();
> 	sleep(1);
> }
> 

We don't keep statistics on other busses. It sounds like 
a debugging thing only to me.

> And what about alarms or other asynchronous events? In this case one
> needs to parse all slave's files to detect such condition.
> For this you need to parse directories...
> Wrong idea.
> 

If slaves send something only on request then there aren't any alarms or
asynchronous events, are there?

> 
>>Also not clear to me that you need all the threads.
>>Can slaves send messages spontaneously? I didn't think so.
> 
> 
> Slave can't, they send something only on request, but one can remove/add
> slave while others are reading/writing or while search is in progress.
> After adding sysfs processing to this bucket we get pretty nice
> racy ball. It is absolutely like i2c layer, but with any(variable)
> amount of i2c controllers.
> 
> We can disable netlink facility by default, but i do think such
> mechanism must exist.
> 
I'm still not convinced. Just because a read or write may fail doesn't
mean you need a thread. 

The important thing is to handle read and write failures in your
"chip" driver. You don't. Your w1_read_8() and w1_write_8() can't return
a failure code.

And these functions are way to big to be inline in a .h file.

> 
>>>>>static int w1_master_match(struct device *dev, struct device_driver
>>>
>>>*drv)>>{
>>>
>>>>>	log("%s: dev=%p, rv=%p\n", __func__, dev, drv);
>>>>>	return 1;
>>>>>}
>>>>
>>>>If you are going to create your own type of bus and driver and
>>>
>>>devices,>please do it correctly.  But is it really necessary?  Why
>>>not just use>the i2c framework for this?
>>>
>>>
>>>This was my initial idea too.
>>>But as a first approximation i didn't find easy way to create
>>>different masters("master" not in i2c notation, but "devices" which
>>>have the same transport driver, but for example have different base
>>>address). And we can't control masters/slaves with current i2c
>>>stack(for example delete one slave through ioctl), with current w1
>>>stack we can't do it also but it is very easy to add(it is in TODO
>>>at least). And actually when i became implementing 1-wire protocol
>>>driver i didn't know about "byte" mode(or what is appropriate name
>>>for mode when"master" only receives data from i2c stack and sends it
>>>into the wire itself through software-defined timeouts(and actually
>>>in case of 1-wire protocol through it's own protocol) and so on, not
>>>through hardware i2c controller).
>>>
>>
>>This is the important choice to make:
>>	1) define a new I2C_ONEWIRE functionality and then register as
>>	an i2c bus driver supporting
>>	   (only) that functionality
>>	or 2) define a new bus type
>>
>>The advantage of 1) is that our userspace tools will find 1-wire
>>sensors. But we'd have to add more classes to identify them.
> 
> 
> It is quite easy to standartize 1-wire sysfs interface to match i2c
> userspace tools, but i think it is not good idea.
> 1-wire is diferent bus.
> 
> 
>>But I don't think 1-wire and i2c have enough in common to justify
>>that. Other than the fact that they're both serial and could both have
>>sensors on them, there's nothing alike.
>>They don't share any common chips or drivers (unlike isa and i2c).
>>With sysfs it would be pretty easy to enhance our userspace tools
>>to scan /sys/bus/w1 for additional sensors.
> 
> 
> Agree.
> 
> 
>>However if you think it's a serious implementation to have 1-wire and
>>i2c sharing a bus, you'll need a common driver to avoid PCI
>>registration conflicts. In that case sharing the i2c registration may
>>be easier. But as I said above this doesn't strike me as a good idea.
>>
>>So I think the way you did it (option 2) is correct.
>>
>>Could you send us the 18s20 driver so we can see how it all fits
>>together?
> 
> 
> Since i only have 1-wire termometers i implemented only part of their
> commands.
> Actually iButton is also 1-wire device and has different command set,
> but code now is not clean enough for iButton since i put termometer
> commands in one file with bus implementation.
> So 18s20 is part of w1.c.
> 
> 
I like what you did with family registration and separating the "chip" driver
from the "bus" driver.

In the "chip" driver (w1-term), can you follow our standards in Documentation/i2c/sysfs-interface
for the sysfs files? Then our userspace tools will work with only a simple change to
look in the w1 tree.

Also, in English, it's "thermometer" so the best abbreviation is "therm";
"term" will confuse people.

> 	Evgeniy Polyakov ( s0mbre )
> 
> Only failure makes us experts. -- Theo de Raadt
> 
