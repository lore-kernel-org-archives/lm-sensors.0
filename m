From: mds@paradyne.com (Mark D. Studebaker )
Date: Thu, 19 May 2005 06:23:50 +0000
Subject: [PATCH] i2c driver changes for 2.5.64
Message-Id: <3E7925B1.3000904@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <10476033213315@kroah.com>
In-Reply-To: <10476033213315@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



Greg KH wrote:
> On Mon, Mar 17, 2003 at 09:28:41PM -0500, Mark D. Studebaker  wrote:
> 
>>>If so, any hope of merging the two to make it at least sane?  :)
>>>
>>
>>sounds like more trouble than it is worth;
>>hard to move files in CVS without losing the history.
> 
> 
> True, but it seems strange to have files in two different repositories.
> But I now see why you did that because of the 2.4 code, right?  Anyway,
> I'll live :)
> 

No. The i2c and sensors projects were started by different people in
different places. In 1999, the i2c project was moved to be hosted
at Netroedge, where the sensors project was already.
It was put in a separate CVS tree. Over the last couple of
years the original i2c contributors have moved on.
But the separate trees remain.

> 
>>>>The biggest thing remaining to do in CVS is tackling
>>>>the PCI drivers. Approx. 20 of our 60 drivers are PCI.
>>>
>>>
>>>Where are these drivers?  I only see 17 instances of pci_module_init()
>>>in the lm_sensors2 cvs tree.  Are these the ones?  If you look at
>>>2.5.65, 3 ones were added from the cvs tree (and converted to work
>>>properly with the pci code.)  I see there are only 5 drivers in the main
>>>kernel tree that use pci_module_init() so a number more still need to be
>>>moved into there.
>>>
>>
>>right. Plus a couple more in chips/ that don't call pci_module_init
>>(sis5595, vt8231). Minus the ones already in 2.5 (I see that
>>2.5.65 added your patch with 3 more) leaves about 15.
>>
>>My point was the ~40 non-PCI drivers should go a lot more easily;
>>Kyosti already did a lot of cleanup on those.
> 
> 
> Good, I haven't really looked at them yet.
> 
> 
>>>>I'd like to keep sensors CVS 2.4-compatible, or at least
>>>>delay a branch as long as possible. Kyosti was working
>>>>on getting to the point that we could submit a patch
>>>>to 2.4 (until we do that, CVS is incompatible with stock 2.4
>>>>kernels because of the i2c_driver struct change).
>>>
>>>
>>>Why care about backwards compatibility?  Hopefully there will not need
>>>to be a cvs tree for the kernel portions of the i2c code if we get all
>>>of the code into the main kernel tree.
>>>
>>
>>We have a large number of 2.4-based "customers". Our project is
>>ranked in the top 100 on freshmeat (no idea if that means anything, though 
>>:)
>>If our 2.7.0 release last December was the last 2.4-compatible release,
>>how bad is that? I don't know. Unless we get a patch into 2.4, it will be,
>>because of the i2c_driver struct change that's already been made in CVS.
>>I'm guessing we want to release 2.4-compatible packages for another year?
> 
> 
> You've already forked the cvs tree, right?  What's keeping you from just
> staying with this fork for the 2.4 code?
> 
> 
>>But maybe that's hopelessly ambitious. Maybe 2.7.0 will have to be it.
>>Kyosti was optimistic that on the lm_sensors side (as opposed to i2c),
>>we could stay compatible with 2.4 and 2.5 in one branch. But he
>>hasn't been heard from in a while...
> 
> 
> I'm not so sure about that due to the driver model changes, but am not
> certain yet.  I'll shut up now until I get some more code done...
> 

guess I missed something, exactly what are the "driver model changes"?
I see a new adapter.dev.parent in the bus drivers, is that it?
Are there any changes affecting the chip drivers? I didn't see any.

> thanks,
> 
> greg k-h
> 
