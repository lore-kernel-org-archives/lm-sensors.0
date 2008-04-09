From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 09 Apr 2008 09:42:11 +0000
Subject: Re: [lm-sensors] [PATCH] hwmon: fix common race conditions, batch  2
Message-Id: <20080409114211.11f114fc@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <20080406180721.GN27659@mars.solarsys.private>
In-Reply-To: <20080406180721.GN27659@mars.solarsys.private>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 07 Apr 2008 22:04:24 +0200, Hans de Goede wrote:
> Jean Delvare wrote:
> > We have to be consistent in our choices. The general
> > decision for Linux hardware monitoring drivers was to read the
> > registers that aren't supposed to change. While this decision could be
> > discussed (as you seem to be willing to do),
> 
> Yes, I wonder why we read registers which are not supposed to change?
> The only reason I can come up with is that we suspect something maybe meddling 
> with the hardware underneath us (most likely ACPI). If this is the reason, then 

ACPI or SMM, yes. Could also be user-space but then it's really the
user's responsibility.

> we should check if that has _actually happened_ and if it does report it 
> (through printk/dmesg). Thinking about this I wonder of the use of reading 
> these registers regulary at all, even if ACPI is communicating with the hwmon 
> device, I think its highly unlikely it will be changing any settings (like for 
> example limits) after boot.

I've seen it at least once. The chip had an output pin going low when
either the low or the high temperature limit was crossed. The BIOS was
changing the limits when the pin went low, so it was sort of emulating
multiple levels of thermal alert while the chip only supported one in
hardware.

> So my vote goes out to rather then adding this locking, remove the periodically 
> reading of registers which never change. With that said, I still have no 
> objections to this patch going in in the mean time, until we decide upon how to 
> handle this in the future and then start preparing the necessary patches.

I don't like the current approach either. In fact it seems that every
new developer finds it odd at first, and in the end we only keep doing
it because it has been so from the beginning of the lm-sensors project.
The fact is that our drivers would perform much better if we did not
repeatedly read from registers which aren't supposed to change. Some
drivers mitigate the performance penalty by reading from these
registers less frequently, but then it somewhat misses the original
point of always reflecting the current register state.

But on the other hand, anything that helps spot conflicts with ACPI or
SMM is welcome, as these issues can be very hard to investigate - in
particular for SMBus-based chips or chips with index/data pair I/O port
access, where simultaneous access can result in data corruption. Thomas
Renninger and myself proposed something that should help for ACPI in
some cases but Linus rejected our approach. Removing the extra reads
from our drivers would be one less way to spot that kind of problem. Of
course we can look at the registers directly using i2cdump or isadump
in most cases, but users are less likely to do that, while they usually
do notice when limits change mysteriously.

So all in all I have to admit that I don't really know what to do.
Maybe the extra reads should be made a compilation-time or (probably
better) a run-time option, so we leave the decision to the user?

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
