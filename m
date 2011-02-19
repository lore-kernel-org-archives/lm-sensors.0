From: Jean Delvare <khali@linux-fr.org>
Date: Sat, 19 Feb 2011 13:12:19 +0000
Subject: [lm-sensors] [PATCH 0/4] Move lis3lv02d and hp_accel out of
Message-Id: <20110219141219.47aba4f8@endymion.delvare>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: lm-sensors@vger.kernel.org

Hi all,

Here is a patch set moving lis3lv02d and hp_accel out of drivers/hwmon.
hp_accel goes where it belongs, i.e. drivers/platform/x86 (next to
hdaps.) For lis3lv02d, I would have preferred a more specific home, but
none seems to be suitable at the moment, so I went for drivers/misc. We
might revisit this later.

[PATCH 1/4] Let Kconfig handle lis3lv02d dependencies
[PATCH 2/4] Move hp_accel to drivers/platform/x86
[PATCH 3/4] Move lis3lv02d drivers to drivers/misc
[PATCH 4/4] hp_accel: Fix driver name

As with every patch moving files around, the patches look very large
but most of them can be ignored, all you really have to look at are the
Kconfig and Makefile changes.

Note that I don't have supported hardware so I wasn't able to test the
patches. So I would welcome testing as much as review.

-- 
Jean Delvare

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
