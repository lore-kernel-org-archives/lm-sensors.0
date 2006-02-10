From: kevin.c.williams3@boeing.com (Williams, Kevin C)
Date: Fri, 10 Feb 2006 22:35:05 +0000
Subject: [lm-sensors] Can't load smsc47m1: no such device
Message-Id: <34919D5FCCAB494F97265DA64D1D703001AFCDF3@XCH-SW-1V1.sw.nos.boeing.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <34919D5FCCAB494F97265DA64D1D703001AFCDF0@XCH-SW-1V1.sw.nos.boeing.com>
In-Reply-To: <34919D5FCCAB494F97265DA64D1D703001AFCDF0@XCH-SW-1V1.sw.nos.boeing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

OK great!  At least I have somewhere to go.  I shall update my kernel
and return :)

Thanks
-kevin 

> -----Original Message-----
> From: Jean Delvare [mailto:khali at linux-fr.org] 
> Sent: Friday, February 10, 2006 2:13 PM
> To: Williams, Kevin C
> Cc: LM Sensors
> Subject: Re: [lm-sensors] Can't load smsc47m1: no such device
> 
> Hi Kevin,
> 
> > My fan speed is at the highest possible speed when booted 
> into linux 
> > on this system(same as speed during POST).  Load is 0.00 
> and x-windows 
> > is not installed. Winxp has a no audible fan noise unless 
> doing high 
> > computation but never as high as with linux.  So, I decided 
> to figure 
> > out how to tweak the fan speed.
> > 
> > 'sensors-detect' found SMSC 47M15x/192 and I found that in 
> the drivers 
> > section of the website, I(think) can use the 'smsc47m1' 
> driver.  So I 
> > tried it:
> > ~]# modprobe smsc47m1 force_addr=0x0800
> > FATAL: Error inserting smsc47m1
> > 
> (/lib/modules/2.6.11-1.1369_FC4smp/kernel/drivers/i2c/chips/smsc47m1.k
> > o)
> > : No such device
> 
> Support for the SMSC LPC47M15x/192 chip was added to the 
> smsc47m1 driver in Linux 2.6.13. Your kernel is older so the 
> support is simply not there. Unfortunately, there is no way 
> to force a device with that kind of driver. So your only hope 
> is a newer kernel (or a self compiled kernel from patched sources).
> 
> --
> Jean Delvare
> 

