From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Mon, 25 May 2009 15:58:36 +0000
Subject: Re: [lm-sensors] lm-sensors chip support
Message-Id: <4A1AC02C.5040909@cam.ac.uk>
List-Id: <lm-sensors.vger.kernel.org>
References: <0331509C72A4CE4F925973DC8EC98E1B0165EC68@AMSACEX2.americas.ad.flextronics.com>
In-Reply-To: <0331509C72A4CE4F925973DC8EC98E1B0165EC68@AMSACEX2.americas.ad.flextronics.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

There are many more knowledgeable people on this list, but in the
meantime...
> I'm in a project which is looking at using lm-sensors to monitor the
> following chips on various circuit boards:
> 
> - ADM1032ARMZ (temp sensor)
> - MAX6639 (temp sensor)
Not a clue on this one but looks like a pretty standard hwmon chip.
> - POWR1014A (power monitor)
That one does a whole lot more than would conventionally be supported by
hwmon.  I'd guess you would want a multifunction device driver, with hwmon
and pmic drivers hanging off it.  I'm not quite sure how to handle this
one as, whilst designed to control supply voltages etc, at first glance
it looks to simply be a dac (alongside all the hwmon style bits).  If you
do want to support these elements I'd suggest a post to lkml to get opinions
of the voltage and mfd users / maintainers.  In the meantime I've copied
in Liam and Mark who may want to express an opinion on this.

> - SA56004EDP (temp sensor)
I haven't checked this thoroughly but the data sheet refers to certain
variants being address and pin compatible with the lm86 which is supported
by the lm90 driver.  I'd suggest getting the data sheets for both and doing
a comparison.  This one or the max6639 would probably be the best ones
to try writing drivers for.
 
> I cross-checked these against the lm-sensors list of supported chips
> (http://www.lm-sensors.org/wiki/Devices) and find that only the 1st one
> is supported.  
> 
> Do you know if there are any plans to develop support for the latter 3
> in the list?  Or, are any of these compatible with another chip that is
> supported?  
> 
> If there are no plans and no compatibilities, is there documentation you
> can point me to that describes a framework for adding a driver to be
> supported by lm-sensors.  I'd like to consider this if this is not
> difficult.  
> 
> As I understand it, there is no chip-specific code in lm-sensors; to add
> support, one must add driver code into the kernel itself (ie. no code is
> added to the lm-sensors domain).  Is this correct?  Is there an example
> of a driver that was supported recently that I can use as an
> example/framework?
Basically browse the various drivers supported by the kernel until you find
something close to what you are working on.  If it's close enough then try
to add the support to the current driver.  If not try and replicate the way
an existing driver is set up.

As for guidance, there is a lot of relevant documentation in Documentation
directory of the kernel.

Have fun ;)

Jonathan

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
