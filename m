From: Peter Hung <hpeter@gmail.com>
Date: Thu, 25 Jun 2015 07:30:15 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon:f71882fg add new Fintek SuperIO support
Message-Id: <1435217418-26249-1-git-send-email-hpeter+linux_kernel@gmail.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: jdelvare@suse.de, linux@roeck-us.net
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org, tom_tsai@fintek.com.tw, peter_hong@fintek.com.tw, Peter Hung <hpeter+linux_kernel@gmail.com>

The first patch will add Fintek F81866/F71868 SuperIO
with H/W monitor function to f71882fg.c

But some F81866 functional address is differ from F71882fg. 
The following 2 patches will fix this problem.

Peter Hung (3):
  hwmon:f71882fg add f81866/f71868 SuperIO support
  hwmon:f71882fg fix f81866a temp/beep setting
  hwmon:f71882fg fix f81866a voltage protection

 drivers/hwmon/f71882fg.c | 160 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 129 insertions(+), 31 deletions(-)

-- 
1.9.1


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
