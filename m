From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:15 +0000
Subject: SMBus device access
Message-Id: <20040910103204.M16262@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <1094810411.26391.757.camel@localhost>
In-Reply-To: <1094810411.26391.757.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Fri, 10 Sep 2004 12:00:12 +0200, Nils Faerber wrote
> I am trying to access a SMBus device that is supposed to be 
> connected to SMBus. The hardware uses a SiS96x chipset SMBus 
> controller and the SiS SMBus driver loads fine, SMBus is detected properly.
> 
> My SMBus device is supposed to listen to address 0x92 which is quite
> obviously a 10-bit address. The device is a custom programmed PIC
> controller that controls a small display. By writing byte values to the
> PIC it will display something on the display.

First of all, we don't support 10-bit addresses. So if your device really uses
a 10-bit address, no wonder you can't get it to work.

However, I doubt that this is the case. We never saw any device using a 10-bit
address. My guess would be that your documentation is bogus and advertises an
address of 0x92 while the actual address is 0x49 (0x92 >> 1). This is a common
mistake due to the fact that the 7 bit address is left-aligned and completed
with the read/write bit when sent over the bus.

> All my tries failed so far. I have to admit that I only tried a
> userspace approach, i.e. through i2c-dev.
> 
> Everything I get is "Operation not permitted".

You should first try to see if you can detect your device. Use i2cdetect for
that. You may try the -r flag if the device doesn't show by default. If it
still doesn't show, I'd guess that it isn't properly wired (or doesn't answer
to read byte commands nor quick commands with data 0, aka "quick write"). The
documentation should tell you which commands the device understands.

Hope that hepls.

-- 
Jean Delvare
http://khali.linux-fr.org/
by just 
