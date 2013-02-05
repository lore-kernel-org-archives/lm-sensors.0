From: Dag Wieers <dag@wieers.com>
Date: Tue, 05 Feb 2013 09:08:49 +0000
Subject: [lm-sensors] i2c-i801 on AppleTV (1st gen)
Message-Id: <alpine.LRH.2.02.1302050844220.2736@pikachu.3ti.be>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

For the OpenELEC project I am looking into enabling the i2c-i801 interface 
for getting more system information (voltage, temperature, fan).

The AppleTV (1st Gen) has a N10/ICH 7 Family SMBus Controller (8086:27da) 
device that is supported by i2c-i801, but I haven't been able to get 
anything to work apart from loading the driver.

   00:1f.3 SMBus: Intel Corporation N10/ICH 7 Family SMBus Controller (rev 02)
           Subsystem: Intel Corporation Device 7270
           Flags: medium devsel, IRQ 19
           I/O ports at efa0 [size2]
           Kernel driver in use: i801_smbus
           Kernel modules: i2c-i801

(Lacking perl, I haven't been able to get sensors-detect working yet. We 
will have to add perl to the OpenELEC buildsystem for this)

I tried loading all sensors from kernel 3.7.5, to no avail.

Is there something I can do to test whether the i2c SMBus is at all 
functional ?

PS If needed, I can provide remote access to an AppleTV device.

Kind regards,
-- 
-- dag wieers, dag@wieers.com, http://dag.wieers.com/
-- dagit linux solutions, info@dagit.net, http://dagit.net/

[Any errors in spelling, tact or fact are transmission errors]

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
