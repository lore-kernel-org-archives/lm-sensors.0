From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:24:38 +0000
Subject: Ticket 1552
Message-Id: <1075712396.401e118c99a72@imp.gcu.info>
List-Id: <lm-sensors.vger.kernel.org>
References: <20040201215112.2227131d.khali@linux-fr.org>
In-Reply-To: <20040201215112.2227131d.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

[Please CC: the mailing-list on reply.]

Quoting "J. Bolt" <james@evilpenguin.com>:

> james@plutonium:/usr/src$ sensors
> w83l785ts-i2c-1-2e
> Adapter: SMBus nForce2 adapter at 5500
> temp: 49.00 (temp)
>   temp_over: 110.00 (temp_over)

Uh-oh. Should display better than that. Patch against lm_sensors 2.8.3
attached. Care to give it a try?

I'm also a bit surprised that temp_over is 110 degrees C. According to
the data sheet, only two values are possible: 85 and 100. I don't give
much credit to that data sheet, still I'd like to take a closer look to
your chip, if you don't mind. "i2cdump 1 0x2e" (after unloading the
w83l785ts driver) should provide the information I am after. You'll
probably notice XX's in the dump. See below.

> asb100-i2c-1-2d
> Adapter: SMBus nForce2 adapter at 5500
> VCore 1:   +1.76 V  (min =  +1.63 V, max =  +1.81 V)
> +3.3V:     +3.17 V  (min =  +3.12 V, max =  +3.46 V)
> +5V:       +4.87 V  (min =  +4.73 V, max =  +5.24 V)
> +12V:     +11.49 V  (min = +10.76 V, max = +13.19 V)
> -12V:     -12.01 V  (min =  -0.00 V, max =  -0.00 V)
> -5V:       -5.04 V  (min =  -0.00 V, max =  -0.00 V)

No min/max limits set for -12V/-5V?

> cpu_fan:  4824 RPM  (min = 1225 RPM, div = 4)

I would set the fan_div to 2 and raise the min to 3000.

> big_fan:  2033 RPM  (min = 1896 RPM, div = 4)
> psu_fan:  1722 RPM  (min = 1454 RPM, div = 4)
> mb_temp:     +19?C  (high =    +0?C, hyst =    +0?C)

No limits here either? BTW, this is a very very low temperature you
have
here. Where is that system living?

> cpu_temp:    +44?C  (high =   +60?C, hyst =   +65?C)
> vid:      +1.725 V
> alarms:
> 
> Patched fine to 2.6.2, seems to work fine. Does rarely show "-1",
> although I'm sure that's the fault of the chip itself.

More or less. Other users have reported the problem as well. This is
caused by the driver being unable to read the temperature register,
probably because of a bus collision. Maybe your system logs show
something of that kind? Probably Asus' COP feature accesses the chip in
our back and causes the trouble, but it doesn't seem to be something we
can disable, so we'll have to cope (ah ah) with it.

Simply returning -1 isn't nice from us, nevertheless. There are several
other things that could be done:
- Notify the error (i.e. reading from the sysfs file returns an error),
then return the last known good value, if we have one.
- Retry reading the register until we succeed or reach a limit count.

We usually ignore read errors in chip drivers because they are rare, but
since it happens so frequently with that specific chip, we will have to
do it here. I will try to implement the solutions listed above, if you
want to help me test them.

-- 
Jean Delvare
http://www.ensicaen.ismra.fr/~delvare/

-------------- next part --------------
A non-text attachment was scrubbed...
Name: sensors-2.8.3-w83l785ts.diff
Type: application/octet-stream
Size: 418 bytes
Desc: not available
Url : http://lists.lm-sensors.org/pipermail/lm-sensors/attachments/20040202/39de2d43/sensors-2.8.3-w83l785ts.obj
