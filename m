From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:16 +0000
Subject: ticket 1775
Message-Id: <20040920231132.33b78a23.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
In-Reply-To: <E1C9PtS-000754-00@mendel.bio.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi David,

> Your suggestions were a big help.
> 
> I added this to /etc/modprobe.conf:
> 
> options w83781d force_w83782d=0,0x2d force_subclients=0,0x2d,0x48,0x49
> force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0
> 
> (which used to be in /etc/modules.conf on the old system)
> 
> then
>  
> % /etc/rc.d/init.d/lm_sensors start
> % sensors
> 
> showed reasonable values (see below)
> 
> However...
> 
> In /var/log/messages there was:
> 
> Sep 20 10:07:11 safserver kernel: w83781d 0-002d: Duplicate addresses
> 0x4f for subclients.
> Sep 20 10:07:13 safserver sensord: sensord started

This is odd, since you supposedly forced the subclient addresses to 0x48
and 0x49. I wonder if the syntax is correct. Having the same parameter
twice doesn't look good to me. Could you please try:
* merging both as force_subclients=0,0x2d,0x48,0x49,0,0x2c,0x4a,0x4b
OR
* swapping them as in force_subclients=0,0x2c,0x4a,0x4b force_subclients=0,0x2d,0x48,0x49

Maybe you'll get different results. See below first though.

> and when I tried to load these manually (from
> /etc/sysconfig/lm_sensors)
> 
> MODULE_0=i2c-amd756
> MODULE_1=i2c-isa
> MODULE_2=w83781d
> MODULE_3=w83627hf
> 
> the last one said:
> 
> FATAL: Module w83627hf not found.

You should have it, it's part of Linux 2.6 since 2.6.5 if I remember
correctly. Maybe you simply forgot to include it as a module at the time
you configured your kernel?

> In comparison, for RH 7.3 (2.4 kernel) the modules were:
> 
> MODULE_0=i2c-proc
> MODULE_1=i2c-dev
> MODULE_2=i2c-amd756
> MODULE_3=w83781d
> 
> so I'm guessing that w83627hf doesn't belong on the current list.
> Removed it, and sensors still works.  The duplicate address warning
> remains though.

The w83627hf driver is an alternative driver for some chips already
supported by the w83781d driver, plus some others. One of your two chips
is supported by both the w83781d and the w83627hf drivers. The second is
usually prefered but in your case I would stick to the former for both
chips if you can get it to work that way.

Note that you don't need i2c-isa if you don't use w83627hf.

> Here's the current output of sensors (without eeprom):
> (...)
> w83782d-i2c-0-28

This is strange. You forced address 0x2d and still 0x28 shows. Maybe the
chip is really at 0x28 and you should use this address for the
modprobe.conf file. This could explain why the subclients force failed.
So please first try the following line:

options w83781d force_w83782d=0,0x28 force_subclients=0,0x28,0x48,0x49 force_w83627hf=0,0x2c force_subclients=0,0x2c,0x4a,0x4b init=0


(basically, 0x2d becomes 0x28) and try again.

I'd hope that the error message in the logs would disappear, and
readings should be all correct.

-- 
Jean "Khali" Delvare
http://khali.linux-fr.org/
