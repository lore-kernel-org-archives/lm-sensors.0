From: dieter.jurzitza@t-online.de (Dieter Jurzitza)
Date: Thu, 31 Aug 2006 20:08:47 +0000
Subject: [lm-sensors] Question on driver maxilife.c - how to compile for
Message-Id: <200608312208.47176.dieter.jurzitza@t-online.de>
List-Id: <lm-sensors.vger.kernel.org>
References: <200608271418.06601.dieter.jurzitza@t-online.de>
In-Reply-To: <200608271418.06601.dieter.jurzitza@t-online.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Dear listmembers,
I announced that I wanted to test the installation of lm_sensors on a 2.4 
kernel arch.
I got sensors-2.10.0, i2c-2.10.0. I uninstalled the old sensors, I unloaded 
the i2c-modules.
After some fiddling I finally decided to use a "vanilla" kernel, but in vain 
(SuSE linux 9.0):
Installation of i2c is problemless,
installation of sensors works until depmod -a
Then I get tons of *** Unresolved symbols 
in /lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/xeontemp.o
etc etc etc.
This happens with the "stock" SuSE kernel and the vanilla kernel. More 
specifically:

/lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/maxilife.o: unresolved 
symbol i2c_sysctl_real
/lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/maxilife.o: unresolved 
symbol i2c_proc_real
/lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/maxilife.o: unresolved 
symbol i2c_deregister_entry
/lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/maxilife.o: unresolved 
symbol i2c_detect
/lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/maxilife.o: unresolved 
symbol i2c_register_entry
/lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/maxilife.o: 
insmod /lib/modules/2.4.21-144-smp4G/kernel/drivers/i2c/chips/maxilife.o 
failed

Any ideas? Any module ends with similar messages. Many thanks in advance,
take care



Dieter Jurzitza

Am Sonntag, 27. August 2006 22:22 schrieb Jean Delvare:
*****

-- 
-----------------------------------------------------------

                               |
                                \
                 /\_/\           |
                | ~x~ |/-----\   /
                 \   /-       \_/
  ^^__   _        /  _  ____   /
 <??__ \- \_/     |  |/    |  |
  ||  ||         _| _|    _| _|

if you really want to see the pictures above - use some font
with constant spacing like courier! :-)
-----------------------------------------------------------

