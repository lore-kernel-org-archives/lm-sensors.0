From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 23 Jun 2007 14:36:48 +0000
Subject: Re: [lm-sensors] Howto name fintek 71882 temp sysfs files?
Message-Id: <20070623163648.7f2d8fca@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <46764961.5080602@hhs.nl>
In-Reply-To: <46764961.5080602@hhs.nl>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Hans,

On Mon, 18 Jun 2007 10:59:13 +0200, Hans de Goede wrote:
> The temp sensors in this chip have an OVT (over temperature) and a high 
> temperature limit, both have a shared hysteresis. This hysteresis is a true 
> hysteresis. When a temp is over either limit a flag gets set, when it gets 
> below limit-hysteresis the flag gets cleared again.
> 
> I've been digging through the datasheets to try and find the differences 
> between the 2 limits.
> 
> Both limits have flags, can cause interrupts and PME events.
> 
> The main difference seems to be OVT Output Enable Register 1  Index 66h
> at page 75 of the datasheet:
> http://www.fintek.com.tw/files/productfiles/F71882_V0.24P.pdf
> 
> The high limit has alert events coupled to its, which can not be enabled (read 
> only). Where as the ovt has an over temperature (OVT) mechanism, which can be 
> enabled and is active for the CPU temp by default, the OVT mechanism, has an 
> output pin reserved which it can control when an OVT conditions happens.
> 
> The high limit can be coupled to forcing fans to go full speed.
> 
> To me this sounds like the high limit should be mapped to temp#_max and the OVT 
> to temp#_crit,

Yes.

> and since the hyst is for both limits it should be temp#_hyst.

No. This kind of shortcut was excluded from the standard sysfs
interface on purpose, because it is error prone. A given feature should
correspond to one and only one sysfs file name.

Additionally, an hysteresis is an attribute of a temperature limit, not
an attribute of the temperature sensor itself. This must show in the
name of the attribute. People are already confused enough with the
concept of hysteresis, let's not add to it.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
