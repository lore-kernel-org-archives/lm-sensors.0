From: "Mark M. Hoffman" <mhoffman@lightlink.com>
Date: Tue, 31 Jul 2007 01:39:58 +0000
Subject: [lm-sensors] [PATCH] hwmon: Fix regression caused by typo in lm90.c
Message-Id: <11858460011331-git-send-email-mhoffman@lightlink.com>
List-Id: <lm-sensors.vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: lm-sensors@vger.kernel.org

From: Guillaume Chazarain <guichaz@yahoo.fr>

The commit http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commitdiff;h2c82a934759b2c9939c9e25865c2d7d1204b9e8
broke lm90 for my (Asus V6VA) laptop.

Before 2.6.23-rc1 and with the following patch, I get:

[g ~]$ sensors
max6657-i2c-0-4c
Adapter: SMBus I801 adapter at 0400
M/B Temp:    +64Â°C  (low  =    +0Â°C, high =  +127Â°C)
CPU Temp:  +78.9Â°C  (low  = +73.2Â°C, high = +88.2Â°C)
M/B Crit:   +105Â°C  (hyst =   +95Â°C)
CPU Crit:   +105Â°C  (hyst =   +95Â°C)

Which regressed into:

[g ~]$ sensors
No sensors found!
Make sure you loaded all the kernel drivers you need.
Try sensors-detect to find out which these are.
zsh: 2701 exit 1     sensors

and dmesg contains:

i2c-adapter i2c-0: Unsupported chip (man_id=0x4D, chip_id=0x4D).

It seems to be a typo, as address 0X4F is mentionned nowhere else in the file,
and my chip is actually at 0x4C.

Signed-off-by: Guillaume Chazarain <guichaz@yahoo.fr>
Signed-off-by: Jean Delvare <khali@linux-fr.org>
Signed-off-by: Mark M. Hoffman <mhoffman@lightlink.com>
---
 drivers/hwmon/lm90.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/hwmon/lm90.c b/drivers/hwmon/lm90.c
index 48833ff..af541d6 100644
--- a/drivers/hwmon/lm90.c
+++ b/drivers/hwmon/lm90.c
@@ -585,7 +585,7 @@ static int lm90_detect(struct i2c_adapter *adapter, int address, int kind)
 			 * those of the man_id register.
 			 */
 			if (chip_id = man_id
-			 && (address = 0x4F || address = 0x4D)
+			 && (address = 0x4C || address = 0x4D)
 			 && (reg_config1 & 0x1F) = (man_id & 0x0F)
 			 && reg_convrate <= 0x09) {
 			 	kind = max6657;
-- 
1.5.2.2


_______________________________________________
lm-sensors mailing list
lm-sensors@lm-sensors.org
http://lists.lm-sensors.org/mailman/listinfo/lm-sensors
