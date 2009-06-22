From: Dennis Jordan <dejord@web.de>
Date: Mon, 22 Jun 2009 21:32:51 +0000
Subject: [lm-sensors] =?iso-8859-15?q?Intel=AE_Desktop_Board_D945GSEJT?=
Message-Id: <4A3FF883.5080607@web.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi there,

I'm getting sick by trying to install lm-sensors for this mainboard with 
xubuntu 9.04.

Finally no sensors are found. When I try to use the most recent 
sensors-detect script it says:

Driver `w83627ehf':
  * ISA bus, address 0xa00
    Chip `Winbond W83627DHG-P Super IO Sensors' (confidence: 9)

But if I try to load that module it says:

sudo modprobe w83627ehf
WARNING: All config files need .conf: /etc/modprobe.d/oss-compat, it 
will be ignored in a future release.
FATAL: Error inserting w83627ehf 
(/lib/modules/2.6.28-13-generic/kernel/drivers/hwmon/w83627ehf.ko): No 
such device

I don't know what to do to finally use lm-sensors. Due to the fact I'm 
using a fanless system here I don't want to sit in the dark regarding 
temperature for my CPU.

Thanks for any support here.

Kind regards
Dennis


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
