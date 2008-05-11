From: Jean Delvare <khali@linux-fr.org>
Date: Sun, 11 May 2008 16:23:50 +0000
Subject: Re: [lm-sensors] [PATCH] sensors-detect: Check for 1-register-only
Message-Id: <20080511182350.7de46f3b@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080508224145.41cfa3ef@hyperion.delvare>
In-Reply-To: <20080508224145.41cfa3ef@hyperion.delvare>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Achim,

On Sun, 11 May 2008 13:42:59 +0200, achim wrote:
> Am Samstag, den 10.05.2008, 18:40 +0200 schrieb Jean Delvare:
> > OK, I have come up with something. There are not that many detection
> > routines using SMBus read word transactions, we only use them for the
> > following devices in the 0x48-0x4f address range: LM75, DS75, LM77,
> > LM92, LM76, MAX663x and DS1621. So I have changed the detection of all
> > these devices to do as much as possible with read byte transactions,
> > and only use read word transactions at the end when we are already
> > almost certain that we have identified the device.
> 
> I just tried your patch, and sensors-detect works fine without breaking
> the smbus now.
> 
> I attached the log.

Excellent, thanks for testing. It looks very good. I am going to commit
my two patches to SVN now, just in time for 3.0.2.

>                     Now without breaking at 0x4c the chip at 0x4e is
> detected as an overclock controller. 

Aha, interesting :) I am curious if this chip is also the one answering
at 0x2e. The datasheet doesn't suggest so, but as we saw several boards
with this overclocking chip and the mysterious chip at 0x2e, I start
wondering if it could be the same chip...

> I'm currently working on a module for the clockgenerator chip. I started
> with the lm75 module and modified it in a way that it reads out the ref
> HT speed. I want to extend it to read out the onboard gpu and pcie
> frequency also.
> 
> The registers at 0x90 and 0x91 are responsible for the ref HT frequency.
> 
> m=0x91[0:7]*4+0x90[6:7]
> n=0x90[0:5]
> 
> ref HT = 50MHz * m/n
> 
> It is also possible to change the ref HT on the fly by writing to those
> registers but that needs further inspection because the datasheet lacks
> the info what divider n is suitable. Also I only tested this with spread
> spectrum disabled, otherwise i'd need a few tables for the spectrum
> registers whom are also not covered by the datasheet.
> 
> Would such a module fit into the lm-sensors project? On the one hand it
> monitors motherboard frequencies on the other it's not a sensor chip i'm
> utilising.

Well, we have the atxp1 driver under drivers/hwmon already... But I
don't think it should be there. Anything related to overclocking should
be clearly labelled so and moved to a dedicated subsystem with a
separate maintainer. The target audience of these chips is clearly
different.

As for libsensors, no, I would rather not add the features of
overclocking chips to it. Better write a separate library if needed.
Again, separate audience.

We have the detection of these overclocking chips in sensors-detect
simply because they happen to live at an address which is frequently
used by thermal sensor chips. If they were living at different
addresses, we wouldn't care about them at all.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
