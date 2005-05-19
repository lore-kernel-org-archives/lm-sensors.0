From: laytonjb@comcast.net (Jeffrey B. Layton)
Date: Thu, 19 May 2005 06:24:30 +0000
Subject: Problems with 2.4.22 kernel with 2.8.2
Message-Id: <3FE79F84.7090702@comcast.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hello,

   I'm having trouble with a 2.4.22 kernel I just built
with patches from i2c-2.8.2 and lm_sensors-2.8.2.
I've built some previous kernels (2.4.21) with the
2.8.0 patches and they have worked fine.
   Anyway, here are the lines in my /etc/rc.d/rc.local
file:

#----cut here----
# I2C adapter drivers
/sbin/modprobe i2c-sis630
/sbin/modprobe i2c-isa
# I2C chip drivers
/sbin/modprobe eeprom
/sbin/modprobe sis5595
#/sbin/modprobe it87
/sbin/modprobe it87 temp_type=0x31
#----cut here----

When I try running modprobe by hand on the first line,
I get the following,


# /sbin/modprobe i2c-sis630
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved symbol 
i2c_add_adapter_Rb2b6afaa
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved symbol 
i2c_del_adapter_Rf78dd64d
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod 
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o failed
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod i2c-sis630 
failed
[root@admin1 rc.d]# /sbin/modprobe i2c-sis630
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved symbol 
i2c_add_adapter_Rb2b6afaa
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: unresolved symbol 
i2c_del_adapter_Rf78dd64d
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod 
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o failed
/lib/modules/2.4.22N/kernel/drivers/i2c/i2c-sis630.o: insmod i2c-sis630 
failed


(BTW, this is a ECS P6STP-FN motherboard with a
SiS630 chipset).
   This has worked before and I just wanted to update the
kernel and lm_sensors. Any ideas what I screwed up?
(oh, this was compiled with gcc-3.2.2).

Thanks!

Jeff

