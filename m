From: zdavatz@ywesee.com (Zeno R.R. Davatz)
Date: Thu, 19 May 2005 06:23:56 +0000
Subject: Testing ASUS PU-DLS
Message-Id: <1052831030.613.28.camel@zrr>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi

I just set up a new server with a ASUS PU-DLS Mainboard, 2 CPU, 3 Fans
and 2 HDD.

I would like to get lm-sensors running.

I done apt-get install lm-sensors (Debian user, 2.4.20, woody)

Then I done 'sensors-detect'.

That gave me:
 Sorry, no chips were detected.
 Either your sensors are not supported, or they are
 connected to an I2C bus adapter that we do not support.
 See doc/FAQ, doc/lm_sensors-FAQ.html, or ....

I got 'I20', 'I20 PCI' and 'I20 /proc support' compiled into my kernel.

I did not compile 'I20 Block/LAN/SCSI OSM' into the kernel.

Why would 'sensors-detect' not find any sensors?

Thanks for your help and time.

Zeno
