From: khali@linux-fr.org (Jean Delvare)
Date: Fri, 14 Oct 2005 14:04:40 +0000
Subject: [lm-sensors] lm_sensors 2.9.2 & kernel 2.6.8-24
Message-Id: <RexXovHz.1129290791.6467740.khali@localhost>
List-Id: <lm-sensors.vger.kernel.org>
References: <434F973D.5080607@scs.co.uk>
In-Reply-To: <434F973D.5080607@scs.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org


Hi Charles.

On 2005-10-14, Charles Whittington wrote:
> I am having freeze-ups and reboots on an MTC8640 laptop running SuSE 9.2
> which I suspect may be caused by hardware problems, possibly
> clock/powersave related. I have installed lm_sensors 2.9.2, kernel is
> 2.6.8-24. I am OK with software but sometimes a bit dim where h/w is
> concerned. I have read the docs on the website, I am still not sure
> whether precisely this combination is supposed to be supported. The
> website sort of indicates that SiS996x is supported but the outputs are
> as below. Could you advise?

If the laptop is recent, I'd advise a kernel upgrade to start with.
2.6.8 is aging. ACPI and cpufreq are areas in which many developments
have been done in the past months. Maybe this would fix the problems you
observe altogether.

> Next adapter: SiS96x SMBus adapter at 0x1000 (Algorithm unavailable)
> Do you want to scan it? (YES/no/selectively):

Surpisingly, nothing is found on the SMBus, this is quite rare not to
even see an EEPROM or a clock chip here. Can you please provide the
output of "i2cdetect 0"?

It is probable that you actually have nothing here, but that could also
be an SMBus driver issue.

> Probing for `Nat. Semi. PC87351 Super IO Fan Sensors'
>   Failed! (0xea)

So you have a Super-I/O chip, most probably from National Semiconductor.
Do you happen to know what it is? Our script doesn't seem to know.
Sometimes Super-I/O chips include hardware monitoring capabilities.

Are you certain that your laptop does support hardware monitoring ? It's
quite frequent that they don't. You may take a chance with ACPI (look
at /proc/acpi/thermal_zone and /proc/acpi/fan). This is rather limited
compared to what lm_sensors offers, but better than nothing, and quite
often that's the best you can get on laptops.

--
Jean Delvare
