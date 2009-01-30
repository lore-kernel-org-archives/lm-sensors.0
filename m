From: Jean Delvare <khali@linux-fr.org>
Date: Fri, 30 Jan 2009 17:36:28 +0000
Subject: [lm-sensors] [PATCH 0/4] ds1621 driver improvements
Message-Id: <20090130183628.378bf6ea@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here are 4 patches improving the ds1621 hardware monitoring driver.
This set replaces the previous set I sent on January 16th. Most
important changes are:
* Dropped the patch implementing high resolution temperature readings.
  It didn't work on all DS1621 chips. A proper implementation that
  would follow the recommendations of the manufacturer would be very
  costly (switching the chip to one-shot mode) and probably not worth
  it. As a replacement, I added a documentation update patch to no
  longer mention high resolution temperature readings.
* Dropped the patch adding delay between writes. Aurelien and myself
  tried to get writes to fail but never could. So there's nothing to
  fix.

Testers welcome.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
