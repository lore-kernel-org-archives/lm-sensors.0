From: Guenter Roeck <linux@roeck-us.net>
Date: Sat, 23 Nov 2013 06:07:56 +0000
Subject: [lm-sensors] [PATCH 0/5] net: hwmon fixes
Message-Id: <1385186881-7931-1-git-send-email-linux@roeck-us.net>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>, Jeff Kirsher <jeffrey.t.kirsher@intel.com>, Jesse Brandeburg <jesse.brandeburg@intel.com>, Bruce Allan <bruce.w.allan@intel.com>, Carolyn Wyborny <carolyn.wyborny@intel.com>, Don Skidmore <donald.c.skidmore@intel.com>, Greg Rose <gregory.v.rose@intel.com>, Nithin Nayak Sujir <nsujir@broadcom.com>, Michael Chan <mchan@broadcom.com>, e1000-devel@lists.sourceforge.net, lm-sensors@lm-sensors.org, Guenter Roeck <linux@roeck-us.net>

The hwmon subsystem is used by various network drivers to report temperature
sensor and other information. Unfortunately, its use is often not correct.
Typical errors are that the mandatory name sysfs attribute is not created,
that the temperature sensor index starts with 0 instead of 1, and/or that
sysfs attributes are created after the hwmon device was created.
The following sequence of patches fixes most of the problems.

The igb patches have been tested with real hardware; the others are compile
tested only.

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
