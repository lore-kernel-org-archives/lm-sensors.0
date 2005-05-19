From: nils.faerber@kernelconcepts.de (Nils Faerber)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: SMBus device access
Message-Id: <1094814144.26391.768.camel@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094810411.26391.757.camel@localhost>
In-Reply-To: <1094810411.26391.757.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Thank you very much for the fast reply!
More below...

Am Fr, den 10.09.2004 schrieb Jean Delvare um 13:43:
> On Fri, 10 Sep 2004 12:00:12 +0200, Nils Faerber wrote
> > I am trying to access a SMBus device that is supposed to be 
> > connected to SMBus. The hardware uses a SiS96x chipset SMBus 
> > controller and the SiS SMBus driver loads fine, SMBus is detected properly.
> > 
> > My SMBus device is supposed to listen to address 0x92 which is quite
> > obviously a 10-bit address. The device is a custom programmed PIC
> > controller that controls a small display. By writing byte values to the
> > PIC it will display something on the display.
> 
> First of all, we don't support 10-bit addresses. So if your device really uses
> a 10-bit address, no wonder you can't get it to work.

Oh, is this still true?
I thought this to be some old comment since the ioctl() for switching to
ten bit mode is already there ;)
And if it still is not supported, is this true for user-space and
kernel-space or for user-space only?
Because if the assumed 10-bit address is indeed valid I would be in deep
trouble, i.e. I would have to add 10-bit support to the whole i2c
subsys?

> However, I doubt that this is the case. We never saw any device using a 10-bit
> address. My guess would be that your documentation is bogus and advertises an
> address of 0x92 while the actual address is 0x49 (0x92 >> 1). This is a common
> mistake due to the fact that the 7 bit address is left-aligned and completed
> with the read/write bit when sent over the bus.

This might be the case, good hint!
The spec I have (under NDA, sorry) looks like some very coarse
documentation done in a midday break :(

> > All my tries failed so far. I have to admit that I only tried a
> > userspace approach, i.e. through i2c-dev.
> > 
> > Everything I get is "Operation not permitted".
> 
> You should first try to see if you can detect your device. Use i2cdetect for
> that. You may try the -r flag if the device doesn't show by default. If it
> still doesn't show, I'd guess that it isn't properly wired (or doesn't answer
> to read byte commands nor quick commands with data 0, aka "quick write"). The
> documentation should tell you which commands the device understands.

The docuentation is not very specific about SMBus or I2C things. It
mostly describes the internal regsiters the PIC supports and what they
mean. Not much more about the external interface :(

And I did not try i2cdetect more extensively since I thought the device
to be on a 10-bit address...

Oh well... I fear I have to send some more emails to Taiwan to get more
detailed specs :(

[...testing while writing...]

Ha!!!
You are right, it is 0x49!!!
And suddenly at least i2cset work (nut not my test program but I will
find that bug myself, I think :)


Thank you so much, great help and so quickly!
Perfect!

> Hope that hepls.
Best wishes!
  nils faerber

-- 
kernel concepts          Tel: +49-271-771091-12
Dreisbachstr. 24         Fax: +49-271-771091-19
D-57250 Netphen          Mob: +49-176-21024535
--
