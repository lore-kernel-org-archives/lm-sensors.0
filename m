From: Nikolaus Schulz <mail@microschulz.de>
Date: Wed, 22 Feb 2012 22:18:43 +0000
Subject: [lm-sensors] (f75375s) More fixes for the F75387
Message-Id: <1329949129-4265-1-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

here is a second batch of fixes for the F75387 chip.  I hope they
can make it to Linux 3.3.

While the support for the F75387 is still quite incomplete, these
patches hopefully improve the situation, fixing a couple of bugs I've
found while working on automatic fan control configuration support for
this driver.

Note that one patch introduces a small change in the sysfs API for the
F75387; I hope this is tolerable, as support for this chip has not yet
been part of a stable kernel release.

Thanks,
Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
