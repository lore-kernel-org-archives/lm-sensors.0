From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 03 May 2008 13:17:36 +0000
Subject: [lm-sensors] Premilinary driver for the Asus F8000
Message-Id: <20080503151736.222c40d1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

I wrote a preliminary driver for the Asus F8000 Super-I/O chip. No
datasheet available, so this is guess work, based on our knowledge of
Fintek Super-I/O chips - as apparently this chip was designed by Fintek
for Asus. To play it safe, the driver doesn't write to registers, all
reported values are read only.

The driver is available here for now:
http://jdelvare.pck.nerim.net/sensors/f8000/

Testers and reviewers are welcome. I will submit the driver as a patch
for upstream inclusion later.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
