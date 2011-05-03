From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 03 May 2011 12:25:28 +0000
Subject: Re: [lm-sensors] Using lm-sensors with TWL4030
Message-Id: <20110503142528.42938992@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <4DBFE717.1060000@je-suunnittelu.fi>
In-Reply-To: <4DBFE717.1060000@je-suunnittelu.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Tue, 03 May 2011 14:59:37 +0300, Niclas Knuts wrote:
> On 3.5.2011 14:42, Jean Delvare wrote:
> > On Tue, 03 May 2011 14:29:27 +0300, Niclas Knuts wrote:
> >> I am trying to setup lm-sensors for use with the Texas Instruments
> >> TWL4030 Chip (the main processor is  a OMAP3503). But I cannot seem to
> >> get it to detect the chip. I have added the hwmon drivers and I am using
> >> up to date MADC drivers that I have backported to kernel 2.6.32 (I am
> >> running Angstrom).
> > Disclaimer: I don't know a thing about this chip nor its drivers.
> >
> > There is no detection support for this device in sensors-detect, if
> > this was your question. I don't think this device can be detected from
> > user-space.
> I am aware that the automatic detect doesn't work, I have read through 
> the sensors-detect script.
> > My understanding is that the drivers for the TWL4030 should all get
> > loaded automatically thanks to module aliases, as long as the TWL4030
> > itself is properly registered during platform setup. Check in lsmod
> > whether twl4030-madc and twl4030-madc-hwmon are actually loaded. If
> > not, try loading them manually
> lsmod doesn't show the drivers, but they should have been compiled into 
> the kernel, not as modules. Maybe
> that is the problem?

No, this shouldn't make a difference. Check under /sys/devices/platform
if the platform devices have been properly created.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
