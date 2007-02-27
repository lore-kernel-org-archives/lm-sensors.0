From: hjk@linutronix.de (=?iso-8859-1?q?Hans-J=FCrgen_Koch?=)
Date: Tue, 27 Feb 2007 16:17:11 +0000
Subject: [lm-sensors] [PATCH] Add MAX6650 support
Message-Id: <200702271717.12665.hjk@linutronix.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200701171359.46334.hjk@linutronix.de>
In-Reply-To: <200701171359.46334.hjk@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Am Dienstag, 27. Februar 2007 16:35 schrieb Jean Delvare:
> On Tue, 27 Feb 2007 16:21:17 +0100, Matej Kenda wrote:
> > Hi Hans,
> >
> > I have tried the driver with on kernel 2.6.20.1 for platform ARM
> > (processor PXA255) to get fan speeds from the chip max6651.
> >
> > It seems that the driver works, because it exports the values in /sys
> > file system.
> >
> > I have few small comments on the implementation:
> >
> > * use mutex instead of semaphore
>
> This was fixed in the second version of the driver (posted by
> Hans-J?rgen on February 12th.)
>
> > * define i2c driver ID in the include/i2c-id.h
>
> Even better, don't set an ID if you don't need it.

All right, I threw that out. Actually, I didn't know that you can simply omit 
that .id 

>
> > However I have noticed the following issue, which might be related to the
> > driver of libsensors. Whenever I issue the command sensors to display
> > values of the fans, I get an error:
> >
> > $ sensors
> > max1617a-i2c-0-18
> > Adapter: pxa2xx-i2c
> > Main PCB:    +40 C  (low  =    +0 C, high =   +50 C)
> >
> > max1617a-i2c-0-29
> > Adapter: pxa2xx-i2c
> > Main PCB:    +38 C  (low  =    +0 C, high =   +50 C)
> >
> > max6650-i2c-0-48
> > Adapter: pxa2xx-i2c
> > ERROR: Can't get FAN1 data!
> > ERROR: Can't get FAN2 data!
> > ERROR: Can't get FAN3 data!
> > ERROR: Can't get FAN4 data!
> >
> > max6650-i2c-0-4b
> > Adapter: pxa2xx-i2c
> > ERROR: Can't get FAN1 data!
> > ERROR: Can't get FAN2 data!
> > ERROR: Can't get FAN3 data!
> > ERROR: Can't get FAN4 data!
> >
> > $ sensors --version
> > sensors version 2.10.2 with libsensors version 2.10.2
> >
> > I tried to rename entries that the driver creates from fan0-fan3 to
> > fan1-fan4 as used by the libsensors and sensors, but that didn't help.
>
> The files should actually be named fan1_input to fan4_input (for
> measured values.)

I renamed the files accordingly.

>
> > Did you have to modify the (lib)sensors in any way to display the values?
>
> You shouldn't need to.

I attached the current version of the patch, please tell us if this works for 
you.

Thanks,
Hans

-------------- next part --------------
A non-text attachment was scrubbed...
Name: max6650.patch
Type: text/x-diff
Size: 18673 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20070227/0ef1fcd6/attachment.bin 
