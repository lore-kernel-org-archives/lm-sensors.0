From: r.marek@assembler.cz (Rudolf Marek)
Date: Fri, 24 Nov 2006 13:21:29 +0000
Subject: [lm-sensors] DS2450 1-wire family driver
Message-Id: <4566F1D9.3040400@assembler.cz>
List-Id: <lm-sensors.vger.kernel.org>
References: <200611030904.29206.hans@rubico.se>
In-Reply-To: <200611030904.29206.hans@rubico.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,
> 
> We are a team working with uClinux for Blackfin DSPs and sensor networking, we 
> are currently in the stadium of investigating Linux capabilites on sensors 
> over i2c and 1-wire buses. I have been assigned to try out the DS2450 quad 
> A/D converter(1-wire slave device):
> 
> http://www.maxim-ic.com/quick_view2.cfm/qv_pk/2921
> 
> I Tried to search the lm-sensors list archive but could not find any related 
> drivers. Has there been any work on that family?

Hmm we have lot i2c drivers not so may W1. I'm CCing  Evgeniy Polyakov  as he 
might have more clue. I think you will need also a driver for the W1 master, 
besides the driver for the slave.

As for AD/DA stuff there is one driver written already for PCF8591 (which is an 
i2c device)

Philips 	 PCF8591 	 no (on purpose) 	 pcf8591 	2.6.3 	2.6.6 	 A/D, D/A 
converter. Ported to Linux 2.6 by Aurelien Jarno.

> I guess that it would need a 
> family driver. If non existent i will write one over the next week. Would the 
> community be interested in the driver? I think it could be quite useful for 
> connecting a wide variety of sensors to it.

I think even your company. The benefit of having the driver in kernel is huge:
(quoting the stable-api-nonsence.txt)
)  If your
driver is in the tree, and a kernel interface changes, it will be fixed 

up by the person who did the kernel change in the first place.  This 

ensures that your driver is always buildable, and works over time, with 

very little effort on your part. 

 

The very good side effects of having your driver in the main kernel tree 

are: 

   - The quality of the driver will rise as the maintenance costs (to the 

     original developer) will decrease. 

   - Other developers will add features to your driver. 

   - Other people will find and fix bugs in your driver. 

   - Other people will find tuning opportunities in your driver. 

   - Other people will update the driver for you when external interface 

     changes require it. 

   - The driver automatically gets shipped in all Linux distributions 

     without having to ask the distros to add it.

The maintainer of W1 subsystem is Evgeniy, he may help you with the w1 driver, 
this list is usually more about i2c based devices.

Regards
Rudolf

