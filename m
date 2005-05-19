From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: lm_sensors2/kernel/chips adm1021.c adm1024.c...
Message-Id: <20041203234747.2a54e981.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/kernel/chips
> In directory mordac.netroedge.com:/tmp/cvs-serv11181
> 
> Modified Files:
> 	adm1021.c adm1024.c adm1025.c adm1026.c adm1031.c adm9240.c 
> 	asb100.c bmcsensors.c bt869.c ddcmon.c ds1307.c ds1621.c 
> 	eeprom.c fscher.c fscpos.c fscscy.c gl518sm.c gl520sm.c 
> 	icspll.c it87.c lm63.c lm75.c lm78.c lm80.c lm83.c lm85.c 
> 	lm87.c lm90.c lm92.c lm93.c ltc1710.c matorb.c max1619.c 
> 	max6650.c maxilife.c mtp008.c pc87360.c pca9540.c pca954x.c 
> 	pcf8574.c pcf8591.c saa1064.c sis5595.c smartbatt.c 
> 	smbus-arp.c smsc47m1.c thmc50.c via686a.c vt1211.c vt8231.c 
> 	w83627hf.c w83781d.c w83l785ts.c xeontemp.c 
> Log Message:
> (Khali) Discard owner field from i2c_driver structure. I do not
> restore inc_use/dec_use because they are not actually used anywhere.

This was step three of the reversal to gain linux 2.4 compatibility
again. At this point the compatibility is restored. However, module
reference counting is totally broken. In fact, it has been during the
whole 2.8 series of i2c and lm_sensors. Kyosti (I believe) had started
changes that he never finished and as a result there is no more
reference counting at all in the current code.

I'll fix that in the next two days. Two things need to be done:

1* Modules need to be "locked" in memory when used. Since kernel 2.3.27,
it is not possible to protect more than one module when one accesses a
given file/directory in /proc. So we have to choose between locking the
chip and the bus drivers. Obviously the chip drivers are a more logical
choice. Also note that this change in kernel 2.3 series is what makes
the inc_use/dec_use almost useless, which explains why I did not
reinserted them in the chip drivers.

2* Since we cannot lock the bus drivers through the /proc mechanisms, we
need to lock them differently (unless we don't care about kernel oopses,
of course). I plan to make chip drivers dependant on bus drivers they
are using. This will prevent bus drivers from being rmmodable when at
least one client needs them. This somehow breaks the independency
between bus and chip drivers that has been the base of the i2c subsystem
model for a long time, but this is also the only relatively safe way to
go without breaking the linux 2.4 compatibility.

Note that this solution will not remove all the race conditions that
were mentioned earlier, but they simply cannot be without compatibility
breakage so it won't happen. These race conditions are not that
dangerous. Nobody complained about problems for the past 14 months (i2c
2.8.x series) while there were no module reference counting *at all*,
let alone race conditions, so it is probably not a problem for anyone,
while compatibility is.

Thanks,
-- 
Jean Delvare
http://khali.linux-fr.org/
