From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 16:27:01 +0000
Subject: Re: [lm-sensors] sensors-detect killed my CPU
Message-Id: <20080503182701.58a0c146@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <481B851A.10800@ag-web.biz>
In-Reply-To: <481B851A.10800@ag-web.biz>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

On Sat, 03 May 2008 17:27:34 +0200, achim wrote:
> Hi Jean and Pavel,
> 
> Thank you for the fast replies.
> 
> I run debian lenny 64bit which comes with sensors version 3.0.1. The
> debian package version is 3.0.1-5.

OK, so you have an up-to-date version of sensors-detect which only
probes the I2C addresses it has to.

> The board has no special overclocking chip.

How do you know? If probing the SMBus did something bad to your
hardware, then there has to be some special chip on the SMBus.

Of course, it can also be that your hardware just happened to die when
you ran sensors-detect but it was only a coincidence. To say the truth,
I'd be very happy if that was the case.

>                                             It comes with an 8-pin
> connector for the 12V rails so the cpu can use up to 36A and therefore
> has more headroom for overclocking at my settings the cpu used max
> 11-12A. (I have an Gigabyte Odin PSU with monitoring software whom shows
> the power usage of the single rails and tested this issue before).
> Also it has few more memory settings and allows to adjust the cpu and nb
> voltage in steps ov 0.0625V. Those features make it overclockers first
> choice.
> 
> The cpu was abit overclocked while i ran sensors-detect. I used an 13.5
> cpu multi instead of an 12.5 multi and had uppdet the cpu voltage from
> 1.3V to 1.3125V. Everything else was at stock.
> Before I ran sensors-detect I ran the phoronix-test-suite for
> benchmarking purpose whom showed no problems. Normaly one of the cores
> stopps responding if I overclock the system too far, that did not happen
> before at 2.7GHz, it started at around 2.8GHz.

I take it that you had already tried higher overclocking settings on
your CPU. Honestly, I can't say I am surprised when hardware dies after
being overclocked. That's a risk you take when overclocking.

> I have not yet contacted Sapphire. The board however is a clone of the

Please contact them. If nothing else, they should be aware that they
(presumably) use a chip which causes trouble. If users report about the
problem, maybe they can find a better chip / safer design in their next
products.

> DFI Lanparty UT790FX. On an overclocker forum I found an user report

Reminds me of this bug:
http://bugzilla.kernel.org/show_bug.cgi?idX89
The DFI Lanparty NF4 SLI Expert had an unknown chip at 0x2e which
rebooted the system when probed. I can only guess that your board has a
similar chip, except that the effects of probing are worse.

> whom had a similar problem. In his case speedfan caused his board/cpu 
> not to post. He contacted DFI and they said it can be that lower io
> access can cripple the bios. There are other users on that forum whom
> reported similar issues after starting sandra or evereset. Sometimes it
> is the bios getting corrupted sometimes it's the cpu getting stuck at C1
> stage during post. Sometimes it helps to cool down the cpu below zero
> and it posts back. In other cases it helped to use DDR2-800 ram instead
> of DDR2-1066 ram. I tried to reflash the bios and cleared the cmos and
> dmi area but it did not help. I also tried to use DDR2-800 memory
> without luck. I can sort out a crippled bios in my case bcause the board
> still works fine with an 9600BE.

And you also said that the original CPU no longer works on a different
motherboard. So indeed it smells like a dead CPU rather than BIOS
issues.

> 
> The board uses the ITC8716F-S chip and the it87 module works fine if i

I guess it's a typo and you mean IT8716F-S.

> load it manual. I'd like to look a little deeper into that sensor chip
> reading issues so i'll start to read the source code now to find out
> what happens. I attached the dmidecode and the lspci -nnv output.
> 
> ---------- kenrel log output of the it87 module ----------------
> it87: Found IT8716F chip at 0x228, revision 3
> it87: in3 is VCC (+5V)
> it87: in7 is VCCH (+5V Stand-By)
> hwmon-vid: Unknown VRM version of your x86 CPU
> ----------------------------------------------------------------

What's wrong with the it87 driver?

The good news is that the motherboard DMI data is present:

Base Board Information
	Manufacturer: SAPPHIRE Inc.
	Product Name: PC-AM2RD790

So we can blacklist it from i2c-piix4. I'll prepare a patch later today.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
