From: Jia Hongtao-B38951 <B38951@freescale.com>
Date: Mon, 15 Oct 2012 02:22:33 +0000
Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
Message-Id: <412C8208B4A0464FA894C5F0C278CD5D01AD886C@039-SN1MPN1-003.039d.mgd.msft.net>
List-Id: <lm-sensors.vger.kernel.org>
References: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
In-Reply-To: <FF6D174B07759740B0259F914CE6D7D305339414@LONMLVEM04.e2k.ad.ge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org



> -----Original Message-----
> From: Jean Delvare [mailto:khali@linux-fr.org]
> Sent: Friday, October 12, 2012 11:58 PM
> To: Jia Hongtao-B38951
> Cc: lm-sensors@lm-sensors.org
> Subject: Re: [lm-sensors] Supporting ADT7481 temperature sensor
> 
> On Fri, 12 Oct 2012 10:30:32 +0000, Jia Hongtao-B38951 wrote:
> > Hello all,
> >
> >
> >
> > I'm looking for ADT7481 support in kernel.
> >
> > I got some messages here:
> >
> > http://www.spinics.net/lists/lm-sensors/msg25066.html
> >
> >
> >
> > It seems this patch has not been upstreamed yet.
> >
> >
> >
> > Does anyone know where to find the patch?
> 
> There was a discussion but no code was ever submitted. You should try
> contacting Malcolm, but it was long ago, he may have changed jobs or lost
> interest meanwhile.
> 
> > If not could anyone know a quick way to support ADT7481 in kernel?
> 
> You can try forcing ADT7461 support on your chip as apparently the
> ADT7481 implements a superset of the ADT7461 features. Find which i2c bus
> your chip is on, then from user space, do:
> 
> # echo adt7461 $ADDR > /sys/bus/i2c/devices/i2c-$BUSNR/new_device
> 
> where $ADDR is the hexadecimal 7-bit address address of your ADT7461
> device, and $BUSNR the i2c bus number.
> 
> Obviously you won't have support for the 2nd external sensor that way,
> but that's a start.
> 


Got it.
Thanks for your suggestions.

- Hongtao.



_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
