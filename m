From: jk <lm_sensors@kosowsky.org>
Date: Fri, 06 Apr 2007 05:21:25 +0000
Subject: [lm-sensors] =?utf-8?q?asb=5F100_sensor_location_in_/sys_heirarch?=
Message-Id: <loom.20070406T071342-850@post.gmane.org>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

I have a p4pe board with the asb_100 sensor running under linux 2.6.20.

I now notice that the sensors location varies between
/sys/bus/i2c/drivers/asb100/0-002d and /sys/bus/i2c/drivers/asb100/2-002d
between reboots.

This creates problems for me since I use sensord and a crontab entry to read the
sensors but now the location of the sensors in /sys varies with each boot.

Is this a bug?
If not is there a way to fix the location of the sensor directory in the /sys
heirarch? (Otherwise, I will need to write some klugey shell script to try to
find the location at boot-up and then automatically change the crontab entry
accordingly.

Thanks!




_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
