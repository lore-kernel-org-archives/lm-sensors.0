From: khali@linux-fr.org (Jean Delvare)
Date: Sun, 10 Sep 2006 16:34:58 +0000
Subject: [lm-sensors] VT1211-ISA-6000 &  procfs/sysfs
Message-Id: <20060910183458.20318fb6.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <45034A2F.2020701@programmers.ch>
In-Reply-To: <45034A2F.2020701@programmers.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi Marc,

> I dont know if my problem is related to lm-sensors or VT1211 I2C patch 
> but I have the following prob when executing sensors -s :
> 
> vt1211-isa-6000: Can't access procfs/sysfs file for writing;

Does "sensors" work?

> Conclusion : pwmconfig  give me a : No sensors found!

Probably a different problem. pwmconfig and fancontrol are known to be
broken for platform drivers, which the vt1211 driver is. Anyway, the
VT1211 does not support manual fan speed control, which is when
pwmconfig and fancontrol are useful for, so you probably won't miss
them.

> Sys is populated,  kernel is a pure vanilla 2.6.18-rc5 patched with the 
> one given at 
> http://khali.linux-fr.org/devel/i2c/linux-2.6/hwmon-vt1211-new-driver.patch.  
> With the latest lm_sensors-2.10.0 and gcc4.0.3-1
> 
> I both compile the full set of the I2C drivers in modules or built-in.  
> It gave me the same result.
> 
> Hardware is EPIA M10000.
> 
> It is supposed to work, but it doesn't ? Any Idea of the prob ? 

I think you hit a known bug of lm_sensors 2.10.0. "sensors" won't work
unless it finds at least one i2c chip driver, even though non-i2c
hardware monitoring chip drivers are there. Possible workarounds:

* Load an i2c chip driver that works for your system. Typically
"eeprom" will do.

* Use lm_sensors SVN:
http://dl.lm-sensors.org/lm-sensors/snapshots/lm-sensors-r4155-20060908.tar.bz2

As a side note, you no more need to load the i2c-isa module.

-- 
Jean Delvare

