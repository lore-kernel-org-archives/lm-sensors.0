From: mds@paradyne.com (Mark D. Studebaker)
Date: Thu, 19 May 2005 06:23:29 +0000
Subject: lm_sensors and gcc-3.0.3
Message-Id: <3C58993C.2E3E8B30@paradyne.com>
List-Id: <lm-sensors.vger.kernel.org>
References: <200201280848.g0S8mOU03398@hal.astr.lu.lv>
In-Reply-To: <200201280848.g0S8mOU03398@hal.astr.lu.lv>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

???
no-strict-aliasing prevents modules from taking several minutes to load?
Can you explain why?
thanks
mds


Andris Pavenis wrote:
> 
> Tried to use lm_sensors-2.6.2 (compiled with gcc-3.0.3 release) with kernel-2.4.18-pre7
> (also compiled with gcc-3.0.3). It took some minutes to load lm_sensors kernel modules,
> but sensors semmed to work after that.
> 
> Adding -fno-strict-aliasing to modules compile options fixed that bad
> behaviour:
> 
> --- Makefile~1  Sat Jun  2 06:41:17 2001
> +++ Makefile    Mon Jan 28 10:32:01 2002
> @@ -170,7 +170,7 @@
>            -Wcast-align -Wwrite-strings -Wnested-externs -Winline
>  endif
> 
> -MODCFLAGS := $(CFLAGS) -D__KERNEL__ -DMODULE -fomit-frame-pointer
> +MODCFLAGS := $(CFLAGS) -D__KERNEL__ -DMODULE -fomit-frame-pointer -fno-strict-aliasing
>  MODCFLAGS := $(MODCFLAGS) -DEXPORT_SYMTAB
>  PROGCFLAGS := $(CFLAGS)
>  ARCFLAGS := $(CFLAGS)
> 
> Below is what I see in dmesg (simply for info what parts are actually in use)
> 
> Andris
> 
> i2c-i810.o version 2.6.2 (20011118)
> i2c-i810.o: i810/i815 found.
> i2c-dev.o: Registered 'I810/I815 I2C Adapter' as minor 0
> i2c-core.o: adapter I810/I815 I2C Adapter registered as adapter 0.
> i2c-i810.o: I810/I815 I2C bus initialized
> i2c-dev.o: Registered 'I810/I815 DDC Adapter' as minor 1
> i2c-core.o: adapter I810/I815 DDC Adapter registered as adapter 1.
> i2c-i810.o: I810/I815 DDC bus initialized
> i2c-i801.o version 2.6.2 (20011118)
> i2c-dev.o: Registered 'SMBus I801 adapter at e800' as minor 2
> i2c-core.o: adapter SMBus I801 adapter at e800 registered as adapter 2.
> i2c-i801.o: I801 bus detected and initialized
> w83781d.o version 2.6.2 (20011118)
> i2c-core.o: driver W83781D sensor driver registered.
> i2c-core.o: client [AS99127F chip] registered to adapter [SMBus I801 adapter at e800](pos. 0).
> i2c-core.o: client [AS99127F subclient] registered to adapter [SMBus I801 adapter at e800](pos. 1).
> i2c-core.o: client [AS99127F subclient] registered to adapter [SMBus I801 adapter at e800](pos. 2).
> 
> bash-2.05$ sensors
> as99127f-i2c-2-2d
> Adapter: SMBus I801 adapter at e800
> Algorithm: Non-I2C SMBus adapter
> VCore 1:   +1.64 V  (min =  +1.56 V, max =  +1.72 V)
> +3.3V:     +3.45 V  (min =  +3.13 V, max =  +3.45 V)
> +5V:       +5.04 V  (min =  +4.72 V, max =  +5.24 V)
> +12V:     +11.36 V  (min = +10.79 V, max = +13.19 V)
> -12V:     -11.48 V  (min = -10.73 V, max = -13.19 V)
> -5V:       -4.98 V  (min =  -4.74 V, max =  -5.24 V)
> fan1:     4115 RPM  (min = 1500 RPM, div = 4)
> temp1:       +30?C  (limit =  +60?C, hysteresis =  +50?C)
> temp2:     +35.5?C  (limit =  +67?C, hysteresis =  +60?C)
> vid:      +1.65 V
> alarms:   Chassis intrusion detection
