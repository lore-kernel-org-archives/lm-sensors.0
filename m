From: Nikolaus Schulz <mail@microschulz.de>
Date: Tue, 28 Feb 2012 21:15:50 +0000
Subject: [lm-sensors] [v2] (f75375s) More fixes for the F75387
Message-Id: <1330463755-5763-1-git-send-email-mail@microschulz.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi,

here is v2 of my second batch of fixes for the F75387 chip.  Applies to
hwmon-next.

The changes requested by Guenter went in, and I have dropped the bogus
hysteresis register patch.  I still hope these patches can make it to
Linux 3.3.

[Copy of introductory message from v1 of the patch series follows]

While the support for the F75387 is still quite incomplete, these
patches hopefully improve the situation, fixing a couple of bugs I've
found while working on automatic fan control configuration support for
this driver.

Note that one patch introduces a small change in the sysfs API for the
F75387; I hope this is tolerable, as support for this chip has not yet
been part of a stable kernel release.

Nikolaus

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
