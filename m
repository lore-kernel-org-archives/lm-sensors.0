From: khali@linux-fr.org (Jean Delvare)
Date: Thu, 19 May 2005 06:25:25 +0000
Subject: lm_sensors2/kernel/chips adm1021.c adm1024.c...
Message-Id: <20041204232606.37c5b281.khali@linux-fr.org>
List-Id: <lm-sensors.vger.kernel.org>
References: <20041203234747.2a54e981.khali@linux-fr.org>
In-Reply-To: <20041203234747.2a54e981.khali@linux-fr.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

> Update of /home/cvs/lm_sensors2/kernel/chips
> In directory mordac.netroedge.com:/tmp/cvs-serv14403
> 
> Modified Files:
> 	adm1021.c adm1024.c adm1025.c adm1026.c adm1031.c adm9240.c 
> 	asb100.c bmcsensors.c bt869.c ddcmon.c ds1621.c eeprom.c 
> 	fscher.c fscpos.c fscscy.c gl518sm.c gl520sm.c icspll.c it87.c 
> 	lm63.c lm75.c lm78.c lm80.c lm83.c lm85.c lm87.c lm90.c lm92.c 
> 	lm93.c ltc1710.c matorb.c max1619.c max6650.c maxilife.c 
> 	mtp008.c pc87360.c pca9540.c pca954x.c pcf8574.c pcf8591.c 
> 	saa1064.c sis5595.c smartbatt.c smbus-arp.c smsc47m1.c 
> 	thmc50.c via686a.c vt1211.c vt8231.c w83627hf.c w83781d.c 
> 	w83l785ts.c xeontemp.c 
> Log Message:
> (Khali) Restore controlling_mod argument to i2c_register_entry(). This
> is needed to properly lock chip drivers in memory while anyone uses
> their/proc entries. This also brings back compatibility with the 2.4
> Linux kernel.

This was step #4, restoring module reference counting for chip drivers.
At this point, binary and source compatibility with Linux 2.4 is
completely restored (at least as far as reference counting is
concerned), although it was almost already done at step #3.

Last step is to make bus drivers dependent from chip drivers as soon as
a client registers /proc entries.

And then we are ready to release 2.9.0 :)

-- 
Jean Delvare
http://khali.linux-fr.org/
