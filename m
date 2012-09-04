From: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Tue, 04 Sep 2012 08:40:06 +0000
Subject: [lm-sensors] [PATCH 0/2] hwmon/lm70: changes to allow 4w with LM70 and add LM71/LM74
Message-Id: <201209040840.q848e6jj028964@localhost.localdomain>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Jean Delvare <khali@linux-fr.org>, Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, lm-sensors@lm-sensors.org

Hello,

The two following patches do:
1) Allow the use of NS LM70 with a 4 wire SPI bus too, since the component allows both configuration
2) Adds support for NS LM71 and LM74

Regards
Christophe


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
