From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: lm_sensors vs. IPMI
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E3E2A64@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040303205611.0df7f98c.khali@linux-fr.org>
In-Reply-To: <20040303205611.0df7f98c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

When I set the priority to zero in both i2c-ipmi.c and i2c-ipbm.c, those modules compile, install, and load fine.  But sensors-detect doesn't detect anything and manually loading adm1026 succeeds but shows no sensors.  Can you point me towards more documentation on how to use the i2c-ipm* modules or suggest what I should try next?

Thanks.

> -----Original Message-----
> From: Mark Studebaker [mailto:mds4@verizon.net]
> Sent: Thursday, March 04, 2004 6:30 PM
> To: Marc Rieffel
> Cc: LM Sensors
> Subject: Re: lm_sensors vs. IPMI
> 
> 
> I can elaborate.
> 
> Our modules bmcsensors and i2c-ipmi, together, connect the 
> lm-sensors userspace tools to IPMI,
> so that you can do the usual things you can do with 
> lm-senssors (see temperatures, voltages, and fan speeds,
> set limits, and see alarms). If this is what you need, 
> lm-sensors will do it.
> 
> IPMI is a quite sophisticated interface, and it is capable of 
> much more than what
> is available through the lm-sensors interface (for example, 
> event logging).
> 
> I'm sure there are many other programs available to use IPMI. 
> Some of these certainly
> will expose more of the richness of IPMI.
> 
> The third module is i2c-ipmb. This was meant to export the 
> raw i2c busses behind the
> BMC controller to the kernel. You could make the argument 
> that this isn't a good idea.
> But in any case, the BMC I have doesn't support the messages 
> required for i2c-ipmb,
> so I never got it working.
> 
> To the extent that board makers are adding BMC controllers to 
> boards, and putting
> the hardware monitors behind the BMC, this makes the direct 
> hardware monitor drivers
> that make up the bulk of lm-sensors unnecessary. In that 
> case, you must use IPMI.
> But you still need additional modules and/or userspace apps 
> that talk IPMI to get
> the data out. That's where you are welcome to try our solution
> (sensors->libsensors->bmcsensors->i2c-ipmi->IPMI->BMC->the chips)
> or another program on top of IPMI.
> 
> Hope this helps.
> Give our package a try if you like.
> 
> mds
> 
> 
> 
> Jean Delvare wrote:
> >>I've seen several postings claiming that lm_sensors is out 
> and IPMI is
> >>in.  Do they serve the same purpose?  I played with IPMI a 
> few months
> >>back and never got anything out of it.
> > 
> > 
> > I admit my relative ignorance in that domain. Yes, I think 
> they serve
> > the same purposes. I think we even have a non-working ipmi 
> driver that
> > is supposed to establish a bridge between both realms. 
> Never gave it a
> > try so far, however, since I don't have any hardware using 
> this. I guess
> > it's meant for relatively high-end servers only.
> > 
> 
> 
