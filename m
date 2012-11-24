From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 24 Nov 2012 05:27:07 +0000
Subject: [lm-sensors] MAX1363 IIO driver questions
Message-Id: <20121124052707.GA17392@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, Jean Delvare <khali@linux-fr.org>, lm-sensors@lm-sensors.org

Hi all,

What would it take to move the MAX1363 driver out of staging ?

Background is that I need a hardware monitoring driver for MAX1139, and would
like to avoid using a driver from staging if possible (after all, it might
go away anytime). Another option would be to submit a hwmon driver for it,
but that doesn't seem to be the best approach.

Thanks,
Guenter

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
