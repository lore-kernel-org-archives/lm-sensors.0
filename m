From: Guenter Roeck <linux@roeck-us.net>
Date: Sun, 21 Jul 2013 07:40:33 +0000
Subject: Re: [lm-sensors] Few queries about lm-sensors and core temp.c
Message-Id: <20130721074033.GB26485@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
In-Reply-To: <D137AD88-0DA4-4CF3-889D-862386B3C35A@brown.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, Jul 19, 2013 at 05:47:24PM +0200, Jean Delvare wrote:
> Hi Kapil,
> 
> On Fri, 19 Jul 2013 11:28:28 -0400, Kapil Dev wrote:
> > I have a couple of queries about lm-sensors package.
> > 
> > 1) The FAQ section in chapter-1 says that the drivers update their values every 1 sec. I am aware of the fact that reading the sensors more frequently will affect the performance as it is intrusive to CPU to read an MSR, but I need to read the core-temperature values at faster rate for a project. Would you tell me what changes I should make to read the sensors faster? In particular, I want to read the core temperature (I believe it  is done in coretemp.c through IA32_THERMAL_STATUS MSR register). coretemp.c seems to have "jiffy" as time stamp, if I change it in the coretemp.c, will it work? Or, is there any other file that needs to be changed during kernel-compilation?
> 
> Just change this condition in show_temp():
> 
> 	/* Check whether the time interval has elapsed */
> 	if (!tdata->valid || time_after(jiffies, tdata->last_updated + HZ)) {
> 
> to just:
> 
> 	/* Always update */
> 	if (1) {
> 
> This will let you read the value as frequently as you want. Or if you
> want to keep a safety guard, you can simply change HZ to HZ/10 (read
> every 0.1 s max) or HZ/100 (read every 0.01 s max.)
> 
> > 2) Does the lm-sensor package use the correct value of Tjmax (the temp value at which PROCHOT signal goes high) automatically based on the processor brand and type? I noticed that the Tjmax 0C is used in core temp.c, but the 22nm intel processor that I am working on has Tjmax of 105C. Do I need to change it myself?
> 
> We have a complex heuristic to figure out the right TjMax value, but
> Intel made it such a mess that it is very difficult. So it really is
> best effort. If the driver has TjMax wrong for your CPU, please let us
> know what kernel version you are running, what CPU model you have is
> and where you found the correct TjMax value.
> 
The 22nm processors should all report it correctly from CPU registers,
so this is really odd. My IvyBridge CPU (i7-3770K) reports it correctly.
I am quite sure the Haswell did too, but I am some 12,000 miles away
from it and the system is shut down, so we'll have to wait for another
10 days or so until I can check it.

So, yes, we'll definitely need the CPU model and kernel version.

Guenter

> Then you can either try to fix it in the driver itself, or adjust it
> from userspace by adding this to /etc/sensors.d/coretemp.conf:
> 
> chip "coretemp-*"
> 
>     compute temp1 @+5, @-5
>     compute temp2 @+5, @-5
>     compute temp3 @+5, @-5
>     compute temp4 @+5, @-5
>     compute temp5 @+5, @-5
> 
> (Adjust for your own case...)
> 
> Hope that helps,
> -- 
> Jean Delvare
> http://khali.linux-fr.org/wishlist.html
> 
> _______________________________________________
> lm-sensors mailing list
> lm-sensors@lm-sensors.org
> http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
> 

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
