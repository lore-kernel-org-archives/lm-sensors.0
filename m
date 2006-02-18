From: khali@linux-fr.org (Jean Delvare)
Date: Sat, 18 Feb 2006 11:27:00 +0000
Subject: [lm-sensors] vt8231 - epia800
Message-Id: <20060218122700.8488f485.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <d5dcbca20602171241s2380ccc6x@mail.gmail.com>
In-Reply-To: <d5dcbca20602171241s2380ccc6x@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

> Does anyone can tell me how to get the temperature of my system ?
> 
> MB : Epia 800 (sensor vt8231)
> (...)
> output of sensors :
> vt8231-isa-6000
> Adapter: ISA adapter
> in0:       +2.13 V  (min =  -0.03 V, max =  +2.63 V)
> +2.5V:     +2.55 V  (min =  -0.04 V, max =  +3.16 V)
> VCore:     +2.07 V  (min =  +1.56 V, max =  +1.72 V)   ALARM

What's the nominal voltage for your CPU?

> +5V:       +4.03 V  (min =  -0.07 V, max =  +5.23 V)
> +12V:     +12.55 V  (min = +11.36 V, max = +12.55 V)
> +3.3V:     +3.30 V  (min =  +3.13 V, max =  +3.46 V)
> fan1:        0 RPM  (min = 2570 RPM, div = 2)          ALARM
> fan2:        0 RPM  (min = 2570 RPM, div = 2)          ALARM

If you don't have fans connected or they are not able to report their
speed, set the limit to 0 to get rid of the alarm. If you have slow
fans, increase the fan clock divider values to 4 or 8 to get the speed
reading, and set the limits to lower values too.

> ERROR: Can't get TEMP2 data!
> ERROR: Can't get TEMP3 data!
> ERROR: Can't get TEMP4 data!
> ERROR: Can't get TEMP5 data!
> ERROR: Can't get TEMP6 data!
> ERROR: Can't get TEMP7 data!

Kernel version (uname -r)?

Sensors version (sensors -v)?

-- 
Jean Delvare

