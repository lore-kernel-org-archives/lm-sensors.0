From: Clemens Ladisch <clemens@ladisch.de>
Date: Wed, 16 Feb 2011 13:00:55 +0000
Subject: [lm-sensors] [PATCH 0/3] hwmon: some jc42 changes
Message-Id: <4D5BCA87.7010204@ladisch.de>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <khali@linux-fr.org>
Cc: lm-sensors@lm-sensors.org, linux-kernel@vger.kernel.org

Some small bugfixes and enhancements.

 Documentation/hwmon/jc42 |   21 +++++++++++++++------
 drivers/hwmon/Kconfig    |   11 ++++++-----
 drivers/hwmon/jc42.c     |   35 ++++++++++++++++++++++++++++++-----
 3 files changed, 51 insertions(+), 16 deletions(-)

_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
