From: Jean Delvare <khali@linux-fr.org>
Date: Wed, 25 Jun 2008 11:41:51 +0000
Subject: [lm-sensors] [PATCH 0/6] hwmon: (lm90) Driver enhancements
Message-Id: <20080625134151.64ac44a1@hyperion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

This set of 6 patches to the lm90 driver is the union of the 4 patches
I sent on May 28th [1] and the 2 patches Nate Case sent on June 24th
[2]. I decided to consolidate them into a single patch set because
Nate's patches had merge conflicts with mine.

[1] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-May/023250.html
[2] http://lists.lm-sensors.org/pipermail/lm-sensors/2008-June/023536.html

My patches essentially improve the MAX6657 support while Nate's
patches essentially improve the ADT7461 support. This patch set applies
cleanly on top of kernel 2.6.26-rc8.

The patches can temporarily be downloaded from the following location
too:
  http://jdelvare.pck.nerim.net/sensors/lm90/

Thanks,
-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
