From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:28 +0000
Subject: i2c-ali1535.c:548: warning: initialization from incompatible
Message-Id: <20050104125949.58e04411.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <41D6E143.8030204@arcor.de>
In-Reply-To: <41D6E143.8030204@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> I added
> 
>      set fan1_min 5000
>      set fan2_min 5000
> 
> and it looked like
> 
> via686a-isa-0c00
> Adapter: ISA adapter
> CPU core:  +1.80 V  (min =  +0.06 V, max =  +3.10 V)
> +2.5V:     +1.10 V  (min =  +2.37 V, max =  +2.62 V)   ALARM
> I/O:       +3.36 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +5.23 V  (min =  +4.51 V, max =  +5.50 V)
> +12V:     +11.89 V  (min = +10.81 V, max = +13.20 V)
> CPU Fan:  5818 RPM  (min = 4963 RPM, div = 8)          ALARM
> P/S Fan:     0 RPM  (min = 4963 RPM, div = 8)
> SYS Temp:  +26.0?C  (high =   +45?C, hyst =   +40?C)
> CPU Temp:  +21.8?C  (high =   +60?C, hyst =   +55?C)
> SBr Temp:  +22.3?C  (high =   +65?C, hyst =   +60?C)

So it works as expected.

> (even with 3.0.7). The interesting thing is, even when I comment that 
> out again, re-run sensors -s and then sensors, still the 4963 minimum
> is  there!

This is expected. "set" lines are only used when they are there.
"Missing" lines simply have no effect with "sensors -s", they are not
magically replaced by any kind of default.

> # mv libsensors.so.3.0.7 /root
> # ldconfig
> # ls /usr/local/lib/libsens* -ld
> 
> /usr/local/lib/libsensors.a
> /usr/local/lib/libsensors.so -> libsensors.so.3
> /usr/local/lib/libsensors.so.2 -> libsensors.so.2.0.1
> /usr/local/lib/libsensors.so.2.0.1
> /usr/local/lib/libsensors.so.3 -> libsensors.so.3.0.6
> /usr/local/lib/libsensors.so.3.0.0
> /usr/local/lib/libsensors.so.3.0.1
> /usr/local/lib/libsensors.so.3.0.2
> /usr/local/lib/libsensors.so.3.0.3
> /usr/local/lib/libsensors.so.3.0.4
> /usr/local/lib/libsensors.so.3.0.5
> /usr/local/lib/libsensors.so.3.0.6
> 
> but the problem still persists:
> 
> # sensors -s
> # sensors
> 
> via686a-isa-0c00
> Adapter: ISA adapter
> CPU core:  +1.80 V  (min =  +0.06 V, max =  +3.10 V)
> +2.5V:     +1.10 V  (min =  +2.37 V, max =  +2.62 V)   ALARM
> I/O:       +3.36 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +5.18 V  (min =  +4.51 V, max =  +5.50 V)
> +12V:     +11.95 V  (min = +10.81 V, max = +13.20 V)
> CPU Fan:  5818 RPM  (min = 84375 RPM, div = 8)          ALARM
> P/S Fan:     0 RPM  (min = 1222 RPM, div = 8)
> SYS Temp:  +26.4?C  (high =   +45?C, hyst =   +40?C)
> CPU Temp:  +21.8?C  (high =   +60?C, hyst =   +55?C)
> SBr Temp:  +22.3?C  (high =   +65?C, hyst =   +60?C)
> 
> Maybe 2.9.0 needs a newer gcc version? I only have 2.95.4

The first test proves that the values are read and written properly, so
the only problem here is the default value, which is either set by your
BIOS or not set at all. There's not much lm_sensors could have done bad.

Can you check in sensors.conf if you explicitely set the fan clock
dividers to 8? I think that the default is 2. Maybe the divider change
affected the min value in an unexpected way.

Also, you said that previous versions of lm_sensors would yield a
different default min value. What was that value? What was the value of
the dividers?

> > In the meantime, I will try to reproduce the problem on my own
> > system.
> 
> Thanks for your help! ;-)

No problem. I just checked and can't see the problem you report on my
system. However it might not be relevant since my via686a chip is *not*
connected on my motherboard.

-- 
Jean Delvare
http://khali.linux-fr.org/
