From: mds4@verizon.net (Mark Studebaker)
Date: Thu, 19 May 2005 06:24:50 +0000
Subject: Dallas 1-wire protocol implementation.
Message-Id: <406EE291.4080106@verizon.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
In-Reply-To: <20040402012453.0b5db46e.johnpol@2ka.mipt.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Evgeniy Polyakov wrote:
> [ I didn't receive your answer directly, so answering after copy-pasting
> from web archive. Sorry for thread brokeing. ]
> 
> On Fri, 2004-04-02 at 17:03, Greg KH wrote:
> 
>>On Fri, Apr 02, 2004 at 01:24:53AM +0400, Evgeniy Polyakov wrote: 
>>>The basic schema is following:
>>>wire.ko - provides general 1-wire API, netlink logging of search
>>>process(can be easily extended to log any other 1-wire events), sysfs
>>>processing and so on.
>>
>>Why netlink?  What's wrong with just monitoring the sysfs files?
> 
> 
> Because sometimes it is not very comfortable to monitor whole sysfs
> tree, but very convenient to just get event, wake up and begin
> processing.
> Since any slave may appear and disappear(slave removing actually not
> turned on but only created in a code, since after connecting to DDC pin
> 1-wire protocol is filled with 90% of DDC video card <-> monitor data
> noise and master very frequently losts it's slaves) asynchronously, so
> we always need to monitor at least this events. I think netlink is the
> best for this kind of events. The whole hotplug is overhead here i
> think.
> Actually one can poll() master's statistic file and determine what
> slaves are connected/disconnected by parsing ascii output, but is think
> it is not very convenient.
> 
> 

But that's a side-effect of using/sharing the DDC pins for 1-wire,
which I don't think is a realistic way to do it.
It may work but I don't think it's good. As you said you were desperate
to find some spare GPIO but you couldn't. 

On a dedicated bus the slaves won't get 'lost'.

The statistic file may be useful for debugging but shouldn't be
built in normally.

So I agree with Greg, I don't see the point of netlink.

Also not clear to me that you need all the threads.
Can slaves send messages spontaneously? I didn't think so.


> 
>>>static int w1_master_match(struct device *dev, struct device_driver *drv)
>>>{
>>>	log("%s: dev=%p, rv=%p\n", __func__, dev, drv);
>>>	return 1;
>>>}
>>
>>If you are going to create your own type of bus and driver and devices,
>>please do it correctly.  But is it really necessary?  Why not just use
>>the i2c framework for this?
> 
> 
> This was my initial idea too.
> But as a first approximation i didn't find easy way to create different
> masters("master" not in i2c notation, but "devices" which have the same
> transport driver, but for example have different base address). And we
> can't control masters/slaves with current i2c stack(for example delete
> one slave through ioctl), with current w1 stack we can't do it also but
> it is very easy to add(it is in TODO at least).
> And actually when i became implementing 1-wire protocol driver i didn't
> know about "byte" mode(or what is appropriate name for mode when
> "master" only receives data from i2c stack and sends it into the wire
> itself through software-defined timeouts(and actually in case of 1-wire
> protocol through it's own protocol) and so on, not through hardware i2c
> controller).
> 

This is the important choice to make:
	1) define a new I2C_ONEWIRE functionality and then register as an i2c bus driver supporting
	   (only) that functionality
	or 2) define a new bus type

The advantage of 1) is that our userspace tools will find 1-wire sensors.
But we'd have to add more classes to identify them.

But I don't think 1-wire and i2c have enough in common to justify that.
Other than the fact that they're both serial and could both have sensors
on them, there's nothing alike.
They don't share any common chips or drivers (unlike isa and i2c).
With sysfs it would be pretty easy to enhance our userspace tools
to scan /sys/bus/w1 for additional sensors.

However if you think it's a serious implementation to have 1-wire and i2c
sharing a bus, you'll need a common driver to avoid PCI registration conflicts.
In that case sharing the i2c registration may be easier. But as I said above
this doesn't strike me as a good idea.

So I think the way you did it (option 2) is correct.

Could you send us the 18s20 driver so we can see how it all fits together?

