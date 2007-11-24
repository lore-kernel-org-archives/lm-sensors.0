From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Date: Sat, 24 Nov 2007 17:33:33 +0000
Subject: [lm-sensors] Linux 2.6.24-rc* regression: sensors says "No sensors
Message-Id: <4748606D.6050501@s5r6.in-berlin.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@lm-sensors.org
Cc: linux-kernel@vger.kernel.org

I just booted 2.6.24-rc3 on two different PCs, one with i945 based MSI
motherboard and i386 kernel and one with i945 based Apple motherboard
and x86-64 kernel.  Before that I ran linux 2.6.23.

On both PCs, "sensors" exits with
> No sensors found!
> Make sure you loaded all the kernel drivers you need.
> Try sensors-detect to find out which these are.

Modules loaded on the i386, among others:
coretemp, w83627ehf, hwmon_vid, hwmon

Modules loaded on the x86-64, among others:
i2c_dev, applesmc, led_class, input_polldev, coretemp, hwmon, eeprom

The configuration scripts are the same as I used them under 2.6.23.
sensors-detect doesn't come up with anything which I didn't know and had
configured already.  On both PCs:
$ sensors -v
sensors version 2.10.4 with libsensors version 2.10.4
-- 
Stefan Richter
-===-=-== =-= =---
http://arcgraph.de/sr/

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
