From: Michal Marek <mmarek@suse.cz>
Date: Wed, 28 Oct 2015 10:03:08 +0000
Subject: [lm-sensors] Duplicate htu21 drivers
Message-Id: <56309D5C.30008@suse.cz>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: William Markezana <william.markezana@meas-spec.com>, Jean Delvare <jdelvare@suse.com>, Guenter Roeck <linux@roeck-us.net>, Ludovic Tancerel <ludovic.tancerel@maplehightech.com>, Jonathan Cameron <jic23@kernel.org>
Cc: lm-sensors@lm-sensors.org, linux-iio@vger.kernel.org

Hi,

commit 2b5c53d2c958 ("Add htu21 meas-spec driver support") introduced a
new implementation of the htu21 driver into drivers/iio/humidity. At
first glance, it provides the same features as drivers/hwmon/htu21 with
a different sysfs interface. What is the plan with these two drivers?
Will the iio driver replace the hwmon one? At a minimum, they should
conflict in kconfig, because module names must be unique.

Thanks,
Michal

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
