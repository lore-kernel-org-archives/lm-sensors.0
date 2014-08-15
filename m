From: atull <atull@opensource.altera.com>
Date: Fri, 15 Aug 2014 21:34:49 +0000
Subject: [lm-sensors] power supply gating with ltc2978
Message-Id: <alpine.DEB.2.02.1408151623140.21645@atx-linux-37>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>
Cc: Jean Delvare <jdelvare@suse.de>, lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>

Hello,

I am interested in adding functionality to be able to gate power supplies 
going through a ltc2978.  I see that there is a hwmon driver already 
existing (hwmon/pmbus/ltc2978.c).  I see some of the other hwmon drivers 
have MFD's.  It looks like this ltc driver would need a MFD and a 
regulator driver added.  However I don't see other pmbus hwmon drivers
using MFD.

So I am asking for recommendations and reservations on how to proceed here 
before I get too far with this.

Thanks,
Alan Tull


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
