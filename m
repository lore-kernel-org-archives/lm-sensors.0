From: Jean Delvare <khali@linux-fr.org>
Date: Tue, 11 May 2010 09:39:33 +0000
Subject: Re: [lm-sensors] after some days,
Message-Id: <20100511113933.0c42847f@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
References: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
In-Reply-To: <g2p8cb75a4a1005110155u5b359f97z8e16ab5a2c475455@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

Hi Arne,

On Tue, 11 May 2010 10:55:27 +0200, Arne Riecken wrote:
> after some days some min or max values for sensors get zero and
> therefore an alaram is triggered. sonsors -s cures that but only if
> the values are defined in the sensors3.conf. If default values are
> used, there is no way out, You have to manually set them.
> 
> chip "w83627ehf-*" "w83627dhg-*"
> 
> Linux 2.6.26-2-xen-amd64
> 
> OS Debian 5.0 "Lenny"
> 
> For example today VBAT max was suddenly 0, I had to reread it with
> sensors -s as You see below the correct value again.

Actually, sensors -s is _writing_ the limits to the chip, not reading
them.

> How to fix that?
> 
> # sensors
> w83627dhg-isa-0a10
> Adapter: ISA adapter
> VCore:       +0.91 V  (min =  +0.60 V, max =  +1.49 V)
> in1:        +12.20 V  (min = +10.82 V, max = +13.20 V)
> AVCC:        +3.26 V  (min =  +3.14 V, max =  +3.47 V)
> 3VCC:        +3.26 V  (min =  +3.14 V, max =  +3.47 V)
> in4:         +1.55 V  (min =  +1.35 V, max =  +1.65 V)
> in6:         +4.74 V  (min =  +4.25 V, max =  +5.25 V)
> VSB:         +3.26 V  (min =  +2.98 V, max =  +3.47 V)
> VBAT:        +3.12 V  (min =  +2.80 V, max =  +3.47 V)
> CPU Fan:    2636 RPM  (min = 1205 RPM, div = 8)
> Aux Fan:    12735 RPM  (min = 8035 RPM, div = 1)
> Sys Temp:    +31.0°C  (high = +60.0°C, hyst = +50.0°C)  sensor = thermistor
> CPU Temp:    +38.5°C  (high = +95.0°C, hyst = +90.0°C)  sensor = diode
> AUX Temp:    +38.5°C  (high = +80.0°C, hyst = +75.0°C)  sensor = diode
> cpu0_vid:   +1.300 V

Which hardware is this? Odds are that the registers are being
overwritten by the BIOS, or the hardware is faulty.

If you can easily reproduce the problem, the first thing to try is to
unload the w83627ehf driver and check whether the problem still
happens. You'll have to use "isadump 0xa15 0xa16" to dump the register
values, and check for the value of registers 0x2b to 0x3e. My guess is
that you will see them go to 0 even without the driver. If I am right,
this will prove the driver is innocent.

It would also be a good idea to disassemble the ACPI DSDT table to check
whether APCI is poking at the hardware monitoring registers. If you
send your table to me in private, I'll take a look.

-- 
Jean Delvare
http://khali.linux-fr.org/wishlist.html

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
