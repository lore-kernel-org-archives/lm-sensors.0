From: Jean Delvare <khali@linux-fr.org>
Date: Thu, 21 Jan 2010 17:03:51 +0000
Subject: Re: [lm-sensors] ADT 7490 report
Message-Id: <20100121180351.08ca652e@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4B56E28D.6080704@ast.cam.ac.uk>
In-Reply-To: <4B56E28D.6080704@ast.cam.ac.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Wed, 20 Jan 2010 15:32:19 +0000, Roderick Johnstone wrote:
> On 20/01/10 12:35, Jean Delvare wrote:
> 
> >
> > OK. While you're here, you can add:
> >
> >     label in2 "+3.3V"
> >     label in3 "+5V"
> >     label in4 "+12V"
> >
> > as they are pretty obvious, and:
> >
> >     ignore temp1
> >
> > for clarity. Not sure which of in0 or in1 is your CPU core voltage...
> 
> I determined the following extra info for the DP55WB board:
> 
> in0 seems to be the same value as the memory voltage seen in the bios
> in1 is consistent with cpu core voltage range and changes with load and 
> cpu frequency as expected
> fan1 is the cpu fan connector
> fan2 is the front fan connector
> fan3 is the rear fan connector

Thanks, I've put a sample configuration file for your board at:

http://www.lm-sensors.org/wiki/Configurations/Intel/DP55WB

> > OK. Your CPU is supported since kernel 2.6.32. But don't worry, just as
> > with the adt7475 driver, it is possible to build an updated driver
> > outside of the kernel tree. I've prepared it for you, you can download
> > the driver from:
> >
> > http://khali.linux-fr.org/devel/misc/coretemp/
> 
> I see the following in dmesg:
> coretemp coretemp.0: Unable to access MSR 0xEE, for Tjmax, left at default
> coretemp coretemp.1: Unable to access MSR 0xEE, for Tjmax, left at default
> coretemp coretemp.2: Unable to access MSR 0xEE, for Tjmax, left at default
> coretemp coretemp.3: Unable to access MSR 0xEE, for Tjmax, left at default

Hmm, this means that the absolute values returned by the coretemp
driver may be wrong. The relative value (difference between reading and
max limit) is still correct though. Rudolf, Huaxu, is this something we
have to live with, of can the coretemp driver be fixed?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
