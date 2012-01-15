From: emilio <e_defranco@yahoo.co.uk>
Date: Sun, 15 Jan 2012 20:10:39 +0000
Subject: [lm-sensors] kernel 2.6.32 i2c-isa w83781d via686a
Message-Id: <1326658239.11934.YahooMailNeo@web29606.mail.ird.yahoo.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have an old mb austek K7V with via686a and w83781d devices.

Until some day ago, I was using a debian system with kernel 2.6.18.1 and lm-sensors 2.10.1.

sensors-detect correctly detect the devices and suggest to use the respective modules.

lsmod tell me that this module are loaded:


via686a;
w83781d;
i2c_isa;
i2c_viapro;
i2c_core.


with this configuration all working fine. In sensors.conf I have fine tunning the data for as99127 and the accuracy of the voltages and of the cpu fan is good (matched with the bios reading).

Now, on the same hardware I have installed an Ubuntu 10.04-03 LTS with kernel 2.6.32-37-generic.

I have installed the lm sensors 3.3.1 directly from ubuntu repository.

sensors-detect don't recognize the w83781d but only the via686a.

All reading are incorrect.

If I try to load with modprobe the w83781d this is loaded but I cannot read the sensors correctly (I read only via686a).

Installing from source code (recompiling for my kernel) the 2.10.8 lm sensor version (I have not the source code for the 2.10.1) the result is the same of the 3.3.1.

I think that the problem is the missing in kernel source of the module i2c-isa.

I read in internet that now the i2c support is included in the kernel, but if this is true, why lm-sensor not working with kernel 2.6.32-37 ?

ok, the mb is old, the via686a is not good supported, but: with kernel 2.6.18.1 and the i2c-isa all working fine for many years, why, now, with the new kernel I cannot have lm-sensors working again ?

There are some people that have some experience with ic2-isa missing in new kernel and have resolved the problem in other way ?

Thank in advance,

Emilio


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
