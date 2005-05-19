From: marc@paracel.com (Marc Rieffel)
Date: Thu, 19 May 2005 06:24:46 +0000
Subject: lm_sensors vs. IPMI
Message-Id: <9D8C1A43309BAD4A9B46071DAF911D9E4C8A0C@exch01.paracel.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040303205611.0df7f98c.khali@linux-fr.org>
In-Reply-To: <20040303205611.0df7f98c.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I just want the basics - temperatures, voltages, and fan speeds - in a format that works on several different linux systems.  It took a lot of work to get it going on my Xeon and Opteron systems, but I'm basically happy with it now.  My current problem is making it work on my Itanium system.  After an exchange with Jean Delvare, it doesn't look like I'll be able to make it work the same way.  Now I'm trying the IPMI way.

Here's what I did,

- Download linux-2.4.22
- Download the ia64 patch for 2.4.22 so that I can actually compile the kernel
- Apply the linux-ipmi-2.4.22-v30.diff patch for IPMI
- turn on IPMI configuration modules
- build and install the kernel (after working around some hard size limits in mkinitrd)
- build and install i2c-2.8.4
- build lm_sensors 2.8.4

This last step isn't working, though.  
  
> make
gcc  -D__SMP__ -DMODVERSIONS -include /lib/modules/2.4.22-ipmi/build/include/linux/modversions.h -D__KERNEL__ -DMODULE -DEXPORT_SYMTAB -fomit-frame-pointer -I. -Ikernel/include -I/usr/local/include  -I/lib/modules/2.4.22-ipmi/build/include -nostdinc -I /usr/lib/gcc-lib/ia64-redhat-linux/2.96/include  -Wall -O2  -c kernel/busses/i2c-ipmb.c -o kernel/busses/i2c-ipmb.o
kernel/busses/i2c-ipmb.c: In function `ipmb_i2c_send_message':
kernel/busses/i2c-ipmb.c:90: too few arguments to function `ipmi_request_Rsmp_8ff655d7'
kernel/busses/i2c-ipmb.c: In function `ipmb_i2c_msg_handler':
kernel/busses/i2c-ipmb.c:252: warning: unused variable `client'
kernel/busses/i2c-ipmb.c:251: warning: unused variable `rcvid'
kernel/busses/i2c-ipmb.c: In function `ipmb_access':
kernel/busses/i2c-ipmb.c:286: warning: control reaches end of non-void function
kernel/busses/i2c-ipmb.c: In function `ipmb_register':
kernel/busses/i2c-ipmb.c:298: warning: unused variable `flags'
kernel/busses/i2c-ipmb.c: At top level:
kernel/busses/i2c-ipmb.c:40: warning: `i2c_ipmb_algorithm' defined but not used
kernel/busses/i2c-ipmb.c:48: warning: `i2c_ipmb_adapter' defined but not used
kernel/busses/i2c-ipmb.c:61: warning: `ipmb_address' defined but not used
kernel/busses/i2c-ipmb.c:71: warning: `rx_msg_data' defined but not used
kernel/busses/i2c-ipmb.c:97: warning: `ipmb_i2c_bmc_send_message' defined but not used
kernel/busses/i2c-ipmb.c:204: warning: `ipmb_rcv_channel_info' defined but not used
make: *** [kernel/busses/i2c-ipmb.o] Error 1

The call passes 5 arguments,

ipmi_request(i2c_ipmb_user, address, id, msg, 0)

but the prototype specifies 6 (in /lib/modules/2.4.22-ipmi/build/include/linux/ipmi.h)

int ipmi_request(ipmi_user_t      user,
                 struct ipmi_addr *addr,
                 long             msgid,
                 struct ipmi_msg  *msg,
                 void             *user_msg_data,
                 int              priority);

Any suggestions?  Should I try passing a priority of 0?

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
